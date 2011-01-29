BEGIN;
ALTER TABLE "books" 
    ADD COLUMN "author" varchar(255) NOT NULL;
;
COMMIT;
