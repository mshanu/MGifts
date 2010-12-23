
insert into shop(id,version,name) values(1,1,'MG Trivandrum');
insert into shop(id,version,name) values(2,1,'MG Pathanamthitta');
insert into shop(id,version,name) values(3,1,'MG Kollam');
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
insert into shop(id,version,name) values(26,1,'MG Jayanagar');
insert into shop(id,version,name) values(27,1,'MG Dickenson');
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