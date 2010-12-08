create table app_user (id int8 not null, version int8 not null, account_expired bool not null, account_locked bool not null, date_created timestamp not null, enabled bool not null, first_name varchar(255) not null, last_name varchar(255) not null, last_updated timestamp not null, "password" varchar(255) not null, password_expired bool not null, username varchar(255) not null unique, primary key (id));
create table app_user_role (role_id int8 not null, app_user_id int8 not null, primary key (role_id, app_user_id));
create table client (id int8 not null, version int8 not null, address varchar(255), city varchar(255), date_created timestamp not null, initials varchar(255) not null, name varchar(255) not null, primary key (id));
create table client_voucher_sequence (id int8 not null, version int8 not null, client_id int8 not null, last_voucher_sequence_number int4 not null, primary key (id));
create table role (id int8 not null, version int8 not null, authority varchar(255) not null unique, primary key (id));
create table voucher (id int8 not null, version int8 not null, barcode_alpha varchar(10) not null, client_id int8 not null, created_by_id int8 not null, date_created timestamp not null, last_updated timestamp not null, sequence_number int4 not null, status varchar(255) not null, value float8 not null, primary key (id));
alter table app_user_role add constraint FK9CE8F3CC33BC032F foreign key (role_id) references role;
alter table app_user_role add constraint FK9CE8F3CC23124A28 foreign key (app_user_id) references app_user;
alter table client_voucher_sequence add constraint FKC2E0DC2695834DCF foreign key (client_id) references client;
alter table voucher add constraint FK26288EAE95834DCF foreign key (client_id) references client;
alter table voucher add constraint FK26288EAEEAE57223 foreign key (created_by_id) references app_user;
create sequence hibernate_sequence;
--Data
insert into role(id,version,authority) values (1,1,'ROLE_ADMIN');
insert into role(id,version,authority) values (2,1,'ROLE_DEALER');

INSERT INTO app_user(id, "version", account_expired, account_locked, date_created,enabled, first_name, last_name, last_updated, "password", password_expired,username)VALUES (1, 1, false, false, current_timestamp,true, 'Fanzeem', 'Ahmed', current_timestamp,'3723e615dd927e7534f2f4eafa71adae6df823219ee71265bae56ba5e6927f18', false,'admin');
insert into app_user_role(role_id, app_user_id )values(1,1);