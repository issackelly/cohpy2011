BEGIN;
CREATE TABLE "library_checkout" (
    "id" serial NOT NULL PRIMARY KEY,
    "date" date NOT NULL,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "date_returned" date,
    "book_id" integer NOT NULL REFERENCES "books" ("id") DEFERRABLE INITIALLY DEFERRED
)
;
CREATE TABLE "library_review" (
    "id" serial NOT NULL PRIMARY KEY,
    "date" date NOT NULL,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED,
    "book_id" integer NOT NULL REFERENCES "books" ("id") DEFERRABLE INITIALLY DEFERRED,
    "why_did_you_get_this_book" text,
    "did_you_like_it" text,
    "stars" integer NOT NULL
)
;
COMMIT;
