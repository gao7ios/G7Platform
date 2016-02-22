create database if not exists "g7platform";
use "g7platform";

  CREATE TABLE IF NOT EXISTS "g7platform_app" (

    "id" int(200) NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    "build" int(64) usigned not null auto_increment unique,
    "uuid" varchar(36) NOT NULL UNIQUE,
    "status" int(10) unsigned not null
    "version" varchar(100) not null,
    "name" varchar(80) NOT NULL UNIQUE,
    "description" varchar(200) DEFAULT '',
    "password" varchar(128) DEFAULT '',
    "pwd_salt" varchar(10) DEFAULT '',
    "create_at" datetime default now(),
    "edit_at" datetime default now(),

    "package_id" int(200) default '',
    "last_edit_user_id" int(200) unsigned auto_increment unique
    "members_id" int(200) unsigned auto_increment unique, /*一对多 对应user*/
    "permission_id" int(200) UNSIGNED NOT NULL,
  );

  CREATE TABLE IF NOT EXISTS "g7platform_package" (

    "id" int(200) NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    "name" varchar(200) default '',
    "icon" varchar(200) default '',

  );

