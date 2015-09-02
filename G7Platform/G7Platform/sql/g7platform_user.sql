create database if not exists "g7platform";
use "g7platform";

  CREATE TABLE IF NOT EXISTS "auth_user" (

    "id" int NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    "password" varchar(128) NOT NULL,
    "is_superuser" bool NOT NULL,
    "username" varchar(30) NOT NULL UNIQUE,
    "first_name" varchar(30) NOT NULL,
    "last_name" varchar(30) NOT NULL,
    "email" varchar(254) NOT NULL,
    "is_staff" bool NOT NULL,
    "is_active" bool NOT NULL,
    "date_joined" datetime DEFAULT now(),
    "last_login" datetime DEFAULT now(),
    "usignature" varchar (100) DEFAULT '',
    "deviceid" varchar (50) DEFAULT '',
    "mobile" varchar (30) DEFAULT '',
    "salt" varchar (10) DEFAULT ''
);

  CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (

    "id" int NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"),
    UNIQUE ("user_id", "permission_id")
  );

  CREATE TABLE IF NOT EXISTS "auth_user_groups" (
    "id" int NOT NULL PRIMARY KEY AUTOINCREMENT,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "group_id" integer NOT NULL REFERENCES "auth_group" ("id"),
    UNIQUE ("user_id", "group_id"))