create table app_user (id int8 not null, version int8 not null, account_expired bool not null, account_locked bool not null, date_created timestamp not null, enabled bool not null, first_name varchar(255) not null, last_name varchar(255) not null, last_updated timestamp not null, "password" varchar(255) not null, password_expired bool not null, shop_id int8 not null, username varchar(255) not null unique, primary key (id));
create table app_user_role (role_id int8 not null, app_user_id int8 not null, primary key (role_id, app_user_id));
create table client (id int8 not null, version int8 not null, address varchar(255), city varchar(255), date_created timestamp not null, initials varchar(255) not null unique, name varchar(255) not null, primary key (id));
create table client_voucher_sequence (id int8 not null, version int8 not null, client_id int8 not null, last_voucher_sequence_number int4 not null, primary key (id));
create table item (id int8 not null, version int8 not null, description varchar(255), is_standard bool not null, name varchar(255) not null, primary key (id));
create table purchase (id int8 not null, version int8 not null, created_by_id int8 not null, date_created timestamp not null, discount float8 not null, invoice_date timestamp not null, invoice_number int8 not null, item_id int8 not null, net_total float8 not null, shopped_at_id int8 not null, total_amount float8, primary key (id));
create table purchase_voucher (purchase_vouchers_id int8, voucher_id int8);
create table role (id int8 not null, version int8 not null, authority varchar(255) not null unique, description varchar(255) not null, primary key (id));
create table shop (id int8 not null, version int8 not null, name varchar(255) not null, primary key (id));
create table voucher (id int8 not null, version int8 not null, barcode_alpha varchar(10) not null, created_by_id int8 not null, date_created date not null, last_updated timestamp not null, sequence_number int4 not null, sold_at_id int8, status varchar(255) not null, valid_thru timestamp not null, validated_at_id int8, value float8 not null, voucher_request_id int8 not null, primary key (id));
create table voucher_invoice (id int8 not null, version int8 not null, date_created timestamp not null, invoice_number int4 not null, invoiced_at_id int8 not null, remarks varchar(255), voucher_request_id int8 not null, primary key (id));
create table voucher_invoice_sequence (id int8 not null, version int8 not null, last_squence_number int4 not null, shop_id int8 not null, primary key (id));
create table voucher_request (id int8 not null, version int8 not null, client_id int8 not null, created_by_id int8 not null, date_created timestamp not null, is_invoiced bool not null, last_updated timestamp not null, primary key (id));
alter table app_user add constraint FK459C57295CDFF32F foreign key (shop_id) references shop;
alter table app_user_role add constraint FK9CE8F3CC33BC032F foreign key (role_id) references role;
alter table app_user_role add constraint FK9CE8F3CC23124A28 foreign key (app_user_id) references app_user;
alter table client_voucher_sequence add constraint FKC2E0DC2695834DCF foreign key (client_id) references client;
alter table purchase add constraint FK67E905015FC9220F foreign key (item_id) references item;
alter table purchase add constraint FK67E90501C15CC36C foreign key (shopped_at_id) references shop;
alter table purchase add constraint FK67E90501EAE57223 foreign key (created_by_id) references app_user;
alter table purchase_voucher add constraint FKC10A97055FE798D foreign key (purchase_vouchers_id) references purchase;
alter table purchase_voucher add constraint FKC10A97055BDD5A5 foreign key (voucher_id) references voucher;
alter table voucher add constraint FK26288EAE68FF19F2 foreign key (voucher_request_id) references voucher_request;
alter table voucher add constraint FK26288EAEDE960761 foreign key (validated_at_id) references shop;
alter table voucher add constraint FK26288EAECEC45A7 foreign key (sold_at_id) references shop;
alter table voucher add constraint FK26288EAEEAE57223 foreign key (created_by_id) references app_user;
alter table voucher_invoice add constraint FK3BA3EA9C68FF19F2 foreign key (voucher_request_id) references voucher_request;
alter table voucher_invoice add constraint FK3BA3EA9CF300A56A foreign key (invoiced_at_id) references shop;
alter table voucher_invoice_sequence add constraint FK7FB9EE045CDFF32F foreign key (shop_id) references shop;
alter table voucher_request add constraint FK81C99FE95834DCF foreign key (client_id) references client;
alter table voucher_request add constraint FK81C99FEEAE57223 foreign key (created_by_id) references app_user;
create sequence hibernate_sequence;