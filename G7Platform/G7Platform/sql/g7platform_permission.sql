create database if not exists "g7platform";
use "g7platform";

  CREATE TABLE IF NOT EXISTS "auth_permission" (

    "id" int NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id"),
    "codename" varchar(100) NOT NULL,
    "name" varchar(255) NOT NULL,
    UNIQUE ("content_type_id", "codename")
  );


