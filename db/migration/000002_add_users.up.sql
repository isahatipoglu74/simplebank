-- user tablosu oluşturduk
CREATE TABLE "users" (
  "username" varchar PRIMARY KEY,
  "hashed_password" varchar NOT NULL,
  "full_name" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "password_changed_at" timestamptz NOT NULL DEFAULT '0001-01-01 00:00:00Z',
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

-- accounts tablosununun owner değeri users tablosunun username sutununa denk geldiğini söyledik
ALTER TABLE "accounts" ADD FOREIGN KEY ("owner") REFERENCES "users" ("username");

--accounts tablousunda kullanıcı ve para birimi uniq olmasını, örn: bir kişinin iki tane dolar hesabı olmaması gerektiğini söyledik.
--Her ikisinide kullanabiliriz.

-- CREATE UNIQUE INDEX ON "accounts" ("owner", "currency");
ALTER TABLE "accounts" ADD CONSTRAINT "owner_currency_key" UNIQUE ("owner", "currency");