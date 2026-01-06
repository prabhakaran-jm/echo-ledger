BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "commitment" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "proposalId" bigint NOT NULL,
    "status" text NOT NULL,
    "startedAt" timestamp without time zone NOT NULL,
    "endedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "commitment_log" (
    "id" bigserial PRIMARY KEY,
    "commitmentId" bigint NOT NULL,
    "weekIndex" bigint NOT NULL,
    "actualEffortHours" double precision NOT NULL,
    "frictionScore" bigint NOT NULL,
    "skipped" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "commitment_proposal" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "title" text NOT NULL,
    "category" text NOT NULL,
    "perceivedWeeklyEffort" double precision NOT NULL,
    "perceivedDurationWeeks" bigint NOT NULL,
    "effortType" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "post_commitment_reflection" (
    "id" bigserial PRIMARY KEY,
    "commitmentId" bigint NOT NULL,
    "regretScore" bigint NOT NULL,
    "satisfactionScore" bigint NOT NULL,
    "wouldRepeat" text NOT NULL,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR echo_ledger
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('echo_ledger', '20260106122954058', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260106122954058', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20251208110420531-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110420531-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


--
-- MIGRATION VERSION FOR 'server'
--
DELETE FROM "serverpod_migrations"WHERE "module" IN ('server');

COMMIT;
