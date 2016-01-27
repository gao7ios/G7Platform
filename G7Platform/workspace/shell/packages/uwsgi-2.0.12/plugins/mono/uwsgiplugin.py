import os
NAME='mono'

CFLAGS = os.popen('pkg-config --cflags mono-2').read().rstrip().split()
LDFLAGS = []
LIBS = os.popen('pkg-config --libs mono-2').read().rstrip().split() 
GCC_LIST = ['mono_plugin']

if os.uname()[0] == 'Darwin':
	LIBS.append('-framework Foundation')

def post_build(config):
    if os.system("sn -k plugins/mono/uwsgi.key") != 0:
        os._exit(1)
    if os.system("mcs /target:library /r:System.Web.dll /keyfile:plugins/mono/uwsgi.key plugins/mono/uwsgi.cs") != 0:
        os._exit(1)
    print("*** uwsgi.dll available in %s/plugins/mono/uwsgi.dll ***" % os.getcwd())
