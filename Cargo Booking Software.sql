CREATE TABLE shipper(
 shipper_id int NOT NULL,
 shipper_name varchar(50) NOT NULL,
 shiper_address varchar(50),
 shipper_phone varchar(20),
 branch_id INT,
 PRIMARY KEY(shipper_id)
);
ALTER TABLE shipper
ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL;


INSERT INTO shipper VALUES (201, 'Sakib','Chittagong','01812346095',NULL);
INSERT INTO branch VALUES (301,'Chittagong_branch',201);
update shipper set branch_id=301
where shipper_id=201;
INSERT INTO shipper VALUES (202, 'Emon','Chittagong','01812346196',301);
INSERT INTO shipper VALUES (203, 'Arif','Chittagong','01817846198',301);
INSERT INTO shipper VALUES (204, 'Sagor','Dhaka','01712396097',NULL);
INSERT INTO branch VALUES (302,'Dhaka_branch',204);
update shipper set branch_id=302
where shipper_id=204;
INSERT INTO shipper VALUES (205, 'Jamir','Dhaka','01817213198',302);
INSERT INTO shipper VALUES (206, 'Raihan','Khulna','01813376497',NULL);
INSERT INTO branch VALUES (303,'Khulna_branch',206);
update shipper set branch_id=303
where shipper_id=206;
INSERT INTO shipper VALUES (207, 'Kabir','Khulna','01813376497',303);
INSERT INTO shipper VALUES (208, 'Rahman','Dinajpur','01834557649',NULL);
INSERT INTO branch VALUES (304,'Dinajpur_branch',208);
update shipper set branch_id=304
where shipper_id=208;
INSERT INTO shipper VALUES (209, 'Karim','Dinajpur','01834557649',304);
INSERT INTO shipper VALUES (210, 'Mijan','Rangpur','01830945649',NULL);
INSERT INTO branch VALUES (305,'Rangpur_branch',210);
update shipper set branch_id=305
where shipper_id=210;
INSERT INTO shipper VALUES (211, 'Rimon','Rangpur','01834557649',305);

CREATE TABLE branch(
 branch_id int PRIMARY KEY NOT NULL,
 branch_name varchar(50) NOT NULL,
 cargo_id int,
 supervisor_id int,
 FOREIGN KEY(cargo_id) REFERENCES cargo(cargo_id) ON DELETE SET NULL,
 FOREIGN KEY(supervisor_id) REFERENCES shipper(shipper_id) ON DELETE SET NULL
);
ALTER TABLE branch
DROP COLUMN cargo_id;

INSERT INTO shipper VALUES (201, 'Sakib','Chittagong','01812346095',NULL);
INSERT INTO branch VALUES (301,'Chittagong_branch',201);
update shipper set branch_id=301
where shipper_id=201;
INSERT INTO shipper VALUES (202, 'Emon','Chittagong','01812346196',301);
INSERT INTO shipper VALUES (203, 'Arif','Chittagong','01817846198',301);
INSERT INTO shipper VALUES (204, 'Sagor','Dhaka','01712396097',NULL);
INSERT INTO branch VALUES (302,'Dhaka_branch',204);
update shipper set branch_id=302
where shipper_id=204;
INSERT INTO shipper VALUES (205, 'Jamir','Dhaka','01817213198',302);
INSERT INTO shipper VALUES (206, 'Raihan','Khulna','01813376497',NULL);
INSERT INTO branch VALUES (303,'Khulna_branch',206);
update shipper set branch_id=303
where shipper_id=206;
INSERT INTO shipper VALUES (207, 'Kabir','Khulna','01813376497',303);
INSERT INTO shipper VALUES (208, 'Rahman','Dinajpur','01834557649',NULL);
INSERT INTO branch VALUES (304,'Dinajpur_branch',208);
update shipper set branch_id=304
where shipper_id=208;
INSERT INTO shipper VALUES (209, 'Karim','Dinajpur','01834557649',304);
INSERT INTO shipper VALUES (210, 'Mijan','Rangpur','01830945649',NULL);
INSERT INTO branch VALUES (305,'Rangpur_branch',210);
update shipper set branch_id=305 where shipper_id=210;
INSERT INTO shipper VALUES (211, 'Rimon','Rangpur','01834557649',305);

CREATE TABLE cargo(
 cargo_id INT PRIMARY KEY NOT NULL,
 cargo_name varchar(50) NOT NULL,
 booking_id INT,
 weight varchar(50),
 mark varchar(20),
 FOREIGN KEY(booking_id) REFERENCES shipper(shipper_id) ON DELETE SET NULL
);
ALTER TABLE cargo
ADD branch_id int;
ALTER TABLE cargo
ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL;
ALTER TABLE cargo
MODIFY mark varchar(100);

insert into cargo values(11,'Fit Logistic Limited',204,'10000kg','Temperature Sensitive',303);
insert into cargo values(12,'BRISK LOGISTICS INTERNATIONAL LTD',211,'9800kg','Temperature
Sensitive',301);
insert into cargo values(13,'MANUMA SHIPPING LINES',203,'11200kg','Fragile',305);
insert into cargo values(14,'FAMOUS CARGO LINE',208,'10000kg','Food',302);
insert into cargo values(15,'ANCHOR LOGISTICS',205,'12000kg','Protect from heat',304);

CREATE TABLE consignee(
 consignee_id int PRIMARY KEY NOT NULL,
 consignee_name varchar(50) NOT NULL,
 consignee_address varchar(50),
 branch_id int,
 consignee_phone varchar(20),
 FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);
ALTER TABLE consignee
ADD order_no int;
ALTER TABLE consignee ADD FOREIGN KEY(order_no) REFERENCES shipper(shipper_id) ON
DELETE SET NULL;

insert into consignee values(501,'Amir','Dhaka',302,'01814535647',201);
insert into consignee values(502,'Mahmud','Chittagong',301,'01717436945',205);
insert into consignee values(503,'Rifat','Chittagong',301,'01864746679',207);
insert into consignee values(504,'Jahir','Khulna',303,'01835140838',202);
insert into consignee values(505,'Minhaz','Rangpur',305,'01853746582',208);

---DML---
---a)Find the details of all shipper:---
select * from shipper;

---b)Show shippes names whose branch_id=303---
select shipper_name from shipper where branch_id=303;

---c)Find the details of All cargo:---
select * from cargo;

---d)Find cargo name and cargo id from cargo table whose mark is ‘Temperature Sensitive’:---
select cargo_name,booking_id from cargo where mark='Temperature Sensitive';

---e)Finds details of all branches:---
select * from branch;

---f)Find branch id of the supervisor with id 206 from branch table:---
select branch_id from branch where supervisor_id=206;

---g)Find details of all consignee:---
select * from consignee;

---h)Find consignee id and name from consignee table whose branch id is larger than 302:---
select consignee_id,consignee_address from consignee where branch_id>302;

---i)Find consignee id and phone from consignee whose id is between 502 and 504:---
SELECT consignee_id,consignee_phone FROM consignee WHERE consignee_id BETWEEN 502
AND 504;

---j) find weight and mark from cargo table whose cargo id is not belongs to 12 and 14:---
SELECT weight,mark FROM cargo WHERE cargo_id NOT IN(12,14);


---B)Searching data from multiple table:---
---a)Find branch name,consignee name from branch and consignee table if the branch id are same
in two tables:---
SELECT branch.branch_name,consignee.consignee_name FROM
branch,consignee WHERE branch.branch_id= consignee.branch_id;

---b)Show shipper Address,cargo name,consignee name from shipper,cargo and consignee table in
same column named as multiple data(using UNION):---
SELECT shiper_address AS multiple_data from shipper
UNION
SELECT cargo_name from cargo
UNION
SELECT consignee_name from consignee;

---c)Find all shipper phone from shipper and branch id from cargo table if shipper id and cargo
booking id is same.(using INNER JOIN):---
SELECT shipper.shipper_phone,cargo.branch_id
FROM shipper
INNER JOIN cargo
ON shipper.shipper_id = cargo.booking_id;

---d)Find branch name from branch table and cargo name from cargo table if branch id of two tables
are same.(using RIGHT JOIN):---
SELECT branch.branch_name,cargo.cargo_name FROM branch RIGHT JOIN cargo
ON branch.branch_id =cargo.branch_id;

---e)Find shipper name and consignee id from shipper,consignee table if shipper id of shipper and
order no of consignee is same(using LEFT JOIN):
SELECT shipper.shipper_name,consignee.consignee_id FROM shipper LEFT JOIN consignee
ON shipper.shipper_id =consignee.order_no;

---C)Sub query:---
---a)Find shipper name whose branch name is Chittagong or Dhaka branch:---
select shipper_name from shipper where branch_id IN(select branch_id from branch where
branch_name IN('Chittagong_branch','Dhaka_branch'));

---b)Find cargo name and branch id from cargo and branch table if branch id of those tables are
same and branch id of branch table is greater than the branch id of the cosignee with id 502:---
select cargo.cargo_name,branch.branch_id from cargo,branch where
cargo.branch_id=branch.branch_id and branch.branch_id>
(select branch_id from consignee where consignee_id=502);

---c)Find consignee name from consignee whose order id are not exists in those shipper_id whose
branch id is greater than or equal to 303:---
select consignee_name from consignee where order_no NOT IN(select shipper_id from shipper
where branch_id>=303);

---d)Find branch name,branch id from branch table whose branch id is less than the branch id of
'ANCHOR LOGISTICS' cargo:---
select branch_name,branch_id from branch where branch_id<(select branch_id from cargo
where cargo_name='ANCHOR LOGISTICS');

---e)Find details of those shipper from shipper table whose shipper id lies between the booking id
of 'Fit Logistic Limited' and 'FAMOUS CARGO LINE' cargo:---
select * from shipper where shipper_id BETWEEN (select booking_id from cargo where
cargo_name='Fit Logistic Limited')AND(select booking_id from cargo where
cargo_name='FAMOUS CARGO LINE');

---D)Any types of query(optional):---
---a)Find total number of rows of shipper table:---
select count(*) AS total_shipper from shipper;

---b)Find cargo name from cargo table whose name exists ‘gis’ or ‘GIS’ as a substring:---
select cargo_name from cargo where cargo_name LIKE '%gis%' OR cargo_name LIKE '%GIS%';

---c)Find details of all shipper by sorting their name in descending order:---
select * from shipper ORDER BY shipper_name DESC;


