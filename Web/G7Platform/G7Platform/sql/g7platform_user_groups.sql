create database if not exists "g7platform";
use "g7platform";

  CREATE TABLE IF NOT EXISTS "auth_group" (

    "id" int(200) NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    "name" varchar(80) NOT NULL UNIQUE
  );


  CREATE TABLE IF NOT EXISTS "auth_group_permissions" (

    "id" int(200) NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    "group_id" integer NOT NULL REFERENCES "auth_group" ("id"),
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"),
    UNIQUE ("group_id", "permission_id")
  );