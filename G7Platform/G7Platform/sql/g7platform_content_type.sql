create database if not exists "g7platform";
use "g7platform";

  CREATE TABLE IF NOT EXISTS "django_content_type" (

    "id" int(200) NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    "app_label" varchar(100) NOT NULL,
    "model" varchar(100) NOT NULL,
    UNIQUE ("app_label", "model")
  );