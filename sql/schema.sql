drop schema if exists public cascade;
create schema public authorization app_user;
CREATE TABLE changelog (
change_number BIGINT NOT NULL,
complete_dt TIMESTAMP NOT NULL,
applied_by text NOT NULL,
description text NOT NULL
);