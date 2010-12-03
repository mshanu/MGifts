drop schema if exists public cascade;
create table role (id int8 not null, version int8 not null, authority varchar(255) not null unique, primary key (id));
create table user (id int8 not null, version int8 not null, account_expired bool not null, account_locked bool not null, enabled bool not null, "password" varchar(255) not null, password_expired bool not null, username varchar(255) not null unique, primary key (id));
create table user_role (role_id int8 not null, user_id int8 not null, primary key (role_id, user_id));
alter table user_role add constraint FK143BF46A5D1CA167 foreign key (role_id) references role;
alter table user_role add constraint FK143BF46A2476547 foreign key (user_id) references user;
create sequence hibernate_sequence;
