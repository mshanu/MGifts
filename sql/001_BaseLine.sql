create table app_user (id int8 not null, version int8 not null, account_expired bool not null, account_locked bool not null, date_created timestamp not null, enabled bool not null, first_name varchar(255) not null, last_name varchar(255) not null, last_updated timestamp not null, "password" varchar(255) not null, password_expired bool not null, shop_id int8 not null, username varchar(255) not null unique, primary key (id));
create table app_user_role (role_id int8 not null, app_user_id int8 not null, primary key (role_id, app_user_id));
create table client (id int8 not null, version int8 not null, address varchar(255), city varchar(255), date_created timestamp not null, initials varchar(255) not null unique, name varchar(255) not null, primary key (id));
create table client_voucher_sequence (id int8 not null, version int8 not null, client_id int8 not null, last_voucher_sequence_number int4 not null, primary key (id));
create table item (id int8 not null, version int8 not null, description varchar(255), is_standard bool not null, name varchar(255) not null, primary key (id));
create table purchase (id int8 not null, version int8 not null, created_by_id int8 not null, date_created timestamp not null, discount float8 not null, invoice_date timestamp not null, invoice_number int8 not null, item_id int8 not null, net_total float8 not null, shopped_at_id int8 not null, total_amount float8, primary key (id));
create table role (id int8 not null, version int8 not null, authority varchar(255) not null unique, description varchar(255) not null, primary key (id));
create table shop (id int8 not null, version int8 not null, name varchar(255) not null, primary key (id));
create table voucher (id int8 not null, version int8 not null, barcode_alpha varchar(10) not null, client_id int8 not null, created_by_id int8 not null, date_created date not null, last_updated timestamp not null, sequence_number int4 not null, sold_at_id int8, status varchar(255) not null, validated_at_id int8, value float8 not null, voucher_invoice_id int8 not null, primary key (id));
create table voucher_invoice (id int8 not null, version int8 not null, date_created timestamp not null, invoice_number int4 not null, invoiced_at_id int8 not null, primary key (id));
create table voucher_invoice_sequence (id int8 not null, version int8 not null, last_squence_number int4 not null, shop_id int8 not null, primary key (id));
alter table app_user add constraint FK459C57295CDFF32F foreign key (shop_id) references shop;
alter table app_user_role add constraint FK9CE8F3CC33BC032F foreign key (role_id) references role;
alter table app_user_role add constraint FK9CE8F3CC23124A28 foreign key (app_user_id) references app_user;
alter table client_voucher_sequence add constraint FKC2E0DC2695834DCF foreign key (client_id) references client;
alter table purchase add constraint FK67E905015FC9220F foreign key (item_id) references item;
alter table purchase add constraint FK67E90501C15CC36C foreign key (shopped_at_id) references shop;
alter table purchase add constraint FK67E90501EAE57223 foreign key (created_by_id) references app_user;
alter table voucher add constraint FK26288EAEC44ED32 foreign key (voucher_invoice_id) references voucher_invoice;
alter table voucher add constraint FK26288EAEDE960761 foreign key (validated_at_id) references shop;
alter table voucher add constraint FK26288EAE95834DCF foreign key (client_id) references client;
alter table voucher add constraint FK26288EAECEC45A7 foreign key (sold_at_id) references shop;
alter table voucher add constraint FK26288EAEEAE57223 foreign key (created_by_id) references app_user;
alter table voucher_invoice add constraint FK3BA3EA9CF300A56A foreign key (invoiced_at_id) references shop;
alter table voucher_invoice_sequence add constraint FK7FB9EE045CDFF32F foreign key (shop_id) references shop;
create sequence hibernate_sequence;
--Data


insert into shop(id,version,name) values(1,1,'MG Trivandrum');
insert into shop(id,version,name) values(2,1,'MG Pathanamthitta');
insert into shop(id,version,name) values(3,1,'MG Kollam';
insert into shop(id,version,name) values(4,1,'MG Allappey');
insert into shop(id,version,name) values(5,1,'MG Kottayam');
insert into shop(id,version,name) values(6,1,'MG Thodupuzha');
insert into shop(id,version,name) values(7,1,'MG Cochin');
insert into shop(id,version,name) values(8,1,'MG Kodungaloor');
insert into shop(id,version,name) values(9,1,'MG Trichur');
insert into shop(id,version,name) values(10,1,'MG Palakkad');
insert into shop(id,version,name) values(11,1,'MG Edappal');
insert into shop(id,version,name) values(12,1,'MG Manjeri');
insert into shop(id,version,name) values(13,1,'MG Perinthalmanna');
insert into shop(id,version,name) values(14,1,'MG Tirur');
insert into shop(id,version,name) values(15,1,'MG Calicut');
insert into shop(id,version,name) values(16,1,'MG Vadakara');
insert into shop(id,version,name) values(17,1,'MG Sulthan Bathery');
insert into shop(id,version,name) values(18,1,'MG Thalesery');
insert into shop(id,version,name) values(19,1,'MG Kannur');
insert into shop(id,version,name) values(20,1,'MG Payyannur');
insert into shop(id,version,name) values(21,1,'MG Kanghangad');
insert into shop(id,version,name) values(22,1,'MG Kasargod');
insert into shop(id,version,name) values(23,1,'MG Coimbatore');
insert into shop(id,version,name) values(24,1,'MG Salem');
insert into shop(id,version,name) values(25,1,'MG Erode');
insert into shop(id,version,name) values(26,1,'MG Banglore');
insert into shop(id,version,name) values(27,1,'MG Banglore');
insert into shop(id,version,name) values(28,1,'MG Mysore');
insert into shop(id,version,name) values(29,1,'MG Mangalore');
insert into shop(id,version,name) values(30,1,'MG Hassan');
insert into shop(id,version,name) values(31,1,'MG Hyderabad');
insert into shop(id,version,name) values(32,1,'Breigns');

insert into role(id,version,authority,description) values (1,1,'ROLE_ADMIN','Admin User');
insert into role(id,version,authority,description) values (2,1,'ROLE_USER','Shop User');

INSERT INTO app_user(id, "version", account_expired, account_locked, date_created,enabled, first_name, last_name, last_updated, "password",
password_expired,username,shop_id)VALUES (0, 1, false, false, current_timestamp,true, 'Fanzeem', 'Ahmed', current_timestamp,'3723e615dd927e7534f2f4eafa71adae6df823219ee71265bae56ba5e6927f18', false,'admin',1);
insert into app_user_role(role_id, app_user_id )values(1,0);

INSERT INTO item (id, version, description,name,is_standard) values (1,1,'Gold Jewellery','GOLD',true);
INSERT INTO item (id, version, description,name,is_standard) values (2,1,'Diamond Jewellery','DIAMOND',true);
INSERT INTO item (id, version, description,name,is_standard) values (3,1,'Precious','Precious',true);
INSERT INTO item (id, version, description,name,is_standard) values (4,1,'Gold Coin','Gold Coin',true);
INSERT INTO item (id, version, description,name,is_standard) values (5,1,'Silver','Silver',true);
INSERT INTO item (id, version, description,name,is_standard) values (6,1,'Era','Era',true); 