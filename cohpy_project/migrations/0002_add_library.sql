BEGIN;
CREATE TABLE "books" (
    "id" serial NOT NULL PRIMARY KEY,
    "title" varchar(255) NOT NULL,
    "prefix" varchar(20) NOT NULL,
    "subtitle" varchar(255) NOT NULL,
    "slug" varchar(50) NOT NULL UNIQUE,
    "isbn" varchar(14) NOT NULL,
    "pages" smallint CHECK ("pages" >= 0),
    "publisher_id" integer,
    "published" date,
    "cover" varchar(100) NOT NULL,
    "description" text NOT NULL,
    "created" timestamp with time zone NOT NULL,
    "modified" timestamp with time zone NOT NULL
)
;
CREATE TABLE "book_publishers" (
    "id" serial NOT NULL PRIMARY KEY,
    "title" varchar(100) NOT NULL,
    "prefix" varchar(20) NOT NULL,
    "slug" varchar(50) NOT NULL UNIQUE,
    "website" varchar(200) NOT NULL,
    "logo" varchar(100) NOT NULL
)
;
ALTER TABLE "books" ADD CONSTRAINT "publisher_id_refs_id_56e3c20e" FOREIGN KEY ("publisher_id") REFERENCES "book_publishers" ("id") DEFERRABLE INITIALLY DEFERRED;
COMMIT;
