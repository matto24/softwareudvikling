USE Company;

create table department (
  dname char(20) not null,
  dnumber numeric(1) not null,  
  mgrssn numeric(9) not null,   
  mgrstartdate date not null, 
  primary key (dnumber), 
  unique (dname)
);

create table employee (
  fname char(10) not null,
  lname char(20) not null,
  ssn numeric(9) not null,  
  bdate date not null,
  address char(30) not null,
  sex char(1) not null,
  salary numeric(5) not null,
  superssn numeric(9),
  dno numeric(1) not null, 
  primary key (ssn), 
  foreign key (dno) references department(dnumber)
); 

create table project (
  pname char(20) not null,
  pnumber numeric(2) not null,  
  plocation char(20) not null,
  dnum numeric(1) not null, 
  primary key (pnumber), 
  unique (pname), 
  foreign key (dnum) references department(dnumber)
); 

create table works_on (
  essn numeric(9) not null,  
  pno numeric(2) not null, 
  hours numeric(5,1),  
  primary key (essn, pno), 
  foreign key (essn) references employee(ssn),
  foreign key (pno) references project(pnumber)
); 

create table dependent (
  essn numeric(9) not null,  
  dependent_name char(10) not null,
  sex char(1) not null,
  bdate date not null,
  relationship char(30) not null,
  primary key (essn, dependent_name),
  foreign key (essn) references employee(ssn)
); 

create table dept_locations (
  dnumber numeric(1) not null,
  dlocation char (15) not null,
  primary key (dnumber, dlocation), 
  foreign key (dnumber) references department(dnumber)
);

insert into department values 
 ('Research',5,333445555,'1988-05-22'),
 ('Administration',4,987654321,'1995-01-01'),
 ('Headquarters',1,888665555,'1981-06-19');

insert into employee values 
 ('John','Smith',123456789,'1965-01-09','731 Fondren, Houston TX','M',30000,333445555,5),
 ('Franklin','Wong',333445555,'1965-12-08','638 Voss, Houston TX','M',40000,888665555,5),
 ('Alicia','Zelaya',999887777,'1968-01-19','3321 Castle, Spring TX','F',25000,987654321,4),
 ('Jennifer','Wallace',987654321,'1941-06-20','291 Berry, Bellaire TX','F',43000,888665555,4),
 ('Ramesh','Narayan',666884444,'1962-09-15','975 Fire Oak, Humble TX','M',38000,333445555,5),
 ('Joyce','English',453453453,'1972-07-31','5631 Rice, Houston TX','F',25000,333445555,5),
 ('Ahmad','Jabbar',987987987,'1969-03-29','980 Dallas, Houston TX','M',25000,987654321,4),
 ('James','Borg',888665555,'1937-11-10','450 Stone, Houston TX','M',55000,null,1);

insert into project values 
 ('ProductX',1,'Bellaire',5),
 ('ProductY',2,'Sugarland',5),
 ('ProductZ',3,'Houston',5),
 ('Computerization',10,'Stafford',4),
 ('Reorganization',20,'Houston',1),
 ('Newbenefits',30,'Stafford',4);

insert into works_on values 
 (123456789,1,32.5),
 (123456789,2,7.5),
 (666884444,3,40.0),
 (453453453,1,20.0),
 (453453453,2,20.0),
 (333445555,2,10.0),
 (333445555,3,10.0),
 (333445555,10,10.0),
 (333445555,20,10.0),
 (999887777,30,30.0),
 (999887777,10,10.0),
 (987987987,10,35.0),
 (987987987,30,5.0),
 (987654321,30,20.0),
 (987654321,20,15.0),
 (888665555,20,null);

insert into dependent values 
 (333445555,'Alice','F','1986-04-04','Daughter'),
 (333445555,'Theodore','M','1983-10-25','Son'),
 (333445555,'Joy','F','1958-05-03','Spouse'),
 (987654321,'Abner','M','1942-02-28','Spouse'),
 (123456789,'Michael','M','1988-01-04','Son'),
 (123456789,'Alice','F','1988-12-30','Daughter'),
 (123456789,'Elizabeth','F','1967-05-05','Spouse');

insert into dept_locations values
 (1,'Houston'),
 (4,'Stafford'),
 (5,'Bellaire'),
 (5,'Sugarland'),
 (5,'Houston');

alter table department 
 add constraint depemp foreign key (mgrssn) references employee(ssn);

alter table employee   
 add constraint empemp foreign key (superssn) references employee(ssn);

SHOW TABLES;
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM dependent;

--Q1: Vis navn og adresse på samtlige medarbejdere i ‘research’-afdelingen.
SELECT fname,lname,address 
FROM employee, department
WHERE employee.dno = department.dnumber
AND department.dname = 'Research';

--Q2: Vis fornavn og fødselsdag på John Smiths kone.
SELECT dependent.dependent_name, dependent.bdate 
FROM dependent, employee
WHERE dependent.essn = employee.ssn
AND employee.fname = 'John'
AND employee.lname = 'Smith'
AND dependent.relationship = 'Spouse';

--Q3: Vis navn på alle chefer.
SELECT employee.fname, employee.lname
FROM employee, department
WHERE employee.ssn = department.mgrssn;


--Q4: Vis ansattes navn og fødselsdag sorteret efter alder.
SELECT fname, lname, bdate
FROM employee
ORDER BY bdate;


--Q5: Opret ny dependent, som hedder Joe, er født den 12. december 1992 og søn af 555777222. Ingen har det SSN?
SELECT * FROM dependent;

INSERT INTO dependent (essn, dependent_name, sex, bdate, relationship) 
VALUES (555777222,'Joe','M','1992-12-12','Son');


--Q6: Opret ny ansat  Harold S. Viehmanfødt den 18. oktober 1947. Han bor på adressen 840 Belfry Drive, Lansdale, Pa. og har social security number 569123456. Han skal have arbejdsplads i Stafford og Jennifer Wallace som chef. Løn: $ 45.000.

--Bestem Jennifer Wallace's ssn
SELECT ssn FROM employee
WHERE fname = 'Jennifer'
AND lname = 'Wallace';

--Arbejdsplads i stanford find dno
SELECT dnumber FROM dept_locations
WHERE dlocation = 'Stafford';

INSERT INTO employee (fname, lname, ssn, bdate, address, sex, salary, superssn, dno)
VALUES ('Harold S.', 'Viehman', 569123456, '1947-10-18', '840 Belfy Drive, Lansdale', 'M', 45000, 987654321, 4);

--Q7: Joyce English er flyttet til adressen 211 Chalon Street, Austin, Texas.
SELECT * FROM employee
where fname = 'Joyce'
AND lname = 'English';


UPDATE employee
SET address = '211 Chalon Street, Austin TX'
WHERE fname = 'Joyce' AND lname = 'English';


--Q8: Jennifer Wallaces mand er afgået ved døden.

--Tjek relationer
SELECT dependent.dependent_name, dependent.relationship FROM dependent, employee
WHERE dependent.essn = employee.ssn
AND employee.fname = 'Jennifer'
AND employee.lname = 'Wallace';

--Fjern mand
DELETE FROM dependent 
WHERE essn IN (
    SELECT ssn FROM employee
    WHERE fname = 'Jennifer' AND lname = 'Wallace'
) AND dependent.relationship = 'Spouse';




--Q9: Vis navn og adresse på ansatte, som ikke bor i Texas.
SELECT fname, lname, address FROM employee 
WHERE address NOT LIKE '%TX%';

--Q10: Vis navnene på de ansatte, som tjener over $ 40.000.
SELECT fname, lname, salary 
FROM employee
WHERE salary>40000
ORDER BY salary DESC;
