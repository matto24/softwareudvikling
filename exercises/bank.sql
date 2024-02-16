USE Bibliotek;

SHOW TABLES;

create table bog (
  bog_id int not null,
  bogtitel char(25) not null,
  udgivelsesår int not null,
  forfatter_navn char(25) not null,
  forfatter_id int not null,
  stregkode char(13) not null,
  PRIMARY KEY (bog_id),
  FOREIGN KEY (forfatter_id) REFERENCES forfatter(id)
); 

CREATE TABLE forfatter (
    id int not null,
    navn char(25) not null,
    nationalitet char(25) not null,
    fødselsår int not null,
    dødsår int,
    PRIMARY KEY (id)
);

CREATE TABLE låner (
    id int not null,
    adresse char(25) not null,
    cpr_nr char(10) not null,
    PRIMARY KEY (id)
);

CREATE TABLE udlån (
    udlån_id int not null,
    bog_id int not null,
    låner_id int not null,
    udlånsdato date not null,
    afleveringsdato date, 
    PRIMARY KEY (udlån_id),
    FOREIGN KEY (bog_id) REFERENCES bog(bog_id),
    FOREIGN KEY (låner_id) REFERENCES låner(id)  
);