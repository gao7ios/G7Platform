#include "common.h"

extern struct uwsgi_server uwsgi;

static sapi_module_struct uwsgi_sapi_module;

struct uwsgi_php {
	struct uwsgi_string_list *allowed_docroot;
	struct uwsgi_string_list *allowed_ext;
	struct uwsgi_string_list *allowed_scripts;
	struct uwsgi_string_list *index;
	struct uwsgi_string_list *set;
	struct uwsgi_string_list *append_config;
#ifdef UWSGI_PCRE
	struct uwsgi_regexp_list *app_bypass;
#endif
	struct uwsgi_string_list *vars;
	char *docroot;
	char *app;
	char *app_qs;
	char *fallback;
	size_t ini_size;
	int dump_config;
	char *server_software;
	size_t server_software_len;

	struct uwsgi_string_list *exec_before;
	struct uwsgi_string_list *exec_after;

	char *sapi_name;
} uphp;

void uwsgi_opt_php_ini(char *opt, char *value, void *foobar) {
	uwsgi_sapi_module.php_ini_path_override = uwsgi_str(value);
        uwsgi_sapi_module.php_ini_ignore = 1;
}

struct uwsgi_option uwsgi_php_options[] = {

        {"php-ini", required_argument, 0, "set php.ini path", uwsgi_opt_php_ini, NULL, 0},
        {"php-config", required_argument, 0, "set php.ini path", uwsgi_opt_php_ini, NULL, 0},
        {"php-ini-append", required_argument, 0, "set php.ini path (append mode)", uwsgi_opt_add_string_list, &uphp.append_config, 0},
        {"php-config-append", required_argument, 0, "set php.ini path (append mode)", uwsgi_opt_add_string_list, &uphp.append_config, 0},
        {"php-set", required_argument, 0, "set a php config directive", uwsgi_opt_add_string_list, &uphp.set, 0},
        {"php-index", required_argument, 0, "list the php index files", uwsgi_opt_add_string_list, &uphp.index, 0},
        {"php-docroot", required_argument, 0, "force php DOCUMENT_ROOT", uwsgi_opt_set_str, &uphp.docroot, 0},
        {"php-allowed-docroot", required_argument, 0, "list the allowed document roots", uwsgi_opt_add_string_list, &uphp.allowed_docroot, 0},
        {"php-allowed-ext", required_argument, 0, "list the allowed php file extensions", uwsgi_opt_add_string_list, &uphp.allowed_ext, 0},
        {"php-allowed-script", required_argument, 0, "list the allowed php scripts (require absolute path)", uwsgi_opt_add_string_list, &uphp.allowed_scripts, 0},
        {"php-server-software", required_argument, 0, "force php SERVER_SOFTWARE", uwsgi_opt_set_str, &uphp.server_software, 0},
        {"php-app", required_argument, 0, "force the php file to run at each request", uwsgi_opt_set_str, &uphp.app, 0},
        {"php-app-qs", required_argument, 0, "when in app mode force QUERY_STRING to the specified value + REQUEST_URI", uwsgi_opt_set_str, &uphp.app_qs, 0},
        {"php-fallback", required_argument, 0, "run the specified php script when the request one does not exist", uwsgi_opt_set_str, &uphp.fallback, 0},
#ifdef UWSGI_PCRE
        {"php-app-bypass", required_argument, 0, "if the regexp matches the uri the --php-app is bypassed", uwsgi_opt_add_regexp_list, &uphp.app_bypass, 0},
#endif
        {"php-var", required_argument, 0, "add/overwrite a CGI variable at each request", uwsgi_opt_add_string_list, &uphp.vars, 0},
        {"php-dump-config", no_argument, 0, "dump php config (if modified via --php-set or append options)", uwsgi_opt_true, &uphp.dump_config, 0},
        {"php-exec-before", required_argument, 0, "run specified php code before the requested script", uwsgi_opt_add_string_list, &uphp.exec_before, 0},
        {"php-exec-begin", required_argument, 0, "run specified php code before the requested script", uwsgi_opt_add_string_list, &uphp.exec_before, 0},
        {"php-exec-after", required_argument, 0, "run specified php code after the requested script", uwsgi_opt_add_string_list, &uphp.exec_after, 0},
        {"php-exec-end", required_argument, 0, "run specified php code after the requested script", uwsgi_opt_add_string_list, &uphp.exec_after, 0},
        {"php-sapi-name", required_argument, 0, "hack the sapi name (required for enabling zend opcode cache)", uwsgi_opt_set_str, &uphp.sapi_name, 0},
	UWSGI_END_OF_OPTIONS
};


static int sapi_uwsgi_ub_write(const char *str, uint str_length TSRMLS_DC)
{
	struct wsgi_request *wsgi_req = (struct wsgi_request *) SG(server_context);

	uwsgi_response_write_body_do(wsgi_req, (char *) str, str_length);
	if (wsgi_req->write_errors > uwsgi.write_errors_tolerance) {
		php_handle_aborted_connection();
		return -1;
	}
	return str_length;
}

static int sapi_uwsgi_send_headers(sapi_headers_struct *sapi_headers TSRMLS_DC)
{
	sapi_header_struct *h;
	zend_llist_position pos;

	if (SG(request_info).no_headers == 1) {
                return SAPI_HEADER_SENT_SUCCESSFULLY;
        }

	struct wsgi_request *wsgi_req = (struct wsgi_request *) SG(server_context);

	if (!SG(sapi_headers).http_status_line) {
		char status[4];
		int hrc = SG(sapi_headers).http_response_code;
		if (!hrc) hrc = 200;
		uwsgi_num2str2n(hrc, status, 4);
		if (uwsgi_response_prepare_headers(wsgi_req, status, 3))
			return SAPI_HEADER_SEND_FAILED;
	}
	else {
		char *sl = SG(sapi_headers).http_status_line;
		if (uwsgi_response_prepare_headers(wsgi_req, sl + 9 , strlen(sl + 9)))
			return SAPI_HEADER_SEND_FAILED;
	}
	
	h = zend_llist_get_first_ex(&sapi_headers->headers, &pos);
	while (h) {
		uwsgi_response_add_header(wsgi_req, NULL, 0, h->header, h->header_len);
		h = zend_llist_get_next_ex(&sapi_headers->headers, &pos);
	}

	return SAPI_HEADER_SENT_SUCCESSFULLY;
}

static int sapi_uwsgi_read_post(char *buffer, uint count_bytes TSRMLS_DC)
{
	uint read_bytes = 0;
	
	struct wsgi_request *wsgi_req = (struct wsgi_request *) SG(server_context);

        count_bytes = MIN(count_bytes, wsgi_req->post_cl - SG(read_post_bytes));

        while (read_bytes < count_bytes) {
		ssize_t rlen = 0;
		char *buf = uwsgi_request_body_read(wsgi_req, count_bytes - read_bytes, &rlen);
		if (buf == uwsgi.empty) break;
		if (buf) {
			memcpy(buffer, buf, rlen);
			read_bytes += rlen;
			continue;
		}
		break;
        }

        return read_bytes;
}


static char *sapi_uwsgi_read_cookies(TSRMLS_D)
{
	uint16_t len = 0;
	struct wsgi_request *wsgi_req = (struct wsgi_request *) SG(server_context);

	char *cookie = uwsgi_get_var(wsgi_req, (char *)"HTTP_COOKIE", 11, &len);
	if (cookie) {
		return estrndup(cookie, len);
	}

	return NULL;
}

static void sapi_uwsgi_register_variables(zval *track_vars_array TSRMLS_DC)
{
	int i;
	struct wsgi_request *wsgi_req = (struct wsgi_request *) SG(server_context);
	php_import_environment_variables(track_vars_array TSRMLS_CC);

	if (uphp.server_software) {
		if (!uphp.server_software_len) uphp.server_software_len = strlen(uphp.server_software);
		php_register_variable_safe("SERVER_SOFTWARE", uphp.server_software, uphp.server_software_len, track_vars_array TSRMLS_CC);
	}
	else {
		php_register_variable_safe("SERVER_SOFTWARE", "uWSGI", 5, track_vars_array TSRMLS_CC);
	}

	for (i = 0; i < wsgi_req->var_cnt; i += 2) {
		php_register_variable_safe( estrndup(wsgi_req->hvec[i].iov_base, wsgi_req->hvec[i].iov_len),
			wsgi_req->hvec[i + 1].iov_base, wsgi_req->hvec[i + 1].iov_len,
			track_vars_array TSRMLS_CC);
        }

	php_register_variable_safe("PATH_INFO", wsgi_req->path_info, wsgi_req->path_info_len, track_vars_array TSRMLS_CC);
	if (wsgi_req->query_string_len > 0) {
		php_register_variable_safe("QUERY_STRING", wsgi_req->query_string, wsgi_req->query_string_len, track_vars_array TSRMLS_CC);
	}

	php_register_variable_safe("SCRIPT_NAME", wsgi_req->script_name, wsgi_req->script_name_len, track_vars_array TSRMLS_CC);
	php_register_variable_safe("SCRIPT_FILENAME", wsgi_req->file, wsgi_req->file_len, track_vars_array TSRMLS_CC);

	php_register_variable_safe("DOCUMENT_ROOT", wsgi_req->document_root, wsgi_req->document_root_len, track_vars_array TSRMLS_CC);

	if (wsgi_req->path_info_len) {
		char *path_translated = ecalloc(1, wsgi_req->file_len + wsgi_req->path_info_len + 1);

		memcpy(path_translated, wsgi_req->file, wsgi_req->file_len);
		memcpy(path_translated + wsgi_req->file_len, wsgi_req->path_info, wsgi_req->path_info_len);
		php_register_variable_safe("PATH_TRANSLATED", path_translated, wsgi_req->file_len + wsgi_req->path_info_len , track_vars_array TSRMLS_CC);
	}
	else {
		php_register_variable_safe("PATH_TRANSLATED", "", 0, track_vars_array TSRMLS_CC);
	}

	php_register_variable_safe("PHP_SELF", wsgi_req->script_name, wsgi_req->script_name_len, track_vars_array TSRMLS_CC);

	struct uwsgi_string_list *usl = uphp.vars;
	while(usl) {
		char *equal = strchr(usl->value, '=');
		if (equal) {
			php_register_variable_safe( estrndup(usl->value, equal-usl->value),
				equal+1, strlen(equal+1), track_vars_array TSRMLS_CC);
		}
		usl = usl->next;
	}


}

static sapi_module_struct uwsgi_sapi_module;




void uwsgi_php_append_config(char *filename) {
	size_t file_size = 0;
        char *file_content = uwsgi_open_and_read(filename, &file_size, 1, NULL);
	uwsgi_sapi_module.ini_entries = realloc(uwsgi_sapi_module.ini_entries, uphp.ini_size + file_size);
	memcpy(uwsgi_sapi_module.ini_entries + uphp.ini_size, file_content, file_size);
	uphp.ini_size += file_size-1;
	free(file_content);
}

void uwsgi_php_set(char *opt) {

	uwsgi_sapi_module.ini_entries = realloc(uwsgi_sapi_module.ini_entries, uphp.ini_size + strlen(opt)+2);
	memcpy(uwsgi_sapi_module.ini_entries + uphp.ini_size, opt, strlen(opt));

	uphp.ini_size += strlen(opt)+1;
	uwsgi_sapi_module.ini_entries[uphp.ini_size-1] = '\n';
	uwsgi_sapi_module.ini_entries[uphp.ini_size] = 0;
}

extern ps_module ps_mod_uwsgi;
PHP_MINIT_FUNCTION(uwsgi_php_minit) {
	php_session_register_module(&ps_mod_uwsgi);
	return SUCCESS;
}

PHP_FUNCTION(uwsgi_version) {
	RETURN_STRING(UWSGI_VERSION, 1);
}

PHP_FUNCTION(uwsgi_worker_id) {
	RETURN_LONG(uwsgi.mywid);
}

PHP_FUNCTION(uwsgi_masterpid) {
	if (uwsgi.master_process) {
		RETURN_LONG(uwsgi.workers[0].pid);
	}
	RETURN_LONG(0);
}

PHP_FUNCTION(uwsgi_cache_exists) {

        char *key = NULL;
        int keylen = 0;
        char *cache = NULL;
        int cachelen = 0;

        if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "s|s", &key, &keylen, &cache, &cachelen) == FAILURE) {
                RETURN_NULL();
        }

        if (uwsgi_cache_magic_exists(key, keylen, cache)) {
                RETURN_TRUE;
        }

        RETURN_NULL();
}

PHP_FUNCTION(uwsgi_cache_clear) {

        char *cache = NULL;
        int cachelen = 0;

        if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "|s", &cache, &cachelen) == FAILURE) {
                RETURN_NULL();
        }

        if (!uwsgi_cache_magic_clear(cache)) {
                RETURN_TRUE;
        }

        RETURN_NULL();
}


PHP_FUNCTION(uwsgi_cache_del) {
	
	char *key = NULL;
        int keylen = 0;
	char *cache = NULL;
	int cachelen = 0;

        if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "s|s", &key, &keylen, &cache, &cachelen) == FAILURE) {
                RETURN_NULL();
        }

        if (!uwsgi_cache_magic_del(key, keylen, cache)) {
		RETURN_TRUE;
        }

	RETURN_NULL();
}

PHP_FUNCTION(uwsgi_cache_get) {

	char *key = NULL;
	int keylen = 0;
	char *cache = NULL;
	int cachelen = 0;
	uint64_t valsize;

	if (!uwsgi.caches)
		RETURN_NULL();

	if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "s|s", &key, &keylen, &cache, &cachelen) == FAILURE) {
                RETURN_NULL();
        }

	char *value = uwsgi_cache_magic_get(key, keylen, &valsize, NULL, cache);
	if (value) {
		char *ret = estrndup(value, valsize);
		free(value);
		RETURN_STRING(ret, 0);
	}
	RETURN_NULL();
}

PHP_FUNCTION(uwsgi_cache_set) {
	char *key = NULL;	
	int keylen;
	char *value = NULL;
	int vallen;
	uint64_t expires = 0;
	char *cache = NULL;
	int cachelen = 0;

	if (!uwsgi.caches)
		RETURN_NULL();

	if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "ss|ls", &key, &keylen, &value, &vallen, &expires, &cache, &cachelen) == FAILURE) {
                RETURN_NULL();
        }

	if (!uwsgi_cache_magic_set(key, keylen, value, vallen, expires, 0, cache)) {
		RETURN_TRUE;
	}
	RETURN_NULL();
	
}

PHP_FUNCTION(uwsgi_cache_update) {
        char *key = NULL;
        int keylen;
        char *value = NULL;
        int vallen;
        uint64_t expires = 0;
        char *cache = NULL;
        int cachelen = 0;

        if (!uwsgi.caches)
                RETURN_NULL();

        if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "ss|ls", &key, &keylen, &value, &vallen, &expires, &cache, &cachelen) == FAILURE) {
                RETURN_NULL();
        }

        if (!uwsgi_cache_magic_set(key, keylen, value, vallen, expires, UWSGI_CACHE_FLAG_UPDATE, cache)) {
                RETURN_TRUE;
        }
        RETURN_NULL();

}


PHP_FUNCTION(uwsgi_rpc) {


	int num_args = 0;
	int i;
	char *node = NULL;
	char *func = NULL;
	zval ***varargs = NULL;
	zval *z_current_obj;
	char *argv[256];
        uint16_t argvs[256];
	uint64_t size = 0;

	if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "+", &varargs, &num_args) == FAILURE) {
		RETURN_NULL();
	}

        if (num_args < 2)
		goto clear;

	if (num_args > 256 + 2)
		goto clear;

	z_current_obj = *varargs[0];
	if (Z_TYPE_P(z_current_obj) != IS_STRING) {
		goto clear;
	}

	node = Z_STRVAL_P(z_current_obj);

	z_current_obj = *varargs[1];
	if (Z_TYPE_P(z_current_obj) != IS_STRING) {
		goto clear;
	}

	func = Z_STRVAL_P(z_current_obj);

	for(i=0;i<(num_args-2);i++) {
		z_current_obj = *varargs[i+2];
		if (Z_TYPE_P(z_current_obj) != IS_STRING) {
			goto clear;
		}
		argv[i] = Z_STRVAL_P(z_current_obj);
		argvs[i] = Z_STRLEN_P(z_current_obj);
	}

	// response must always be freed
        char *response = uwsgi_do_rpc(node, func, num_args - 2, argv, argvs, &size);
        if (response) {
		// here we do not free varargs for performance reasons
		char *ret = estrndup(response, size);
		free(response);
		RETURN_STRING(ret, 0);
        }

clear:
	efree(varargs);
	RETURN_NULL();

}


PHP_FUNCTION(uwsgi_setprocname) {

	char *name;
	int name_len;

	if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "s", &name, &name_len) == FAILURE) {
		RETURN_NULL();
	}

	uwsgi_set_processname(estrndup(name, name_len));

	RETURN_NULL();
}

PHP_FUNCTION(uwsgi_signal) {

	long long_signum;
	uint8_t signum = 0;

        if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "l", &long_signum) == FAILURE) {
                RETURN_NULL();
        }

	signum = (uint8_t) long_signum;
	uwsgi_signal_send(uwsgi.signal_socket, signum);

        RETURN_NULL();
}

zend_function_entry uwsgi_php_functions[] = {
	PHP_FE(uwsgi_version,   NULL)
	PHP_FE(uwsgi_setprocname,   NULL)
	PHP_FE(uwsgi_worker_id,   NULL)
	PHP_FE(uwsgi_masterpid,   NULL)
	PHP_FE(uwsgi_signal,   NULL)

	PHP_FE(uwsgi_rpc,   NULL)

	PHP_FE(uwsgi_cache_get,   NULL)
	PHP_FE(uwsgi_cache_set,   NULL)
	PHP_FE(uwsgi_cache_update,   NULL)
	PHP_FE(uwsgi_cache_del,   NULL)
	PHP_FE(uwsgi_cache_clear,   NULL)
	PHP_FE(uwsgi_cache_exists,   NULL)
	{ NULL, NULL, NULL},
};

PHP_MINFO_FUNCTION(uwsgi_php_minfo) {
	php_info_print_table_start( );
	php_info_print_table_row(2, "uwsgi api", "enabled");
	if (uwsgi.caches) {
		php_info_print_table_row(2, "uwsgi cache", "enabled");
	}
	else {
		php_info_print_table_row(2, "uwsgi cache", "disabled");
	}
	php_info_print_table_end( );
}

static zend_module_entry uwsgi_module_entry = {
        STANDARD_MODULE_HEADER,
        "uwsgi",
        uwsgi_php_functions,
        PHP_MINIT(uwsgi_php_minit),
	NULL,
        NULL,
        NULL,
        PHP_MINFO(uwsgi_php_minfo),
        UWSGI_VERSION,
        STANDARD_MODULE_PROPERTIES
};


static int php_uwsgi_startup(sapi_module_struct *sapi_module)
{

	if (php_module_startup(&uwsgi_sapi_module, &uwsgi_module_entry, 1)==FAILURE) {
		return FAILURE;
	} else {
		return SUCCESS;
	}
}

static void sapi_uwsgi_log_message(char *message TSRMLS_DC) {

	uwsgi_log("%s\n", message);
}

static sapi_module_struct uwsgi_sapi_module = {
	"uwsgi",
	"uWSGI/php",
	
	php_uwsgi_startup,
	php_module_shutdown_wrapper,
	
	NULL,									/* activate */
	NULL,									/* deactivate */

	sapi_uwsgi_ub_write,
	NULL,
	NULL,									/* get uid */
	NULL,									/* getenv */

	php_error,
	
	NULL,
	sapi_uwsgi_send_headers,
	NULL,
	sapi_uwsgi_read_post,
	sapi_uwsgi_read_cookies,

	sapi_uwsgi_register_variables,
	sapi_uwsgi_log_message,									/* Log message */
	NULL,									/* Get request time */
	NULL,									/* Child terminate */

	STANDARD_SAPI_MODULE_PROPERTIES
};

int uwsgi_php_init(void) {

	struct uwsgi_string_list *pset = uphp.set;
	struct uwsgi_string_list *append_config = uphp.append_config;

#ifdef ZTS
        tsrm_startup(1, 1, 0, NULL);
#endif

	sapi_startup(&uwsgi_sapi_module);

	// applying custom options
	while(append_config) {
		uwsgi_php_append_config(append_config->value);
		append_config = append_config->next;
	}
       	while(pset) {
               	uwsgi_php_set(pset->value);
               	pset = pset->next;
       	}

	if (uphp.dump_config) {
		uwsgi_log("--- PHP custom config ---\n\n");
		uwsgi_log("%s\n", uwsgi_sapi_module.ini_entries);
		uwsgi_log("--- end of PHP custom config ---\n");
	}

	// fix docroot
        if (uphp.docroot) {
		char *orig_docroot = uphp.docroot;
		uphp.docroot = uwsgi_expand_path(uphp.docroot, strlen(uphp.docroot), NULL);
		if (!uphp.docroot) {
			uwsgi_log("unable to set php docroot to %s\n", orig_docroot);
			exit(1);
		}
	}

	if (uphp.sapi_name) {
		uwsgi_sapi_module.name = uphp.sapi_name;
	}
	uwsgi_sapi_module.startup(&uwsgi_sapi_module);
	uwsgi_log("PHP %s initialized\n", PHP_VERSION);

	return 0;
}

int uwsgi_php_walk(struct wsgi_request *wsgi_req, char *full_path, char *docroot, size_t docroot_len, char **path_info) {

        // and now start walking...
        uint16_t i;
        char *ptr = wsgi_req->path_info;
        char *dst = full_path+docroot_len;
        char *part = ptr;
        int part_size = 0;
        struct stat st;

	if (wsgi_req->path_info_len == 0) return 0;

        if (ptr[0] == '/') part_size++;

        for(i=0;i<wsgi_req->path_info_len;i++) {
                if (ptr[i] == '/') {
                        memcpy(dst, part, part_size-1);
                        *(dst+part_size-1) = 0;

                        if (stat(full_path, &st)) {
                                return -1;
                        }


                        // not a directory, stop walking
                        if (!S_ISDIR(st.st_mode)) {
                                if (i < (wsgi_req->path_info_len)-1) {
                                        *path_info = ptr + i;
                                }
                                return 0;
                        }


                        // check for buffer overflow !!!
                        *(dst+part_size-1) = '/';
                        *(dst+part_size) = 0;

                        dst += part_size ;
                        part_size = 0;
                        part = ptr + i + 1;
                }

                part_size++;
        }

        if (part < wsgi_req->path_info+wsgi_req->path_info_len) {
                memcpy(dst, part, part_size-1);
                *(dst+part_size-1) = 0;
        }

        return 0;


}


int uwsgi_php_request(struct wsgi_request *wsgi_req) {

	char real_filename[PATH_MAX+1];
	char *path_info = NULL;
	size_t real_filename_len = 0;
	struct stat php_stat;
	char *filename = NULL;
	int force_empty_script_name = 0;

	zend_file_handle file_handle;

#ifdef ZTS
	TSRMLS_FETCH();
#endif

	SG(server_context) = (void *) wsgi_req;

	if (uwsgi_parse_vars(wsgi_req)) {
		return -1;
	}

	char *orig_path_info = wsgi_req->path_info;
	uint16_t orig_path_info_len = wsgi_req->path_info_len;

	if (uphp.docroot) {
		wsgi_req->document_root = uphp.docroot;
	}
	// fallback to cwd
	else if (!wsgi_req->document_root_len) {
		wsgi_req->document_root = uwsgi.cwd;
	}
	else {
		// explode DOCUMENT_ROOT (both for security and sanity checks)
		// this memory will be cleared on request end
		char *sanitized_docroot = ecalloc(1, PATH_MAX+1);
		if (!uwsgi_expand_path(wsgi_req->document_root, wsgi_req->document_root_len, sanitized_docroot)) {
			efree(sanitized_docroot);
			return -1;
		}
		wsgi_req->document_root = sanitized_docroot;
	}

	// fix document_root_len
	wsgi_req->document_root_len = strlen(wsgi_req->document_root);

	if (uphp.app) {
#ifdef UWSGI_PCRE
		struct uwsgi_regexp_list *bypass = uphp.app_bypass;
		while (bypass) {
                        if (uwsgi_regexp_match(bypass->pattern, bypass->pattern_extra, wsgi_req->uri, wsgi_req->uri_len) >= 0) {
				goto oldstyle;
                        }
                        bypass = bypass->next;
                }
#endif

		strcpy(real_filename, uphp.app);	
		if (wsgi_req->path_info_len == 1 && wsgi_req->path_info[0] == '/') {
			goto appready;
		}
		if (uphp.app_qs) {
			size_t app_qs_len = strlen(uphp.app_qs);
			size_t qs_len = wsgi_req->path_info_len + app_qs_len;
			if (wsgi_req->query_string_len > 0) {
				qs_len += 1 + wsgi_req->query_string_len;
			}
			char *qs = ecalloc(1, qs_len+1);
			memcpy(qs, uphp.app_qs, app_qs_len);
			memcpy(qs+app_qs_len, wsgi_req->path_info, wsgi_req->path_info_len);
			if (wsgi_req->query_string_len > 0) {
				char *ptr = qs+app_qs_len+wsgi_req->path_info_len;
				*ptr = '&';
				memcpy(ptr+1, wsgi_req->query_string, wsgi_req->query_string_len);
			}
			wsgi_req->query_string = qs;
			wsgi_req->query_string_len = qs_len;
		}
appready:
		wsgi_req->path_info = "";
		wsgi_req->path_info_len = 0;
		force_empty_script_name = 1;
		goto secure2;
	}

#ifdef UWSGI_PCRE
oldstyle:
#endif

	filename = uwsgi_concat4n(wsgi_req->document_root, wsgi_req->document_root_len, "/", 1, wsgi_req->path_info, wsgi_req->path_info_len, "", 0);

	if (uwsgi_php_walk(wsgi_req, filename, wsgi_req->document_root, wsgi_req->document_root_len, &path_info)) {
		free(filename);
		if (uphp.fallback) {
			filename = uwsgi_str(uphp.fallback);
		}
		else {
			uwsgi_404(wsgi_req);
			return -1;
		}
	}

	if (path_info) {
		wsgi_req->path_info = path_info;
		wsgi_req->path_info_len = orig_path_info_len - (path_info - orig_path_info);
	}
	else {
		wsgi_req->path_info = "";
		wsgi_req->path_info_len = 0;
	}


	if (!realpath(filename, real_filename)) {
		free(filename);
		uwsgi_404(wsgi_req);
		return -1;
	}

	free(filename);
	real_filename_len = strlen(real_filename);

	if (uphp.allowed_docroot) {
		struct uwsgi_string_list *usl = uphp.allowed_docroot;
		while(usl) {
			if (!uwsgi_starts_with(real_filename, real_filename_len, usl->value, usl->len)) {
				goto secure;
			}
			usl = usl->next;
		}
		uwsgi_403(wsgi_req);
		uwsgi_log("PHP security error: %s is not under an allowed docroot\n", real_filename);
		return -1;
	}

secure:

	if (stat(real_filename, &php_stat)) {
                uwsgi_404(wsgi_req);
                return UWSGI_OK;
        }

        if (S_ISDIR(php_stat.st_mode)) {

                // add / to directories
                if (orig_path_info_len == 0 || (orig_path_info_len > 0 && orig_path_info[orig_path_info_len-1] != '/')) {
			wsgi_req->path_info = orig_path_info;
			wsgi_req->path_info_len = orig_path_info_len;
                        uwsgi_redirect_to_slash(wsgi_req);
                        return UWSGI_OK;
                }
                struct uwsgi_string_list *upi = uphp.index;
                real_filename[real_filename_len] = '/';
                real_filename_len++;
                int found = 0;
                while(upi) {
                        if (real_filename_len + upi->len + 1 < PATH_MAX) {
                                // add + 1 to ensure null byte
                                memcpy(real_filename+real_filename_len, upi->value, upi->len + 1);
                                if (!access(real_filename, R_OK)) {

                                        found = 1;
                                        break;
                                }
                        }
                        upi = upi->next;
                }

                if (!found) {
                        uwsgi_404(wsgi_req);
                        return UWSGI_OK;
                }

		real_filename_len = strlen(real_filename);

        }


	if (uphp.allowed_ext) {
		struct uwsgi_string_list *usl = uphp.allowed_ext;
                while(usl) {
			if (real_filename_len >= usl->len) {
				if (!uwsgi_strncmp(real_filename+(real_filename_len-usl->len), usl->len, usl->value, usl->len)) {
                                	goto secure2;
                        	}
			}
                        usl = usl->next;
                }
                uwsgi_403(wsgi_req);
                uwsgi_log("PHP security error: %s does not end with an allowed extension\n", real_filename);
                return -1;
	}

secure2:

	wsgi_req->file = real_filename;
	wsgi_req->file_len = strlen(wsgi_req->file);

	if (uphp.allowed_scripts) {
                struct uwsgi_string_list *usl = uphp.allowed_scripts;
                while(usl) {
                	if (!uwsgi_strncmp(wsgi_req->file, wsgi_req->file_len, usl->value, usl->len)) {
                        	goto secure3;
                        }
                        usl = usl->next;
                }
                uwsgi_403(wsgi_req);
                uwsgi_log("PHP security error: %s is not an allowed script\n", real_filename);
                return -1;
        }

secure3:
	if (force_empty_script_name) {
		wsgi_req->script_name = "";
		wsgi_req->script_name_len = 0;
	}
	else {
		wsgi_req->script_name = orig_path_info;
		if (path_info) {
			wsgi_req->script_name_len = path_info - orig_path_info;
		}
		else {
			wsgi_req->script_name_len = orig_path_info_len;
		}
	}

#ifdef UWSGI_DEBUG
	uwsgi_log("php filename = %s script_name = %.*s (%d) document_root = %.*s (%d)\n", real_filename, wsgi_req->script_name_len, wsgi_req->script_name, wsgi_req->script_name_len,
		wsgi_req->document_root_len, wsgi_req->document_root, wsgi_req->document_root_len);
#endif

	// now check for allowed paths and extensions

	SG(request_info).request_uri = estrndup(wsgi_req->uri, wsgi_req->uri_len);
        SG(request_info).request_method = estrndup(wsgi_req->method, wsgi_req->method_len);
	SG(request_info).proto_num = 1001;

	SG(request_info).query_string = estrndup(wsgi_req->query_string, wsgi_req->query_string_len);
        SG(request_info).content_length = wsgi_req->post_cl;
	SG(request_info).content_type = estrndup(wsgi_req->content_type, wsgi_req->content_type_len);

	// reinitialize it at every request !!!
	SG(sapi_headers).http_response_code = 200;	

	SG(request_info).path_translated = wsgi_req->file;

        file_handle.type = ZEND_HANDLE_FILENAME;
        file_handle.filename = real_filename;
        file_handle.free_filename = 0;
        file_handle.opened_path = NULL;

        if (php_request_startup(TSRMLS_C) == FAILURE) {
		uwsgi_500(wsgi_req);
                return -1;
        }

	struct uwsgi_string_list *usl=NULL;

	uwsgi_foreach(usl, uphp.exec_before) {
		if (zend_eval_string_ex(usl->value, NULL, "uWSGI php exec before", 1 TSRMLS_CC) == FAILURE) goto end;
	}

        php_execute_script(&file_handle TSRMLS_CC);

	uwsgi_foreach(usl, uphp.exec_after) {
		if (zend_eval_string_ex(usl->value, NULL, "uWSGI php exec after", 1 TSRMLS_CC) == FAILURE) goto end;
	}

end:
        php_request_shutdown(NULL);

	return 0;
}

void uwsgi_php_after_request(struct wsgi_request *wsgi_req) {

	log_request(wsgi_req);
}


SAPI_API struct uwsgi_plugin php_plugin = {
	.name = "php",
	.modifier1 = 14,
	.init = uwsgi_php_init,
	.request = uwsgi_php_request,
	.after_request = uwsgi_php_after_request,
	.options = uwsgi_php_options,
};

