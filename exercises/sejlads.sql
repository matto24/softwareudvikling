USE sejlads;

create table omraade (
  omraade_id int not null,
  navn char(25) not null,
  primary key (omraade_id)
); 

create table havn (
  havn_id int not null,
  navn char(25) not null,
  omraade_id int not null,
  primary key (havn_id),
  foreign key (omraade_id) references omraade(omraade_id) 
);

create table baadejer(
  baadejer_id int not null,
  navn char(25) not null,
  primary key (baadejer_id)  
);

create table baad(
  baad_id int not null,
  navn char(25) not null,
  baadtype char(25) not null,
  baadejer_id int not null,
  hjemme_havn int not null,
  primary key (baad_id),
  foreign key (baadejer_id) references baadejer(baadejer_id),
  foreign key (hjemme_havn) references havn(havn_id)
);

create table sejltur(
  sejltur_id int not null,
  dato date not null,
  varighed int not null,
  baad_id int not null,
  fra_havn int not null,
  til_havn int not null, 
  primary key (sejltur_id),
  foreign key (baad_id) references baad(baad_id),
  foreign key (fra_havn) references havn(havn_id),
  foreign key (til_havn) references havn(havn_id)	
);

insert into omraade values
 (1,'Fyn'),
 (2,'Samsø'),
 (3,'Ærø');
 
insert into havn values
 (1,'Bogense',1),
 (2,'Kerteminde',1),
 (3,'Svendborg',1),
 (4,'Faaborg',1),
 (5,'Ballen',2),
 (6,'Sælvig',2),
 (7,'Langør',2),
 (8,'Søby',3),
 (9,'Marstal',3),
 (10,'Ærøskøbing',3);

insert into baadejer values
 (1,'Aage Jensen'),
 (2,'Torben Schmidt'),
 (3,'Henriette Nielsen'),
 (4,'Poul Sørensen'),
 (5,'Hedvig Jensen'),
 (6,'Villads Holm'),
 (7,'Erik Pedersen'),
 (8,'Svendborg Bådudlejning');
 
insert into baad values
 (1,'Aage Måge','Drabant 27',1,1),
 (2,'Elviras fryd','Banner 30',8,3),
 (3,'Jenny','Trimaran',2,2),
 (4,'Havlit','Hvilling',8,3),
 (5,'Marianne','X-99',3,4),
 (6,'Neptun','Folkebåd',4,5),
 (7,'Sgt. Pepper','Ylva',5,6),
 (8,'Fremad','Ylva',6,7),
 (9,'Lydia','Bianca 28',7,9),
 (10,'Leonora','LM24',6,10);

insert into sejltur values
 (1,'2021-04-18',6,1,1,2),
 (2,'2020-09-23',4,2,7,1),
 (3,'2021-07-12',3,3,10,4),
 (4,'2019-06-18',8,4,4,6),
 (5,'2018-10-23',1,5,9,10),
 (6,'2021-07-14',9,6,7,8),
 (7,'2020-05-16',5,7,3,2),
 (8,'2017-09-24',4,8,6,5),
 (9,'2021-06-19',5,9,1,4),
 (10,'2020-04-12',2,10,10,3),
 (11,'2021-08-09',3,1,3,4),
 (12,'2020-08-01',6,2,7,3),
 (13,'2020-04-23',4,3,4,1),
 (14,'2021-07-02',3,4,9,4),
 (15,'2021-07-03',8,5,4,1);
 


--Q1 Lav en liste over navnene på de både, som er anløbet Ballen 
--i september måned. Navnet "Ballen" må hardkodes i forespørgslen, men ikke dens id (5).

SELECT baad.navn FROM baad, sejltur, havn
WHERE baad.baad_id = sejltur.baad_id
AND sejltur.til_havn = havn.havn_id
AND havn.navn = 'Ballen'
AND MONTH(sejltur.dato) = 9;

--Spørgsmål 2.
--Vis navnene på de bådejere som ikke har været ude at sejle.
SELECT navn FROM baadejer
WHERE baadejer.navn NOT IN (
    SELECT baadejer.navn FROM baadejer, sejltur, baad
    WHERE baadejer.baadejer_id = baad.baadejer_id
    AND baad.baad_id = sejltur.baad_id
);

--Spørgsmål 3.
--Udskriv navnet på den havn, som har flest hjemmehørende både.

SELECT omraade.navn, count(*) FROM omraade, havn, baad
WHERE omraade.omraade_id = havn.omraade_id
AND havn.omraade_id = baad.hjemme_havn
GROUP BY baad.hjemme_havn
ORDER BY count(*) DESC limit 1;

--Spørgsmål 4.
--Lav en oversigt over samtlige sejladser indeholdende 
--bådens navn, dato, varighed, navnet på fra-havnen og
--navnet på til-havnen. Det er tilladt at hardkode antallet af 
--rækker i sejltur-tabellen i forespørgslen.

SELECT baad.navn, sejltur.dato, sejltur.varighed, sejltur.fra_havn, hf.navn, sejltur.til_havn, ht.navn  
FROM sejltur, baad, havn AS hf, havn AS ht
WHERE baad.baad_id = sejltur.baad_id AND 
	hf.havn_id = sejltur.fra_havn AND
    ht.havn_id = sejltur.til_havn;

--Spørgsmål 5.
--Lav en liste over navnene samtlige områder med angivelse af antal havne pr område.
SELECT omraade.navn, count(*) 
FROM omraade, havn
WHERE omraade.omraade_id = havn.omraade_id
GROUP BY havn.omraade_id
ORDER BY count(*) DESC;
