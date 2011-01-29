BEGIN;
CREATE TABLE "easy_thumbnails_source" (
    "id" serial NOT NULL PRIMARY KEY,
    "storage_hash" varchar(40) NOT NULL,
    "name" varchar(255) NOT NULL,
    "modified" timestamp with time zone NOT NULL
)
;
CREATE TABLE "easy_thumbnails_thumbnail" (
    "id" serial NOT NULL PRIMARY KEY,
    "storage_hash" varchar(40) NOT NULL,
    "name" varchar(255) NOT NULL,
    "modified" timestamp with time zone NOT NULL,
    "source_id" integer NOT NULL REFERENCES "easy_thumbnails_source" ("id") DEFERRABLE INITIALLY DEFERRED
)
;
COMMIT;
