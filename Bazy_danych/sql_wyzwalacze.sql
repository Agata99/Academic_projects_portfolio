---zad 7
--tabela pomocnicza
--drop table dane;
create table dane(
id          INTEGER PRIMARY KEY,
imie        VARCHAR2(20) NOT NULL,
nazwisko    VARCHAR2(20) NOT NULL,
data_ur     DATE NOT NULL,
kat_wiek    VARCHAR2(20)
);


create or replace trigger dodaj_dane before insert on dane for each row
declare
    v_rok number:=to_number(EXTRACT(year from sysdate)-EXTRACT(year from (:new.data_ur)));
    v_plec varchar2(1):=substr(:new.imie,length(:new.imie),1);
    v_kat_wiek varchar2(20);
begin
    if v_rok<1 then v_kat_wiek:='niemowle';
    elsif (v_rok>=1 and v_rok<=10 and v_plec='a') then v_kat_wiek:='dziewczynka';
    elsif (v_rok>=1 and v_rok<=10 and v_plec!='a') then v_kat_wiek:='chlopiec';
    elsif (v_rok>10 and v_rok<=19 and v_plec='a') then v_kat_wiek:='nastolatka';
    elsif (v_rok>10 and v_rok<=19 and v_plec!='a') then v_kat_wiek:='nastolatek';
    elsif (v_rok>19 and v_rok<=65 and v_plec='a') then v_kat_wiek:='kobieta';
    elsif (v_rok>19 and v_rok<=65 and v_plec!='a') then v_kat_wiek:='mezczyzna';
    elsif (v_rok>65 and v_plec='a') then v_kat_wiek:='emerytka';
    elsif (v_rok>65 and v_plec!='a') then v_kat_wiek:='emeryt';
    else v_kat_wiek:='blad';
    end if;
    :new.kat_wiek:=v_kat_wiek;
end;

insert into dane (id,imie,nazwisko,data_ur) values (1,'Ada','Kot',to_date('13\06\1989' ,'dd\mm\yyyy'));
insert into dane (id,imie,nazwisko,data_ur) values (2,'Adam','Kot',to_date('13\10\2019' ,'dd\mm\yyyy'));
insert into dane (id,imie,nazwisko,data_ur) values (3,'Marek','Darciak',to_date('10\09\1959' ,'dd\mm\yyyy'));
insert into dane (id,imie,nazwisko,data_ur) values (4,'Ela','Jarska',to_date('03\07\2002' ,'dd\mm\yyyy'));
insert into dane (id,imie,nazwisko,data_ur) values (5,'Magda','Lil',to_date('11\04\2020' ,'dd\mm\yyyy'));

select * from dane;

--zad8
--tabele pomocnicze
CREATE TABLE PRODUKT
   (	"ID" NUMBER(38,0) PRIMARY KEY, 
	"NAZWA" VARCHAR2(15 BYTE), 
	"CENA" FLOAT(126) 
	 );
 CREATE TABLE CENY_PRODUKTOW
   (	"ID" NUMBER(38,0) PRIMARY KEY, 
	"NAZWA" VARCHAR2(15 BYTE), 
	"POPRZEDNIA_CENA" FLOAT(126), 
	"CENA" FLOAT(126), 
	"DATA_MODYFIKACJI" DATE
   );

CREATE OR REPLACE TRIGGER modyfikacja_ceny
BEFORE UPDATE OF CENA ON produkt
FOR EACH ROW BEGIN

IF :NEW.CENA!=:OLD.CENA THEN 
INSERT INTO produkt(ID , NAZWA ,POPRZEDNIA_CENA, CENA , DATA_MODYFIKACJI)
VALUES (:OLD.ID,:OLD.NAZWA, :OLD.CENA, :NEW.CENA, SYSDATE);
END IF;

END;
UPDATE produkt SET cena=21 WHERE ID=1;


--zad 9

--tabele pomocnicze 
--drop table pracownik_kadr;
create table pracownik_kadr(
id          INTEGER PRIMARY KEY,
imie        VARCHAR2(20) NOT NULL,
nazwisko    VARCHAR2(20) NOT NULL,
pensja   NUMBER(7,2) NOT NULL,
id_kierownika integer not null references kierownik(id)
);

--drop table kierownik ;
create table kierownik(
id          INTEGER PRIMARY KEY,
imie        VARCHAR2(20) NOT NULL,
nazwisko    VARCHAR2(20) NOT NULL,
pensja   NUMBER(7,2) NOT NULL
);

        
insert into kierownik values (1,'Darek','Klos',9500);
insert into kierownik values (2,'Beata','Kowal',8500);

insert into pracownik_kadr values (1,'Arek','Mos',4400,1);
insert into pracownik_kadr values (2,'Marek','Adamczyk',2200,1);
insert into pracownik_kadr values (3,'Jarek','Snyk',2800,1);
insert into pracownik_kadr values (4,'Dorota','Wat',3500,2);
insert into pracownik_kadr values (5,'Jola','Zak',4500,1);
insert into pracownik_kadr values (6,'Ada','Lis',5000,2);
insert into pracownik_kadr values (7,'Hann','Kot',8900,2);

select * from pracownik_kadr;
select * from kierownik;

--drop trigger podwyzka;
create or replace trigger podwyzka after update of pensja on kierownik for each row
declare
procent number(4,2):=trunc((:new.pensja-:old.pensja)/(:old.pensja),2);
begin 
    if :old.id=1 then
    if :new.pensja>:old.pensja then
    for licznik in 1..7 loop
    update pracownik_kadr set pensja=pensja*(1+procent) where id=licznik;
    end loop;
    end if;
    end if;
end;

update kierownik set pensja=9800;
update kierownik set pensja=10000 where id=1;
update kierownik set pensja=10000 where id=2;
update kierownik set pensja=9000 where id=1;
select * from kierownik;
select * from pracownik_kadr;

--zad 10
--tabele pomocnicze
CREATE TABLE WSZYSTKIE_ZAMOWIENIA
   (	"ID" NUMBER(38,0) PRIMARY KEY, 
	"DATA_ZAMOWIENIA" DATE, 
	"STATUS" VARCHAR2(20 BYTE)
   ) ;

 CREATE TABLE ZREALIZOWANE_ZAMOWIENIA
   (	"ID" NUMBER(38,0) PRIMARY KEY, 
	"DATA_ZAMOWIENIA" DATE, 
	"STATUS" VARCHAR2(20 BYTE)
   ) ;


--wyzwalacz

CREATE OR REPLACE TRIGGER archiwum_zamowien
AFTER DELETE ON wszystkie_zamowienia
FOR EACH ROW BEGIN

IF :OLD.status='zrealizowane' THEN
INSERT INTO zrealizowane_zamowienia(ID , DATA_ZAMOWIENIA, STATUS)
VALUES (:OLD.ID,:OLD.DATA_ZAMOWIENIA, :OLD.STATUS);
END IF;
END;
--testowanie 
DELETE FROM wszystkie_zamowienia WHERE id=1;

-- zad 11




--tabele pomocnicze
--drop table sala;
create table sala(
id  integer primary key,
nr_sali varchar2(5) not null,
pietro integer not null,
opis varchar2(55)
);
--drop sequence sala_seq_id;
create sequence sala_seq_id start with 1 increment by 1 nomaxvalue;

insert into sala values (1,'1a',0,'magazyn');
insert into sala values (2,'2',0,'skladzik');
insert into sala values (3,'405',2,'salon gier');
insert into sala values (4,'66',1,'dla dzieci');

--drop table zabawka ;
create table zabawka(
id  integer primary key,
nazwa varchar2(30) not null,
id_sala integer constraint foreign references sala(id)
);

--drop sequence zabawka_seq_id;
create sequence zabawka_seq_id start with 1 increment by 1 nomaxvalue;

insert into zabawka values (1,'mis',1);
insert into zabawka values (2,'lalka',1);
insert into zabawka values (3,'pociag',2);
insert into zabawka values (4,'ps4',1);
insert into zabawka values (5,'samochod',3);

--drop view zabawki_lok;
create view zabawki_lok as
select nr_sali,pietro,nazwa
from zabawka z join sala s on s.id=z.id_sala;

select * from zabawki_lok;

--drop trigger wstawianie;
create or replace trigger wstawianie instead of insert on zabawki_lok 
for each row
begin
    if :new.pietro in (0,1,2) then
    insert into sala (id,nr_sali,pietro) values (sala_seq_id.nextval,:new.nr_sali,:new.pietro);
    insert into zabawka (id,nazwa) values (zabawka_seq_id.nextval,:new.nazwa);
    else raise_application_error(-20050,'Nie ma takiego pietra');
    end if;
end;

insert into zabawki_lok (nr_sali,pietro,nazwa) values ('2',0,'lalka'); 
insert into zabawki_lok (nr_sali,pietro,nazwa) values ('21',1,'kot'); 
insert into zabawki_lok (nr_sali,pietro,nazwa) values ('112',2,'balon'); 
insert into zabawki_lok (nr_sali,pietro,nazwa) values ('552',3,'pilka'); 

select * from zabawki_lok;
select * from zabawka;
select * from sala;

--zad12
--tabele pomocnicze
CREATE TABLE dzialy (
    id_dzialu     INTEGER NOT NULL,
    nazwa  VARCHAR2(20)
);

ALTER TABLE dzialy ADD CONSTRAINT dzialy_pk PRIMARY KEY ( id_dzialu);

CREATE TABLE pracownicy (
    id         INTEGER NOT NULL,
    imie       VARCHAR2(20),
    nazwisko   VARCHAR2(20),
    dzialy_id  INTEGER NOT NULL
);

ALTER TABLE pracownicy ADD CONSTRAINT pracownicy_pk PRIMARY KEY ( id );

ALTER TABLE pracownicy
    ADD CONSTRAINT pracownicy_dzialy_fk FOREIGN KEY ( dzialy_id )
        REFERENCES dzialy ( id_dzialu );
--widok
CREATE OR REPLACE VIEW dzial_prac AS
SELECT
    pracownicy.id, pracownicy.imie, pracownicy.nazwisko, id_dzialu ,dzialy.nazwa
FROM
         pracownicy
    INNER JOIN dzialy ON dzialy.id_dzialu = pracownicy.dzialy_id;
--wyzwalacz
CREATE OR REPLACE TRIGGER widok_dzialy
INSTEAD OF UPDATE ON dzial_prac
FOR EACH ROW 
BEGIN 

IF :new.id<>:old.id
THEN RAISE_APPLICATION_ERROR(-20000, 'Nie mozna zmieniaæ ID pracownika');

END IF;
IF :new.nazwisko<>:old.nazwisko
THEN
UPDATE pracownicy SET nazwisko=:new.nazwisko WHERE nazwisko=:old.nazwisko;
END IF;
IF :new.imie<>:old.imie
THEN
UPDATE pracownicy SET imie=:new.imie WHERE imie=:old.imie;
END IF;
IF :new.id_dzialu<>:old.id_dzialu
THEN
UPDATE pracownicy SET dzialy_id=:new.id_dzialu WHERE dzialy_id=:old.id_dzialu AND id=:old.id;
END IF;
END;

UPDATE dzial_prac SET nazwisko='Gawron' WHERE id=1;
UPDATE dzial_prac SET id_dzialu=1 WHERE id=2;
UPDATE dzial_prac SET id=3 WHERE id=2;
