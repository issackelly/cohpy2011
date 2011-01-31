BEGIN;
CREATE TABLE "tagging_tag" (
    "id" serial NOT NULL PRIMARY KEY,
    "name" varchar(50) NOT NULL UNIQUE
)
;
CREATE TABLE "tagging_taggeditem" (
    "id" serial NOT NULL PRIMARY KEY,
    "tag_id" integer NOT NULL REFERENCES "tagging_tag" ("id") DEFERRABLE INITIALLY DEFERRED,
    "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED,
    "object_id" integer CHECK ("object_id" >= 0) NOT NULL,
    UNIQUE ("tag_id", "content_type_id", "object_id")
)
;
COMMIT;
BEGIN;
CREATE TABLE "image_image" (
    "id" serial NOT NULL PRIMARY KEY,
    "title" varchar(255),
    "image" varchar(100) NOT NULL,
    "description" text,
    "tags" varchar(255) NOT NULL,
    "uploaded" timestamp with time zone NOT NULL,
    "modified" timestamp with time zone NOT NULL
)
;
COMMIT;
BEGIN;
CREATE TABLE "video_video" (
    "id" serial NOT NULL PRIMARY KEY,
    "title" varchar(255),
    "still" varchar(100) NOT NULL,
    "video" varchar(100) NOT NULL,
    "description" text,
    "tags" varchar(255) NOT NULL,
    "uploaded" timestamp with time zone NOT NULL,
    "modified" timestamp with time zone NOT NULL
)
;
COMMIT;
BEGIN;
CREATE TABLE "document_document" (
    "id" serial NOT NULL PRIMARY KEY,
    "title" varchar(255),
    "document" varchar(100) NOT NULL,
    "description" text,
    "text" text,
    "tags" varchar(255) NOT NULL,
    "uploaded" timestamp with time zone NOT NULL,
    "modified" timestamp with time zone NOT NULL
)
;
COMMIT;
BEGIN;
CREATE TABLE "gallery_gallery" (
    "id" serial NOT NULL PRIMARY KEY,
    "title" varchar(255),
    "description" text
)
;
CREATE TABLE "gallery_galleryitem" (
    "id" serial NOT NULL PRIMARY KEY,
    "gallery_id" integer NOT NULL REFERENCES "gallery_gallery" ("id") DEFERRABLE INITIALLY DEFERRED,
    "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED,
    "object_id" integer CHECK ("object_id" >= 0) NOT NULL,
    "order" integer,
    UNIQUE ("gallery_id", "content_type_id", "object_id")
)
;
CREATE TABLE "gallery_gallerymodel" (
    "id" serial NOT NULL PRIMARY KEY,
    "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED
)
;
COMMIT;
BEGIN;
CREATE TABLE "navigation_menuitem" (
    "id" serial NOT NULL PRIMARY KEY,
    "lft" integer CHECK ("lft" >= 0) NOT NULL,
    "rgt" integer CHECK ("rgt" >= 0) NOT NULL,
    "tree_id" integer CHECK ("tree_id" >= 0) NOT NULL,
    "depth" integer CHECK ("depth" >= 0) NOT NULL,
    "title" varchar(255) NOT NULL,
    "urlpath" varchar(255) NOT NULL,
    "site_id" integer NOT NULL REFERENCES "django_site" ("id") DEFERRABLE INITIALLY DEFERRED,
    "content_type_id" integer REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED,
    "object_id" integer
)
;
COMMIT;
