CREATE DATABASE kiosk;

USE kiosk

create table produkt (
  produkt_id int not null,
  navn char(25) not null,
  pris int not null,
  primary key (produkt_id)
); 

create table dag (
  dag_id int not null,
  ugedag char(25) not null,
  vejr char(25) not null,
  temperatur int not null,
  primary key(dag_id)
);


create table ekspedient (
  ekspedient_id int not null,
  navn char(25) not null,
  primary key(ekspedient_id)
);


create table kunde (
  kunde_id int not null,
  navn char(25) not null,
  primary key(kunde_id)
);

create table salg (
  salg_id int not null,
  dag_id int not null,
  ekspedient_id int not null,
  kunde_id int not null,
  primary key(salg_id),
  foreign key (dag_id) references dag(dag_id),
  foreign key (ekspedient_id) references ekspedient(ekspedient_id),  
  foreign key (kunde_id) references kunde(kunde_id)
);

create table produktsalg (
  produktsalg_id int not null,
  salg_id int not null,
  produkt_id int not null,
  primary key(produktsalg_id),
  foreign key (salg_id) references salg(salg_id),
  foreign key (produkt_id) references produkt(produkt_id)
);

insert into ekspedient values
 (1,'James'),
 (2,'Jonny'),
 (3,'Josefine');
 
insert into kunde values
 (1,'Mikkel'),
 (2,'Søren'),
 (3,'Anders'),
 (4,'Emil'),
 (5,'Frederik'),
 (6,'Kasper');

insert into produkt values
 (1,'Flødeis', 45),
 (2,'Slik', 15),
 (3,'Sodavandsis', 10),
 (4,'Kage', 50),
 (5,'Toast', 100),
 (6,'Banan', 5),
 (7,'Kaffe', 25);
 
insert into dag values
 (1,'Mandag', 'Regn', 16),
 (2,'Tirsdag', 'Solskin', 21),
 (3,'Onsdag', 'Regn', 7),
 (4,'Torsdag', 'Regn', 10),
 (5,'Fredag', 'Solskin', 21),
 (6,'Lørdag', 'Solskin', 23),
 (7,'Søndag', 'Regn', 11);
 
insert into salg values
 (1,1,1,5),
 (2,2,2,1),
 (3,3,3,2),
 (4,4,1,3),
 (5,5,2,1),
 (6,1,3,5),
 (7,2,1,1),
 (8,3,1,6),
 (9,4,1,3),
 (10,5,1,5),
 (11,1,1,2),
 (12,2,2,5),
 (13,3,2,3),
 (14,4,2,2),
 (15,5,2,1);

insert into produktsalg values
 (1,2,1),
 (2,2,1),
 (3,2,3),
 (4,5,3),
 (5,5,3),
 (6,5,1),
 (7,5,1),
 (8,5,2),
 (9,1,2),
 (10,2,4),
 (11,3,5),
 (12,4,6),
 (13,5,7),
 (14,6,1),
 (15,7,2),
 (16,8,3),
 (17,9,4),
 (18,10,5),
 (19,11,6),
 (21,12,7),
 (22,13,1),
 (23,14,2),
 (24,15,3),
 (25,11,4),
 (26,12,5),
 (27,13,6),
 (28,14,7),
 (29,15,1);


--Opgave 1
--Vis navnet på alle produkter der koster under eller præcist gennemsnits prisen for produkter.

SELECT navn 
FROM produkt
WHERE pris <= (SELECT AVG(pris) FROM produkt);

--Opgave 2:
--Udregn den samlede indtjening for alle produktsalg.

SELECT SUM(pris) 
FROM produkt, produktsalg
WHERE produkt.produkt_id = produktsalg.produkt_id;

--Opgave 3:
--Vis ugedag for de dage hvor der ikke har været nogle salg.

SELECT dag.ugedag
FROM dag
LEFT JOIN salg ON dag.dag_id = salg.dag_id
WHERE salg.dag_id IS NULL;


--Opgave 4:
--Vis navnet på den ekspedient der har solgt for flest penge.

SELECT e.navn 
FROM ekspedient e
JOIN salg s ON s.ekspedient_id = e.ekspedient_id
JOIN produktsalg ps ON s.salg_id = ps.salg_id
JOIN produkt p ON ps.produkt_id = p.produkt_id
GROUP BY e.navn
ORDER BY SUM(p.pris) DESC
LIMIT 1;


--Opgave 5:
--Vis navnet på den kunde der har købt flest is, og hvor mange is der er købt

SELECT k.navn, COUNT(ps.salg_id) AS is_købt
FROM kunde k
JOIN salg s ON s.kunde_id = k.kunde_id
JOIN produktsalg ps ON ps.salg_id = s.salg_id
JOIN produkt p ON ps.produkt_id = p.produkt_id
WHERE p.navn LIKE '%is%'
GROUP BY k.navn
ORDER BY COUNT(ps.salg_id) DESC
LIMIT 1;


--Opgave 6
--Vis hvor stort beløb hver kunde har købt for, i rækkefølge mindst til størst.
SELECT k.navn, SUM(p.pris) AS købt_for
FROM kunde k
JOIN salg s ON k.kunde_id = s.kunde_id
JOIN produktsalg ps ON s.salg_id = ps.salg_id
JOIN produkt p ON ps.produkt_id = p.produkt_id
GROUP BY k.kunde_id
ORDER BY købt_for ASC;


--Opgave 7
--Vis den samlede indtjening for hver ugedag
SELECT dag.ugedag, SUM(p.pris) AS solgt_for
FROM dag
JOIN salg s ON dag.dag_id = s.dag_id
JOIN produktsalg ps ON s.salg_id = ps.salg_id
JOIN produkt p ON ps.produkt_id = p.produkt_id
GROUP BY dag.ugedag;

--Opgave 8
--For hvert salg kan der være tilknyttet flere produktsalg. Vis gennemsnits temperaturen for alle de salg
--hvor der indgår mindst et produktsalg af is.

SELECT AVG(avg_temp) FROM(
    SELECT AVG(d.temperatur) AS avg_temp
    FROM salg s
    JOIN dag d ON s.dag_id = d.dag_id
    JOIN produktsalg ps ON s.salg_id = ps.salg_id
    JOIN produkt p ON ps.produkt_id = p.produkt_id
    WHERE p.navn LIKE '%is%'
    GROUP BY s.salg_id
) subquery;


--Opgave 9
--Grundet GDPR skal alle kunde navne fjernes, lav en kommando der sætter alle kunde navne til 'Ukendt'.
--Bemærk denne kommando skal køres til sidst og der gives intent resultat.

UPDATE kunde
SET navn = 'Ukendt';
