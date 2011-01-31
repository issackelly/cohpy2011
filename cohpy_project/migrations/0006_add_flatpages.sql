BEGIN;
CREATE TABLE "django_flatpage_sites" (
    "id" serial NOT NULL PRIMARY KEY,
    "flatpage_id" integer NOT NULL,
    "site_id" integer NOT NULL,
    UNIQUE ("flatpage_id", "site_id")
)
;
CREATE TABLE "django_flatpage" (
    "id" serial NOT NULL PRIMARY KEY,
    "url" varchar(100) NOT NULL,
    "title" varchar(200) NOT NULL,
    "content" text NOT NULL,
    "enable_comments" boolean NOT NULL,
    "template_name" varchar(70) NOT NULL,
    "registration_required" boolean NOT NULL
)
;
ALTER TABLE "django_flatpage_sites" ADD CONSTRAINT "flatpage_id_refs_id_c0e84f5a" FOREIGN KEY ("flatpage_id") REFERENCES "django_flatpage" ("id") DEFERRABLE INITIALLY DEFERRED;
-- The following references should be added but depend on non-existent tables:
-- ALTER TABLE "django_flatpage_sites" ADD CONSTRAINT "site_id_refs_id_4e3eeb57" FOREIGN KEY ("site_id") REFERENCES "django_site" ("id") DEFERRABLE INITIALLY DEFERRED;
COMMIT;
