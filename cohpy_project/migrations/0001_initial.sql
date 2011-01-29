### New Model: admin.LogEntry
CREATE TABLE "django_admin_log" (
    "id" integer NOT NULL PRIMARY KEY,
    "action_time" datetime NOT NULL,
    "user_id" integer NOT NULL,
    "content_type_id" integer,
    "object_id" text,
    "object_repr" varchar(200) NOT NULL,
    "action_flag" smallint unsigned NOT NULL,
    "change_message" text NOT NULL
)
;
### New Model: auth.Permission
CREATE TABLE "auth_permission" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(50) NOT NULL,
    "content_type_id" integer NOT NULL,
    "codename" varchar(100) NOT NULL,
    UNIQUE ("content_type_id", "codename")
)
;
### New Model: auth.Group_permissions
CREATE TABLE "auth_group_permissions" (
    "id" integer NOT NULL PRIMARY KEY,
    "group_id" integer NOT NULL,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"),
    UNIQUE ("group_id", "permission_id")
)
;
### New Model: auth.Group
CREATE TABLE "auth_group" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(80) NOT NULL UNIQUE
)
;
### New Model: auth.User_user_permissions
CREATE TABLE "auth_user_user_permissions" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"),
    UNIQUE ("user_id", "permission_id")
)
;
### New Model: auth.User_groups
CREATE TABLE "auth_user_groups" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL,
    "group_id" integer NOT NULL REFERENCES "auth_group" ("id"),
    UNIQUE ("user_id", "group_id")
)
;
### New Model: auth.User
CREATE TABLE "auth_user" (
    "id" integer NOT NULL PRIMARY KEY,
    "username" varchar(30) NOT NULL UNIQUE,
    "first_name" varchar(30) NOT NULL,
    "last_name" varchar(30) NOT NULL,
    "email" varchar(75) NOT NULL,
    "password" varchar(128) NOT NULL,
    "is_staff" bool NOT NULL,
    "is_active" bool NOT NULL,
    "is_superuser" bool NOT NULL,
    "last_login" datetime NOT NULL,
    "date_joined" datetime NOT NULL
)
;
### New Model: auth.Message
CREATE TABLE "auth_message" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "message" text NOT NULL
)
;
### New Model: contenttypes.ContentType
CREATE TABLE "django_content_type" (
    "id" integer NOT NULL PRIMARY KEY,
    "name" varchar(100) NOT NULL,
    "app_label" varchar(100) NOT NULL,
    "model" varchar(100) NOT NULL,
    UNIQUE ("app_label", "model")
)
;
### New Model: sessions.Session
CREATE TABLE "django_session" (
    "session_key" varchar(40) NOT NULL PRIMARY KEY,
    "session_data" text NOT NULL,
    "expire_date" datetime NOT NULL
)
;
### New Model: sites.Site
CREATE TABLE "django_site" (
    "id" integer NOT NULL PRIMARY KEY,
    "domain" varchar(100) NOT NULL,
    "name" varchar(50) NOT NULL
)
;
### New Model: mailer.Message
CREATE TABLE "mailer_message" (
    "id" integer NOT NULL PRIMARY KEY,
    "message_data" text NOT NULL,
    "when_added" datetime NOT NULL,
    "priority" varchar(1) NOT NULL
)
;
### New Model: mailer.DontSendEntry
CREATE TABLE "mailer_dontsendentry" (
    "id" integer NOT NULL PRIMARY KEY,
    "to_address" varchar(75) NOT NULL,
    "when_added" datetime NOT NULL
)
;
### New Model: mailer.MessageLog
CREATE TABLE "mailer_messagelog" (
    "id" integer NOT NULL PRIMARY KEY,
    "message_data" text NOT NULL,
    "when_added" datetime NOT NULL,
    "priority" varchar(1) NOT NULL,
    "when_attempted" datetime NOT NULL,
    "result" varchar(1) NOT NULL,
    "log_message" text NOT NULL
)
;
### New Model: emailconfirmation.EmailAddress
CREATE TABLE "emailconfirmation_emailaddress" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "email" varchar(75) NOT NULL,
    "verified" bool NOT NULL,
    "primary" bool NOT NULL,
    UNIQUE ("user_id", "email")
)
;
### New Model: emailconfirmation.EmailConfirmation
CREATE TABLE "emailconfirmation_emailconfirmation" (
    "id" integer NOT NULL PRIMARY KEY,
    "email_address_id" integer NOT NULL REFERENCES "emailconfirmation_emailaddress" ("id"),
    "sent" datetime NOT NULL,
    "confirmation_key" varchar(40) NOT NULL
)
;
### New Model: account.Account
CREATE TABLE "account_account" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL UNIQUE REFERENCES "auth_user" ("id"),
    "timezone" varchar(100) NOT NULL,
    "language" varchar(10) NOT NULL
)
;
### New Model: account.OtherServiceInfo
CREATE TABLE "account_otherserviceinfo" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "key" varchar(50) NOT NULL,
    "value" text NOT NULL,
    UNIQUE ("user_id", "key")
)
;
### New Model: account.PasswordReset
CREATE TABLE "account_passwordreset" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "temp_key" varchar(100) NOT NULL,
    "timestamp" datetime NOT NULL,
    "reset" bool NOT NULL
)
;
### New Model: signup_codes.SignupCode
CREATE TABLE "signup_codes_signupcode" (
    "id" integer NOT NULL PRIMARY KEY,
    "code" varchar(40) NOT NULL,
    "max_uses" integer unsigned NOT NULL,
    "expiry" datetime,
    "inviter_id" integer REFERENCES "auth_user" ("id"),
    "email" varchar(75) NOT NULL,
    "notes" text NOT NULL,
    "created" datetime NOT NULL,
    "use_count" integer unsigned NOT NULL
)
;
### New Model: signup_codes.SignupCodeResult
CREATE TABLE "signup_codes_signupcoderesult" (
    "id" integer NOT NULL PRIMARY KEY,
    "signup_code_id" integer NOT NULL REFERENCES "signup_codes_signupcode" ("id"),
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "timestamp" datetime NOT NULL
)
;
### New Model: django_openid.Nonce
CREATE TABLE "django_openid_nonce" (
    "id" integer NOT NULL PRIMARY KEY,
    "server_url" varchar(255) NOT NULL,
    "timestamp" integer NOT NULL,
    "salt" varchar(40) NOT NULL
)
;
### New Model: django_openid.Association
CREATE TABLE "django_openid_association" (
    "id" integer NOT NULL PRIMARY KEY,
    "server_url" text NOT NULL,
    "handle" varchar(255) NOT NULL,
    "secret" text NOT NULL,
    "issued" integer NOT NULL,
    "lifetime" integer NOT NULL,
    "assoc_type" text NOT NULL
)
;
### New Model: django_openid.UserOpenidAssociation
CREATE TABLE "django_openid_useropenidassociation" (
    "id" integer NOT NULL PRIMARY KEY,
    "user_id" integer NOT NULL REFERENCES "auth_user" ("id"),
    "openid" varchar(255) NOT NULL,
    "created" datetime NOT NULL
)
;
CREATE INDEX "django_admin_log_fbfc09f1" ON "django_admin_log" ("user_id");
CREATE INDEX "django_admin_log_e4470c6e" ON "django_admin_log" ("content_type_id");
CREATE INDEX "auth_permission_e4470c6e" ON "auth_permission" ("content_type_id");
CREATE INDEX "auth_group_permissions_bda51c3c" ON "auth_group_permissions" ("group_id");
CREATE INDEX "auth_group_permissions_1e014c8f" ON "auth_group_permissions" ("permission_id");
CREATE INDEX "auth_user_user_permissions_fbfc09f1" ON "auth_user_user_permissions" ("user_id");
CREATE INDEX "auth_user_user_permissions_1e014c8f" ON "auth_user_user_permissions" ("permission_id");
CREATE INDEX "auth_user_groups_fbfc09f1" ON "auth_user_groups" ("user_id");
CREATE INDEX "auth_user_groups_bda51c3c" ON "auth_user_groups" ("group_id");
CREATE INDEX "auth_message_fbfc09f1" ON "auth_message" ("user_id");
CREATE INDEX "emailconfirmation_emailaddress_fbfc09f1" ON "emailconfirmation_emailaddress" ("user_id");
CREATE INDEX "emailconfirmation_emailconfirmation_1df9fea4" ON "emailconfirmation_emailconfirmation" ("email_address_id");
CREATE INDEX "account_otherserviceinfo_fbfc09f1" ON "account_otherserviceinfo" ("user_id");
CREATE INDEX "account_passwordreset_fbfc09f1" ON "account_passwordreset" ("user_id");
CREATE INDEX "signup_codes_signupcode_74fccd78" ON "signup_codes_signupcode" ("inviter_id");
CREATE INDEX "signup_codes_signupcoderesult_16afc873" ON "signup_codes_signupcoderesult" ("signup_code_id");
CREATE INDEX "signup_codes_signupcoderesult_fbfc09f1" ON "signup_codes_signupcoderesult" ("user_id");
CREATE INDEX "django_openid_useropenidassociation_fbfc09f1" ON "django_openid_useropenidassociation" ("user_id");
