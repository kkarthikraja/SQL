/* Karthik */
/* City Jail Database */
/* Chapter 5 */

/* -----------------------------
1) Create and execute statements to perform the following DML activites. Save the changes permanently to the database.
  a) Create a script to allow a user to add new criminals to the CRIMINALS table.
  b) Add the following criminals, using the script created in the previous step. No value needs to be entered af it should be set to the DEFAULT column value. Query the CRIMINALS table to confirm that new rows have been added.
  c) Add a column named Mail_flag to the CRIMINALS table. The column should be assigned a datatype of CHAR(1).
  d) Set the Mail_flag column to a value of 'Y' for all criminals.
  e) Set the Mail_flag column to 'N' for all criminals who don't have a street address recorded in the database.
  f) Change the phone number for criminal 1016 to 7225659032.
  g) Remove criminal 1017 from the database
----------------------------------------------------- */

INSERT INTO criminals(criminal_ID, last_col, first_col, street, city, state, zip, phone, v_status, p_status)
VALUES(1015, 'Fenter', 'Jim', '', 'Chesapeake', 'VA', 23320, '', DEFAULT, DEFAULT);
INSERT INTO criminals(criminal_ID, last_col, first_col, street, city, state, zip, phone, v_status, p_status)
VALUES(1016, 'Saunder', 'Bill', '11 Apple Rd', 'Virgina Beach', 'VA', 23455, 7678217443, DEFAULT, DEFAULT);
INSERT INTO criminals(criminal_ID, last_col, first_col, street, city, state, zip, phone, v_status, p_status)
VALUES(1017, 'Painter', 'Troy', '77 Ship Lane', 'Norfolk', 'VA', 22093, 7677655454, DEFAULT, DEFAULT);
DESC criminals;
ALTER TABLE criminals
MODIFY mail_flag CHAR(1);
UPDATE criminals
SET mail_flag = 'Y';
UPDATE criminals
SET mail_flag = 'N'
WHERE street = '';
UPDATE criminals
SET phone = 7225659032
WHERE criminal_ID = 1016;
DELETE FROM criminals
WHERE criminal_ID = 1017;

/* The city's Crime Analysis unit has submitted the following data requests. Provide the SQL statements using subqueries to satisfy the requests. */


/*Problem 1 */
/* List the name of each officer who has reported more than the average number of crimes officers have reported */
SELECT officer_id
FROM  crime_officers JOIN crime_charges USING(crime_id)
WHERE crime_charges >ALL (SELECT AVG(COUNT(*))
                    FROM crime_charges) ;
                     
/*Problem 2 */
/*List the criminal names for all criminals who have a less than average number of crimes and aren't listed as violent offenders */
SELECT cls.criminal_id, cls.first, cls.last, cr.crime_id
FROM criminals cls
JOIN crimes cr
ON cls.criminal_id = cr.criminal_id
WHERE crime_id <ALL (SELECT AVG(COUNT(*))
                    FROM crimes )
AND cls.v_status = 'N';

/*Problem 3 */
/* List appeal information for each appeal that has less than average number of days between filing and hearing dates */
SELECT *
FROM appeals
WHERE AVG((filing_date - hearing_date)) <ALL (SELECT AVG((filing_date - hearing_date));

/*Problem 4 */
/* List the names of probation officers who have had a less than average number of criminals assigned */
SELECT p.prob_id, p.last, p.first 
FROM prob_officers p
JOIN sentences s
ON p.prob_id = s.prob_id
WHERE crime_id <ALL (SELECT AVG (COUNT(*))
                    FROM sentences;

/*Problem 5 */
/* List each crime that has had the highest number of appeals recorded */
SELECT c.crime_id, c.crime_code, c.crime_charges, a.filing_date
FROM crime_charges c
JOIN appeals a
ON c.crime_id = a.crime_id
WHERE a.filing_date >ALL (SELECT MAX(filing_date)
							FROM appeals);


/* In chaper 1, you designed the new databases for City Jail. Now you need to create all the tables for the database. Second make the modifications listed in section B. */
CREATE TABLE aliases (
alias_ID NUMBER(6),
criminal_ID NUMBER(6,0),
alias_col VARCHAR2(10)
);
CREATE TABLE  criminals (
criminal_ID NUMBER(6,0),
last_col VARCHAR2(15),
first_col VARCHAR2(10),
street VARCHAR2(30),
city VARCHAR2(20),
state CHAR(2),
zip CHAR(5),
phone CHAR(10),
v_status CHAR(1) DEFAULT 'N',
p_status CHAR(1) DEFAULT 'N'
);
CREATE TABLE crimes (
crime_ID NUMBER(9,0),
criminal_ID NUMBER(6,0),
classification CHAR(1),
data_changed DATE DEFAULT SYSDATE,
status CHAR(2),
hearing_date DATE,
appeal_cut_date DATE,
);
CREATE TABLE sentences (
sentence_ID NUMBER(6),
criminal_ID NUMBER(6,0),
type_col CHAR(1),
prob_ID NUMBER(5),
start_date DATE,
end_date DATE,
violations NUMBER(3)
);
CREATE TABLE prob_officers (
prob_ID NUMBER(5),
last_col VARCHAR2(15),
first_col VARCHAR2(10),
street VARCHAR2(30),
city VARCHAR2(20),
state CHAR(2),
zip CHAR(5,0),
phone CHAR(10,0),
email VARCHAR2(30),
status CHAR(1) DEFAULT 'A'
);
CREATE TABLE crime_charges (
charge_ID NUMBER(10,0),
crime_ID NUMBER(9,0),
crime_code NUMBER(3,0),
charge_status CHAR(2),
fine_amount NUMBER(7,2),
court_fee NUMBER(7,2),
amount_paid NUMBER(7,2),
pay_due_date DATE
);
CREATE TABLE crime_officers (
crime_ID NUMBER(9,0),
officer_ID NUMBER(8,0)
);
CREATE TABLE officers (
officer_ID NUMBER(8,0),
last_col VARCHAR2(15),
first_col VARCHAR2(10),
precinct CHAR(4),
badge VARCHAR2(14),
phone CHAR(10,0),
status CHAR(1) DEFAULT 'A'
);
CREATE TABLE appeals (
appeal_ID NUMBER(5),
crime_ID NUMBER(9,0),
filing_date DATE,
hearing_date DATE,
status CHAR(1) DEFAULT 'P'
);
CREATE TABLE crime_codes (
crime_code NUMBER(3,0),
code_description VARCHAR2(30)
);

/* Section B */
/* ---------------------------------
1)Add a default value of U for the classification column of the Crimes table
2)Add a column named Date_Recorded to the Crimes table. This column needs to hold date values and should be set to current date by default
3)Add a column to the Prob_officers table to contain the pager number for each officer. The column needs to accomodate a phone number, including area code. Name the column Pager#
4)Change the Alias column in the Aliases table to accommodate up to 20 characters
------------------------------------ */

ALTER TABLE crimes
MODIFY classification DEFAULT 'U';

ALTER TABLE crimes
ADD(date_recorded DATE DEFAULT SYSDATE);

ALTER TABLE prob_officers
ADD(pager# NUMBER(10));

ALTER TABLE aliases
MODIFY(alias_col VARCHAR2(20));

/* In previous chapters, you have designed and created tables for the City Jail Database. These tables don't include any constraints. Review the information from previous chapters to determine what constraints you might need for the City Jail database.
1) First, drop the APPEALS, CRIME_OFFICERS, and CRIME_CHARGES tables constructed in chapter 3. These three tables are to be built last, using a CREATE TABLE command that includes all the necessary constraints.
2) Second, use the ALTER TABLE command to add all constraints to the existing tables. Note that the sequence of constraint addition has an impact. Any tables referenced by FOREIGN KEYs must already have the PRIMARY KEY created.
3) Third, use the CREATE TABLE command, including all constraints, to build the three tables dropped in the first step. 
*/

DROP TABLE  criminals CASCADE CONSTRAINTS;
DROP TABLE  crimes CASCADE CONSTRAINTS;
CREATE TABLE criminals
  (criminal_id NUMBER(6),
   last VARCHAR2(15),
   first VARCHAR2(10),
   street VARCHAR2(30),
   city VARCHAR2(20),
   state CHAR(2),
   zip CHAR(5),
   phone CHAR(10),
   v_status CHAR(1) DEFAULT 'N',
   p_status CHAR(1) DEFAULT 'N' );
CREATE TABLE crimes
  (crime_id NUMBER(9),
   criminal_id NUMBER(6),
   classification CHAR(1),
   date_charged DATE,
   status CHAR(2),
   hearing_date DATE,
   appeal_cut_date DATE);
ALTER TABLE crimes
  MODIFY (classification DEFAULT 'U');
ALTER TABLE crimes
  ADD (date_recorded DATE DEFAULT SYSDATE);
ALTER TABLE criminals
  ADD CONSTRAINT criminals_id_pk PRIMARY KEY (criminal_id);
ALTER TABLE criminals
  ADD CONSTRAINT criminals_vstatus_ck CHECK (v_status IN('Y','N'));
ALTER TABLE criminals
  ADD CONSTRAINT criminals_pstatus_ck CHECK (p_status IN('Y','N'));
ALTER TABLE crimes
  ADD CONSTRAINT crimes_id_pk PRIMARY KEY (crime_id);
ALTER TABLE crimes
  ADD CONSTRAINT crimes_class_ck CHECK (classification IN('F','M','O','U'));
ALTER TABLE crimes
  ADD CONSTRAINT crimes_status_ck CHECK (status IN('CL','CA','IA'));
ALTER TABLE crimes
  ADD CONSTRAINT crimes_criminalid_fk FOREIGN KEY (criminal_id)
             REFERENCES criminals(criminal_id);
ALTER TABLE crimes
  MODIFY (criminal_id NOT NULL);

/* The head DBA has requested the creation of a sequence for the primary key columns of the Criminals and Crimes tables. After creating the sequences, add a new criminal named Johnny Capps to the Criminals table by using the correct sequence (use any values for the remainder of columns). A crime needs to be added for the criminal too. Add a row to the Crimes table, referencing the sequence value already generated for the Crime_ID value (use any values for the remainder of columns).
*/
CREATE SEQUENCE city_jail_criminals_seq
INCREMENT BY 1
START WITH 111111
NOCACHE NOCYCLE;

CREATE SEQUENCE city_jail_crimes_seq
INCREMENT BY 1
START WITH 111111111
NOCACHE NOCYCLE;

INSERT INTO criminals(criminal_id, last, first, street, city, state, zip, phone,
v_status, p_status)
VALUES (city_jail_criminals_seq.NEXTVAL, 'Capps', 'Johnny', '77 Broadway Street',
'Denver', 'CO', 80246, 3035555555, 'N', 'N');

INSERT INTO crimes(crime_id, criminal_id, classification, date_charged, 
status, hearing_date, appeal_cut_date)
VALUES (city_jail_crimes_seq.NEXTVAL, city_jail_criminals_seq.CURRVAL,
'F', '02-FEB-2009', 'U', '02-JUL-2009', '02-AUG-2009');

/* -------------------------------------------------------------------------------------- */
/* CH 6 Problem 2 */
/* The last name, street, and phone number columns of the Criminals table are used quite often in the WHERE clause condition of queries. Create objects that might improve data retrieval for these queries.
*/

CREATE PUBLIC SYNONYM
lastname
FOR last.criminals;

CREATE PUBLIC SYNONYM
street
FOR street.criminals;

CREATE PUBLIC SYNONYM
phone#
FOR phone.criminals;

/* The City Jail organization is preparing to deploy the new database to four departments. The departments and associated duties for the database are described in the following chart:
	-Criminal Records (8 employees)- Add new criminals and crime charges, Make changes to criminal and crime charge data as needed for corrections or updates, Keep the police officer information up to date, Maintain the crime codes list.
	-Court Recording (7 employees)- Enter and modify all court appeals information, Enter and maintain all probation information, Maintain the probation officer list.
	-Crimes Analysis (4 employees)- Analyze all criminal and court data to identify trends, Query all crimes data as needed to prepare federal and state reports.
	-Data Officer (1 employee)- Remove crimes, court, and probation data based on approved requests from any of the other departments.
*/
/* Based on the department duties outlined in the table, develop a plan to assign privileges to employees in all four departments. The plan should include the following:
	-A description of what types of objects are required
	-A list of commands needed to address user creation for each department
*/


/*CH 7 Problem 1*/
/* The very first step that must be taken with all departments is creating the
users for each department and ensuring they are secure by using a password
expire option. A grant session command must be used on all users so that they
are able to log onto the system. I would then create four roles to represent
the four departments. These roles will specify privileges the employees have.
The following are the privileges each department would have:
Criminal Records Department(8 employees)
These people need to be able to view, update and enter new data into all tables
however we want to make sure that they don't accidently(or intentionally) delete
records from the table so they should not have access to DROP.
For this they would need to SELECT, INSERT, INDEX, ALTER, SELCET, and UPDATE.
Court Recording Department(7 employees)
These people only need to access the crimes table and the probation 
officers/probation management tables. For these tables they would need to be
able to view, update, and enter new data. They would not have access to the
DROP command. For this they would need to ALTER, INSERT, SELECT, INDEX, and
UPDATE.
Crimes Analysis Department(4 employees)
This department does not need to be able to update or add any new records they
just will be viewing them. They will need access to the crimes table and court
records if applicable. For their job they would need to just be able to query
using the SELECT and INDEX statements.
Data Officer Department(1 employee)
The purpose of this role is to remove data so they would have to have access
to the DELETE command.   */

/*CH 7 Problem 2*/
CREATE USER crim_rec_01
IDENTIFIED BY password1;
ALTER USER crim_rec_01
IDENTIFIED BY password1
PASSWORD EXPIRE;

CREATE USER crim_rec_02
IDENTIFIED BY password2;
ALTER USER crim_rec_02
IDENTIFIED BY password2
PASSWORD EXPIRE;

CREATE USER crim_rec_03
IDENTIFIED BY password3;
ALTER USER crim_rec_03
IDENTIFIED BY password3
PASSWORD EXPIRE;

CREATE USER crim_rec_04
IDENTIFIED BY password4;
ALTER USER crim_rec_04
IDENTIFIED BY password4
PASSWORD EXPIRE;

CREATE USER crim_rec_05
IDENTIFIED BY password5;
ALTER USER crim_rec_05
IDENTIFIED BY password5
PASSWORD EXPIRE;

CREATE USER crim_rec_06
IDENTIFIED BY password6;
ALTER USER crim_rec_06
IDENTIFIED BY password6
PASSWORD EXPIRE;

CREATE USER crim_rec_07
IDENTIFIED BY password7;
ALTER USER crim_rec_07
IDENTIFIED BY password7
PASSWORD EXPIRE;

CREATE USER crim_rec_08
IDENTIFIED BY password8;
ALTER USER crim_rec_08
IDENTIFIED BY password8
PASSWORD EXPIRE;

CREATE USER court_rec_01
IDENTIFIED BY password1;
ALTER USER court_rec_01
IDENTIFIED BY password1
PASSWORD EXPIRE;

CREATE USER court_rec_02
IDENTIFIED BY password2;
ALTER USER court_rec_02
IDENTIFIED BY password2
PASSWORD EXPIRE;

CREATE USER court_rec_03
IDENTIFIED BY password3;
ALTER USER court_rec_03
IDENTIFIED BY password3
PASSWORD EXPIRE;

CREATE USER court_rec_04
IDENTIFIED BY password4;
ALTER USER court_rec_04
IDENTIFIED BY password4
PASSWORD EXPIRE;

CREATE USER court_rec_05
IDENTIFIED BY password5;
ALTER USER court_rec_05
IDENTIFIED BY password5
PASSWORD EXPIRE;

CREATE USER court_rec_06
IDENTIFIED BY password6;
ALTER USER court_rec_06
IDENTIFIED BY password6
PASSWORD EXPIRE;

CREATE USER court_rec_07
IDENTIFIED BY password7;
ALTER USER court_rec_07
IDENTIFIED BY password7
PASSWORD EXPIRE;

CREATE USER crim_ana_01
IDENTIFIED BY password1;
ALTER USER crim_ana_01
IDENTIFIED BY password1
PASSWORD EXPIRE;

CREATE USER crim_ana_02
IDENTIFIED BY password2;
ALTER USER crim_ana_02
IDENTIFIED BY password2
PASSWORD EXPIRE;

CREATE USER crim_ana_03
IDENTIFIED BY password3;
ALTER USER crim_ana_03
IDENTIFIED BY password3
PASSWORD EXPIRE;

CREATE USER crim_ana_04
IDENTIFIED BY password4;
ALTER USER crim_ana_04
IDENTIFIED BY password4
PASSWORD EXPIRE;

CREATE USER data_officer
IDENTIFIED BY password1;
ALTER USER data_officer
IDENTIFIED BY password1
PASSWORD EXPIRE;

CREATE ROLE criminal_records;
GRANT criminal_records
TO crim_rec_01, crim_rec_02, crim_rec_03, crim_rec_04, crim_rec_05, crim_rec_06,
crim_rec_07, crim_rec_08;

CREATE ROLE court_recording;
GRANT court_recording
TO court_rec_01, court_rec_02, court_rec_03, court_rec_04, court_rec_05,
court_rec_06, court_rec_07;

CREATE ROLE crimes_analysis;
GRANT crimes_analysis
TO crim_ana_01, crim_ana_02, crim_ana_03, crim_ana_04;

CREATE ROLE officer_data;
GRANT officer_data
TO data_officer;

GRANT CREATE SESSION
TO criminal_records, court_recording, crimes_analysis, officer_data;

GRANT UPDATE, INSERT, SELECT, COMMENT, BACKUP, ALTER, CREATE
TO crimial_records;
GRANT select, insert, update, index
ON criminals
TO criminal_records;
GRANT select, insert, update, index
ON crimes
TO criminal_records;
GRANT select, insert, update, index
ON police_officers
TO criminal_records;
GRANT select, insert, update, index
ON crime_codes
TO criminal_records;

GRANT UPDATE, INSERT, COMMENT, BACKUP, ALTER, CREATE
TO court_recording;
GRANT select, insert, update, index
ON criminals
TO court_recording;
GRANT select, insert, update, index
ON crimes
TO court_recording;
GRANT select, insert, update, index
ON probation
TO court_recording;
GRANT select, insert, update, index
ON probation_officers
TO court_recording;

GRANT SELECT, COMMENT
TO crimes_anaylysis;
GRANT select, index
ON criminals
TO crimes_analysis;
GRANT select, index
ON crimes
TO crimes_analysis;

GRANT DELETE, COMMENT, DROP
TO officer_data
WITH ADMIN OPTION;
GRANT select, delete
ON criminals
TO officer_data;
GRANT select, delete
ON crimes
TO officer_data;
GRANT select, delete
ON probation
TO officer_data;

/* The following list reflects common data requests from city managers. Write the SQL statements to satisfy the requests. */


/*CH 8 Problem 1 */
/* List all criminal aliases beginning with the letter B */
SELECT alias
FROM aliases
WHERE alias LIKE 'B%' ;

/*CH 8 Problem 2 */
/* List all crimes that occurred (were charged) during the month October 2008. List the crime ID, criminal ID, date charged, and classification. */
SELECT crime_ID, criminal_ID, date_charged, classification
FROM crimes
WHERE hearing_date BETWEEN '01-OCT-08' AND '31-OCT-08' ;

/*CH* Problem 3 */
/* List all crimes with a status of CA(can appeal) or IA(in appeal). List the crime ID, criminal ID, date charged, and status. */
SELECT crime_ID, criminal_ID, date_charged, status
FROM crimes
WHERE status IN ('CA', 'IA');

/*CH 8 Problem 4 */
/* List all crimes classified as a felony. List the crime ID, criminal ID, date charged, and classification. */
SELECT crime_ID, criminal_ID, date_charged, classification
FROM crimes
WHERE classification = 'F' ;

/*CH 8 Problem 5 */
/* List all crimes with a hearing date more than 14 days after the date charged. List the crime ID, criminal ID, date charged, and hearing date. */
SELECT crime_ID, criminal_ID, date_charged, hearing_date
FROM crimes
WHERE hearing_date-date_charged > 14;

/*CH 8 Problem 6 */
/* List all criminals with the zip code 23510. List the criminal ID, last name, and zip code. Sort the list by criminal ID. */
SELECT criminal_ID, last, zip
FROM criminals
WHERE zip = 23510;

/*CH 8 Problem 7 */
/* List all crimes that don't have a hearing date scheduled. List the crime ID, criminal ID, date charged, and hearing date. */
SELECT crime_ID, criminal_ID, date_charged, hearing_date
FROM crimes
WHERE hearing_date IS NULL;

/*CH 8 Problem 8 */
/* List all sentences with a probation officer assigned. List the sentence ID, criminal ID, and probation officer ID. Sort the list by probation officer ID and then criminal ID. */
SELECT sentence_ID, criminal_ID, prob_ID
FROM sentences
WHERE prob_ID IS NOT NULL
ORDER BY prob_ID, criminal_ID;

/*CH 8 Problem 9 */
/* List all crimes that are classified as misdemeanors and are currently in appeal. List the crime ID, criminal ID, classification, and status. */
SELECT crime_ID, criminal_ID, classification, status
FROM crimes
WHERE classification = 'M' AND status = 'IA';

/*CH 8 Problem 10 */
/* List all crime charges with a balance owed. List the charge ID, crime ID, fine amount, court fee, amount paid, and amount owed. */
SELECT charge_ID, crime_ID, fine_amount, court_fee, amount_paid, 
fine_amount + court_fee - amount_paid AS "Amount Owed"
FROM crime_charges
WHERE "Amount Owed" > 0;

/*CH 8 Problem 11 */
/* List all police officers who are assigned to the precinct OCVW or GHNT and have a status of active. List the officer ID, last name, precinct, and status. Sort the list by precint and then by officer last name. */
SELECT officer_ID, last, precinct, status
FROM officers
WHERE precinct IN('OCVW', 'GHNT') AND  status = 'A'
ORDER BY precinct, last;

/* The following list reflects the current data requests from city managers. Provide the SQL statements that satisfy the requests. For each request, include one solution using the traditional method and one using an ANSI JOIN statement. */


/*------------------------------------------------------------------------------- */
/* Problem 1 : List all criminals along with the crime charges filed. The report needs to include the criminal ID, name, crime code, and fine amount. */

/*CH 9 Problem 1 */
/*Traditional Method */
SELECT cls.criminal_id, cls.first, cls.last, cc.crime_code, cc.fine_amount
FROM crime_charges cc, crimes cr, criminals cls
WHERE cc.crime_id = cr.crime_id
  AND cr.criminal_id = cls.criminal_id
ORDER BY criminal_id, first, last, crime_code, fine_amount;

/* Join Method */
SELECT cls.criminal_id, cls.first, cls.last, cc.crime_code, cc.fine_amount
FROM criminals cls
  JOIN crimes cr
    ON cr.criminal_id = cls.criminal_id
  JOIN crime_charges cc
    ON cc.crime_id = cr.crime_id
ORDER BY criminal_id, first, last, crime_code, fine_amount;
/* ---------------------------------------------------------------------------------- */

/* --------------------------------------------------------------------------------- */
/* Problem 2 : List all criminals along with crime status and appeal status (if applicable). The reports need to include the criminal ID, name, crime classification, date charged, appeal filing date, and appeal status. Show all criminals, regardless of whether they have filed an appeal. */

/*CH 9 Problem 2 */
/*Traditional Method */
SELECT cls.criminal_id, cls.first, cls.last, cr.classification, cr.date_charged,
  ap.filing_date, ap.status
FROM criminals cls, crimes cr, appeals ap
WHERE cls.criminal_id = cr.criminal_id
  AND cr.crime_id = ap.crime_id
ORDER BY criminal_id;

/*JOIN Method */
SELECT cls.criminal_id, cls.first, cls.last, cr.classification, cr.date_charged,
  ap.filing_date, ap.status
FROM criminals cls
JOIN crimes cr
  ON cr.criminal_id = cls.criminal_id
JOIN appeals ap
  ON ap.crime_id = cr.crime_id
ORDER BY criminal_id;
/* --------------------------------------------------------------------------------- */

/* ----------------------------------------------------------------------- */
/* Problem 3 : List all criminals along with crime information. The report needs to include the criminal ID, name, crime classification, date charged, crime code and fine amount. Include only crimes classified as "Other". Sort the list by Criminal ID and Date Charged. */

/*CH 9 Problem 3*/
/*Traditional Method */
SELECT cls.criminal_id, cls.first, cls.last, cr.classification, cr.date_charged,
  cc.fine_amount, cc.crime_code
FROM criminals cls, crimes cr, crime_charges cc
WHERE cls.criminal_id = cr.criminal_id
  AND cr.crime_id = cc.crime_id
  AND classification = 'O'
ORDER BY criminal_id, date_charged;

/*JOIN METHOD*/
SELECT cls.criminal_id, cls.first, cls.last, cr.classification, cr.date_charged,
  cc.fine_amount, cc.crime_code
FROM criminals cls
JOIN crimes cr
  ON cr.criminal_id = cr.criminal_id
JOIN crime_charges cc
  ON cc.crime_id = cr.crime_id
WHERE classification = 'O'
ORDER BY criminal_id, date_charged;
/* ---------------------------------------------------------------------------------- */

/* -------------------------------------------------------------------- */
/* Problem 4 : Create an alphabetical list of all criminals, including criminal ID, name, violent offender status, parole status, and any known aliases. */

/*CH 9 Problem 4 */
/*Traditional Method*/
SELECT c.criminal_id, c.first, c.last, c.v_status, c.p_status, a.alias
FROM criminals c, aliases a
WHERE c.criminal_id = a.criminal_id(+)
ORDER BY c.last, c.first;

/*JOIN Method */
SELECT c.criminal_id, c.first, c.last, c.v_status, c.p_status, a.alias
FROM criminals c LEFT OUTER JOIN aliases a
  ON c.criminal_id = a.criminal_id
ORDER BY last, first;
/* ------------------------------------------------------------------ */

/* ------------------------------------------------------------------------- */
/* Problem 5 : A table named Prob_Contact contains the required frequency of contact with a probation officer, based on the length of the probation period (the number of days assigned to probation).
Review the data in the table, which indicated ranges for the number of days and applicable contact frequencies. Create a list containing each criminal who has been assigned a probation period, which is indicated by the sentence type.
The list should contain the criminal name, probation start date, probation end date, and required frequency of contact. Sort the list by criminal name and probation start date. */

/*CH 9 Problem 5 */
/*Traditional Method */
SELECT c.last, c.first, s.start_date, s.end_date, p.con_freq
FROM criminals c, sentences s, prob_contact p
WHERE c.criminal_id = s.criminal_id
  AND s.end_date - s.start_date >= p.low_amt
  AND s.end_date - s.start_date <= p.high_amt
  AND s.type = 'P'
ORDER BY last, first, start_date;

/*JOIN Method */
SELECT c.last, c.first, s.start_date, s.end_date, p.con_freq
FROM criminals c
JOIN sentences s
  ON s.type = 'P'
JOIN prob_contact p
  ON s.end_date - s.start_date >= p.low_amt
  AND s.end_date - s.start_date <= p.high_amt
ORDER BY last, first, start_date;
/* ---------------------------------------------------------------------- */

/* ------------------------------------------------------------------ */
/* Problem 6 : A column named Mgr_ID has been added to the Prob_Officers table and contains the ID number of the Probation supervisor for each officer. Produce a list showing each probation officer's name and his or her supervisor's name. Sort the list alphabetically by probation officer name. */

/*CH 9 Problem 6 */
/*Tradtional Method */
SELECT pro.last, pro.first, mgr.last AS "Manager Last Name", mgr.first AS
  "Manager First Name"
FROM prob_officers pro, prob_officers mgr
WHERE pro.mgr_id = mgr.prob_id(+)
ORDER BY pro.last, pro.first;

/*JOIN Method */
SELECT pro.last, pro.first, mgr.last AS "Manager Last Name", mgr.first AS
  "Manager First Name"
FROM prob_officers pro LEFT OUTER JOIN prob_officers mgr
  ON pro.mgr_id = mgr.prob_id
ORDER BY last, first;
