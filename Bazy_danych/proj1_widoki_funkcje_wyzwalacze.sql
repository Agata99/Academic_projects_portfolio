-- Generated by Oracle SQL Developer Data Modeler 19.4.0.350.1424
--   at:        2020-05-02 15:12:08 CEST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g

BEGIN
FOR cur_rec IN (SELECT object_name, object_type
FROM user_objects
WHERE object_type IN
('TABLE',
'VIEW',
'MATERIALIZED VIEW',
'PACKAGE',
'PROCEDURE',
'FUNCTION',
'SEQUENCE',
'SYNONYM',
'PACKAGE BODY'
))
LOOP
BEGIN
IF cur_rec.object_type = 'TABLE'
THEN
EXECUTE IMMEDIATE 'DROP '
|| cur_rec.object_type
|| ' "'
|| cur_rec.object_name
|| '" CASCADE CONSTRAINTS';
ELSE
EXECUTE IMMEDIATE 'DROP '
|| cur_rec.object_type
|| ' "'
|| cur_rec.object_name
|| '"';
END IF;
EXCEPTION
WHEN OTHERS
THEN
DBMS_OUTPUT.put_line ('FAILED: DROP '
|| cur_rec.object_type
|| ' "'
|| cur_rec.object_name
|| '"'
);
END;
END LOOP;
FOR cur_rec IN (SELECT *
FROM all_synonyms
WHERE table_owner IN (SELECT USER FROM dual))
LOOP
BEGIN
EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM ' || cur_rec.synonym_name;
END;
END LOOP;
END;
/

CREATE TABLE "176502_dzia?" (
    id     INTEGER NOT NULL,
    nazwa  VARCHAR2(20) NOT NULL,
    opis   VARCHAR2(200)
);

COMMENT ON TABLE "176502_dzia?" IS
    'Tabela zawiera informacje dotycz?ce dzia??w, do kt?rych przypisani s? pracownicy.';

ALTER TABLE "176502_dzia?" ADD CONSTRAINT "176502_dzia?_PK" PRIMARY KEY ( id );

CREATE TABLE "176502_eksponaty" (
    id                     INTEGER NOT NULL,
    nazwa                  VARCHAR2(100) NOT NULL,
    opis                   VARCHAR2(500),
    data_przyjecia         DATE DEFAULT sysdate NOT NULL,
    "176502_kategoria_id"  INTEGER NOT NULL
);

COMMENT ON TABLE "176502_eksponaty" IS
    'Tabela zawiera spis eksponat?w w muzeum.';

ALTER TABLE "176502_eksponaty" ADD CONSTRAINT "176502_eksponaty_PK" PRIMARY KEY ( id );

CREATE TABLE "176502_kategoria" (
    id     INTEGER NOT NULL,
    nazwa  VARCHAR2(25) NOT NULL,
    opis   VARCHAR2(300)
);

COMMENT ON TABLE "176502_kategoria" IS
    'Tabela zawiera spis kategorii eksponatu np. botanika, zoologia itp.';

ALTER TABLE "176502_kategoria" ADD CONSTRAINT "176502_kategoria_PK" PRIMARY KEY ( id );

CREATE TABLE "176502_lokalizacja" (
    "176502_pomieszczenie_id"  INTEGER NOT NULL,
    "176502_eksponaty_id"      INTEGER NOT NULL
);

COMMENT ON TABLE "176502_lokalizacja" IS
    'Tabela zawiera informacje dotycz?ce lokalizacji eksponat?w.';

ALTER TABLE "176502_lokalizacja" ADD CONSTRAINT "176502_lokalizacja_PKv1" PRIMARY KEY ( "176502_pomieszczenie_id",
                                                                                        "176502_eksponaty_id" );

CREATE TABLE "176502_oferta" (
    id               INTEGER NOT NULL,
    czas_zwiedzania  NUMBER(3, 2) NOT NULL,
    cena             NUMBER(4, 2) NOT NULL,
    max_uczestnik?w  NUMBER(3),
    dla_kogo         VARCHAR2(40) NOT NULL
);

COMMENT ON TABLE "176502_oferta" IS
    'Tabela zawiera dost?pne oferty zwiedzania.';

ALTER TABLE "176502_oferta" ADD CONSTRAINT "176502_oferta_CK_1" CHECK ( cena > 0 );

ALTER TABLE "176502_oferta" ADD CONSTRAINT "176502_oferta_PK" PRIMARY KEY ( id );

CREATE TABLE "176502_opiekun_eksponatu" (
    "176502_pracownik_id"  INTEGER NOT NULL,
    "176502_eksponaty_id"  INTEGER NOT NULL
);

COMMENT ON TABLE "176502_opiekun_eksponatu" IS
    'Zawiera informacje dotycz?ce kustoszy zajmuj?cych si? eksponatami.';

ALTER TABLE "176502_opiekun_eksponatu" ADD CONSTRAINT "176502_opiekun_eksponatu_PK" PRIMARY KEY ( "176502_pracownik_id",
                                                                                                  "176502_eksponaty_id" );

CREATE TABLE "176502_pomieszczenie" (
    id       INTEGER NOT NULL,
    nr_sali  VARCHAR2(15) NOT NULL,
    pi?tro   INTEGER NOT NULL,
    opis     VARCHAR2(200)
);

COMMENT ON TABLE "176502_pomieszczenie" IS
    'Tabela zawiera dane dot. pomieszcze? w budynku.';

ALTER TABLE "176502_pomieszczenie" ADD CONSTRAINT "176502_lokalizacja_PK" PRIMARY KEY ( id );

CREATE TABLE "176502_pracownik" (
    id                         INTEGER NOT NULL,
    imie                       VARCHAR2(30) NOT NULL,
    nazwisko                   VARCHAR2(30) NOT NULL,
    pesel                      NUMBER(11) NOT NULL,
    nr_telefonu                VARCHAR2(11) NOT NULL,
    data_zatrudnienia          DATE,
    ulica                      VARCHAR2(35),
    numer                      VARCHAR2(6),
    kod                        VARCHAR2(6),
    miasto                     VARCHAR2(25),
    "176502_dzia?_id"          INTEGER NOT NULL,
    "176502_pomieszczenie_id"  INTEGER
);

COMMENT ON TABLE "176502_pracownik" IS
    'Tabela zawiera inf. o pracownikach.';

ALTER TABLE "176502_pracownik" ADD CONSTRAINT "176502_pracownik_PK" PRIMARY KEY ( id );

ALTER TABLE "176502_pracownik" ADD CONSTRAINT "176502_pracownik__UN" UNIQUE ( pesel );

CREATE TABLE "176502_przewodnik" (
    id                     INTEGER NOT NULL,
    "176502_pracownik_id"  INTEGER NOT NULL,
    "176502_oferta_id"     INTEGER NOT NULL
);

COMMENT ON TABLE "176502_przewodnik" IS
    'Zawiera spis pracownik?w kt?rzy s? przewodnikami i oferty kt?re obs?uguj?';

ALTER TABLE "176502_przewodnik" ADD CONSTRAINT "176502_przewodnik_PK" PRIMARY KEY ( id );

CREATE TABLE "176502_turysta" (
    id                        INTEGER NOT NULL,
    imie_przedstawiciela      VARCHAR2(30) NOT NULL,
    nazwisko_przedstawiciela  VARCHAR2(30) NOT NULL,
    kategoria_wiek            VARCHAR2(20) NOT NULL,
    liczba_os?b               INTEGER NOT NULL,
    nr_telefonu               VARCHAR2(11) NOT NULL,
    "176502_przewodnik_id"    INTEGER NOT NULL
);

COMMENT ON TABLE "176502_turysta" IS
    'Tabela zawiera dane odwiedzaj?cych (tzn dane personalne przedstawiciela i liczebno?? grupy)';

ALTER TABLE "176502_turysta" ADD CONSTRAINT "176502_turysta_CK_1" CHECK ( liczba_os?b > 0 );

ALTER TABLE "176502_turysta" ADD CONSTRAINT "176502_turysta_PK" PRIMARY KEY ( id );

ALTER TABLE "176502_eksponaty"
    ADD CONSTRAINT "176502_eksp_kat_FK" FOREIGN KEY ( "176502_kategoria_id" )
        REFERENCES "176502_kategoria" ( id );

ALTER TABLE "176502_lokalizacja"
    ADD CONSTRAINT "176502_lok_176502_eksp_FK" FOREIGN KEY ( "176502_eksponaty_id" )
        REFERENCES "176502_eksponaty" ( id );

ALTER TABLE "176502_lokalizacja"
    ADD CONSTRAINT "176502_lok_pom_FK" FOREIGN KEY ( "176502_pomieszczenie_id" )
        REFERENCES "176502_pomieszczenie" ( id );

ALTER TABLE "176502_opiekun_eksponatu"
    ADD CONSTRAINT "176502_op_eksp_eksp_FK" FOREIGN KEY ( "176502_eksponaty_id" )
        REFERENCES "176502_eksponaty" ( id );

ALTER TABLE "176502_opiekun_eksponatu"
    ADD CONSTRAINT "176502_opiekun_eksp_prac_FK" FOREIGN KEY ( "176502_pracownik_id" )
        REFERENCES "176502_pracownik" ( id );

ALTER TABLE "176502_pracownik"
    ADD CONSTRAINT "176502_prac_dzia?_FK" FOREIGN KEY ( "176502_dzia?_id" )
        REFERENCES "176502_dzia?" ( id );

ALTER TABLE "176502_pracownik"
    ADD CONSTRAINT "176502_prac_pom_FK" FOREIGN KEY ( "176502_pomieszczenie_id" )
        REFERENCES "176502_pomieszczenie" ( id );

ALTER TABLE "176502_przewodnik"
    ADD CONSTRAINT "176502_przew_oferta_FK" FOREIGN KEY ( "176502_oferta_id" )
        REFERENCES "176502_oferta" ( id );

ALTER TABLE "176502_przewodnik"
    ADD CONSTRAINT "176502_przew_prac_FK" FOREIGN KEY ( "176502_pracownik_id" )
        REFERENCES "176502_pracownik" ( id );

ALTER TABLE "176502_turysta"
    ADD CONSTRAINT "176502_tur_przew_FK" FOREIGN KEY ( "176502_przewodnik_id" )
        REFERENCES "176502_przewodnik" ( id );

CREATE SEQUENCE "176502_dzia?_id_SEQ" START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER "176502_dzia?_id_TRG" BEFORE
    INSERT ON "176502_dzia?"
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := "176502_dzia?_id_SEQ".nextval;
END;
/

CREATE SEQUENCE "176502_eksponaty_id_SEQ" START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER "176502_eksponaty_id_TRG" BEFORE
    INSERT ON "176502_eksponaty"
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := "176502_eksponaty_id_SEQ".nextval;
END;
/

CREATE SEQUENCE "176502_kategoria_id_SEQ" START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER "176502_kategoria_id_TRG" BEFORE
    INSERT ON "176502_kategoria"
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := "176502_kategoria_id_SEQ".nextval;
END;
/

CREATE SEQUENCE "176502_oferta_id_SEQ" START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER "176502_oferta_id_TRG" BEFORE
    INSERT ON "176502_oferta"
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := "176502_oferta_id_SEQ".nextval;
END;
/

CREATE SEQUENCE "176502_pomieszczenie_id_SEQ" START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER "176502_pomieszczenie_id_TRG" BEFORE
    INSERT ON "176502_pomieszczenie"
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := "176502_pomieszczenie_id_SEQ".nextval;
END;
/

CREATE SEQUENCE "176502_pracownik_id_SEQ" START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER "176502_pracownik_id_TRG" BEFORE
    INSERT ON "176502_pracownik"
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := "176502_pracownik_id_SEQ".nextval;
END;
/

CREATE SEQUENCE "176502_przewodnik_id_SEQ" START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER "176502_przewodnik_id_TRG" BEFORE
    INSERT ON "176502_przewodnik"
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := "176502_przewodnik_id_SEQ".nextval;
END;
/

CREATE SEQUENCE "176502_turysta_id_SEQ" START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER "176502_turysta_id_TRG" BEFORE
    INSERT ON "176502_turysta"
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := "176502_turysta_id_SEQ".nextval;
END;
/

insert into "176502_dzia?"(id,nazwa ,opis) values(1,'ksiegowosc','brak');
insert into "176502_dzia?"(id,nazwa ,opis) values(2,'ochrona','zabezpiecza eksponaty');
insert into "176502_dzia?"(id,nazwa ,opis) values(3,'obs?uga klienta','sprzedaje bilety i robi rezerwacje');
insert into "176502_dzia?"(id,nazwa ,opis) values(4,'przewodnik','brak');
insert into "176502_dzia?"(id,nazwa ,opis) values(5,'kustosz','dba o eksponaty');
insert into "176502_dzia?"(id,nazwa ,opis) values(6,'konserwacja','dba o eksponaty');
insert into "176502_dzia?"(id,nazwa ,opis) values(7,'informatycy','obsuga stron internetowych i systemow');
insert into "176502_dzia?"(id,nazwa ,opis) values(8,'dz. czysto?ci','ekipa sprz?taj?ca budynek');


insert into "176502_pomieszczenie"(id,nr_sali,pi?tro,opis) values(1,'1a',0,'warsztat');
insert into "176502_pomieszczenie"(id,nr_sali,pi?tro,opis) values(2,'2a',1,'biuro');
insert into "176502_pomieszczenie"(id,nr_sali,pi?tro,opis) values(3,'3a',1,'serwerownia');
insert into "176502_pomieszczenie"(id,nr_sali,pi?tro,opis) values(4,'4b',1,'pomieszczenie dla dinozaurow');
insert into "176502_pomieszczenie"(id,nr_sali,pi?tro,opis) values(5,'5a',1,'pomieszczenie na ska?y');
insert into "176502_pomieszczenie"(id,nr_sali,pi?tro,opis) values(6,'6a',1,'pomieszczenie morskie');
insert into "176502_pomieszczenie"(id,nr_sali,pi?tro,opis) values(7,'7a',1,'pomieszczenie ludzkie na przestrzeni wiekow');
insert into "176502_pomieszczenie"(id,nr_sali,pi?tro,opis) values(8,'8c',1,'pomieszczenie g?rskie');
insert into "176502_pomieszczenie"(id,nr_sali,pi?tro,opis) values(9,'9a',1,'pomieszczenie ptakow');
insert into "176502_pomieszczenie"(id,nr_sali,pi?tro,opis) values(10,'10a',1,'pomieszczenie roslin');
insert into "176502_pomieszczenie"(id,nr_sali,pi?tro,opis) values(11,'10b',2,'pomieszczenie starozytnosci');
insert into "176502_pomieszczenie"(id,nr_sali,pi?tro,opis) values(12,'12a',2,'pomieszczenie katastrof naturalnych');
insert into "176502_pomieszczenie"(id,nr_sali,pi?tro,opis) values(13,'13a',2,'pomieszczenie ssakow');
insert into "176502_pomieszczenie"(id,nr_sali,pi?tro,opis) values(14,'14a',2,'magazyn');


insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id","176502_pomieszczenie_id") values(1,'Krzysztof','Lubaszka','89020308121','506-789-123',to_date('12/02/2016' , 'dd/mm/yyyy' ),'Mokra','22','12-345','Gdynia',1,2);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id","176502_pomieszczenie_id") values(2,'Robert','Piwo?ski ','81052308121','509-719-200',to_date('10/05/2016' , 'dd/mm/yy'),'Sucha','15a','13-350','Gda?sk',1,2);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(3,'Anna','Galaszewska ','72106593402','506-789-134',to_date('12/02/2017' , 'dd/mm/yy'),'Sloneczna','8','12-346','Sopot',4);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(4,'Irena','Rogowska','69081235098','509-709-201',to_date('12/12/2019' , 'dd/mm/yy'),'Zimowa','1a','12-355','Gdynia',4);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(5,'Jan','Graczy?ski ','90123154120','506-789-124',to_date('12/04/2015' , 'dd/mm/yy'),'Gda?ska','36','15-347','Rumia',4);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(6,'Urszula','Murawska ','77347105464','509-719-201',to_date('22/12/2016' , 'dd/mm/yy'),'Warszawska','54','73-352','Kolbudy',4);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(7,'Felicja','Andrychowicz','76370567362','506-789-135',to_date('12/10/2016' , 'dd/mm/yy'),'Bohaterska','72b','92-348','Starogard Gda?ski',4);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(8,'Janusz','Wachowicz','75394029259','509-709-202',to_date('12/02/2017' , 'dd/mm/yy'),'Zielona','90','88-353','Sopot',4);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(9,'Amanda','Koszewska','74417491157','506-789-125',to_date('12/01/2020' , 'dd/mm/yy'),'Czarna','108','12-349','Gda?sk',4);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id","176502_pomieszczenie_id") values(10,'Robert','Czerwi?ski','73440953054','509-719-202',to_date('06/02/2018' , 'dd/mm/yy'),'Czerwona','126','13-350','Gda?sk',7,3);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id","176502_pomieszczenie_id") values(11,'Maciej','Linus','82031568120','506-789-136',to_date('12/08/2016' , 'dd/mm/yy'),'Zakole','1c','12-350','Gda?sk',5,1);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id","176502_pomieszczenie_id") values(12,'Donald','B?a?ejczyk','71487876849','509-709-203',to_date('12/04/2017' , 'dd/mm/yy'),'Lesna','12','43-355','Luzino',5,1);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id","176502_pomieszczenie_id") values(13,'Jolanta','Filipowicz','70511338747','506-789-126',to_date('07/04/2016' , 'dd/mm/yy'),'Rozana','23','12-350','Gda?sk',5,1);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id","176502_pomieszczenie_id") values(14,'Jan','Melnik','69534800644','509-719-203',to_date('12/01/2019' , 'dd/mm/yy'),'Morska','34','13-356','Banino',5,1);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(15,'Edward','Soplica','68558262542','606-789-137',to_date('21/02/2016' , 'dd/mm/yy'),'Kapitanska','45','12-352','Gdynia',5);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(16,'Czes?aw','Jasiewicz','82581724440','609-709-204',to_date('31/07/2019' , 'dd/mm/yy'),'Zwirowa','56d','12-352','Gdynia',5);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(17,'Wies?awa','Kozikowska','86605186338','606-789-138',to_date('12/11/2017' , 'dd/mm/yy'),'Fioletowa','67','13-357','Mosty',5);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(18,'Marek','Za?uski','90628648236','609-709-205',to_date('08/12/2015' , 'dd/mm/yy'),'Morelowa','121a','12-353','Gda?sk',5);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(19,'Piotr','S?omczy?ski','94652110134','606-789-139',to_date('01/02/2020' , 'dd/mm/yy'),'Akacjowa','125','12-352','Sopot',2);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(20,'Zygmunt','Semeniuk ','98675572032','609-709-206',to_date('12/03/2016' , 'dd/mm/yy'),'Mokra','129','13-358','Reda',3);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(21,'Helena','Urba?czyk','82699033930','606-789-140',to_date('12/02/2018' , 'dd/mm/yy'),'Sucha','133','12-354','Wejherowo',3);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(22,'Pawe?','Grabowski','76722495828','609-709-207',to_date('18/02/2015' , 'dd/mm/yy'),'Sloneczna','137','12-353','Sopot',6);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(23,'Wojciech','Wojtyra','70745957726','606-789-141',to_date('15/02/2018' , 'dd/mm/yy'),'Zimowa','141','13-359','Cedry Wielkie',8);
insert into "176502_pracownik"(id,imie,nazwisko,pesel,nr_telefonu,data_zatrudnienia,ulica,numer,kod,miasto,"176502_dzia?_id") values(24,'Pawe?','Kot','64769419624','609-709-208',to_date('12/02/2016' , 'dd/mm/yy'),'Gda?ska','145','12-355','Gda?sk',8);



insert into "176502_oferta"(id,czas_zwiedzania,cena,max_uczestnik?w,dla_kogo) values(1,1,45,1,'doro?li');
insert into "176502_oferta"(id,czas_zwiedzania,cena,max_uczestnik?w,dla_kogo) values(2,1,15,30,'szko?y');
insert into "176502_oferta"(id,czas_zwiedzania,cena,max_uczestnik?w,dla_kogo) values(3,1.5,20,30,'szko?y');
insert into "176502_oferta"(id,czas_zwiedzania,cena,max_uczestnik?w,dla_kogo) values(4,2,40,30,'grupy doro?li');
insert into "176502_oferta"(id,czas_zwiedzania,cena,max_uczestnik?w,dla_kogo) values(5,0.5,12,15,'dla maluszk?w');
insert into "176502_oferta"(id,czas_zwiedzania,cena,max_uczestnik?w,dla_kogo) values(6,2,15,5,'rodziny');
insert into "176502_oferta"(id,czas_zwiedzania,cena,max_uczestnik?w,dla_kogo) values(7,1.5,50,1,'doro?li');
insert into "176502_oferta"(id,czas_zwiedzania,cena,max_uczestnik?w,dla_kogo) values(8,1,10,5,'rodziny');


insert into "176502_przewodnik"(id,"176502_pracownik_id","176502_oferta_id") values(101,3,1);
insert into "176502_przewodnik"(id,"176502_pracownik_id","176502_oferta_id") values(102,3,2);
insert into "176502_przewodnik"(id,"176502_pracownik_id","176502_oferta_id") values(103,5,1);
insert into "176502_przewodnik"(id,"176502_pracownik_id","176502_oferta_id") values(104,6,5);
insert into "176502_przewodnik"(id,"176502_pracownik_id","176502_oferta_id") values(105,6,6);
insert into "176502_przewodnik"(id,"176502_pracownik_id","176502_oferta_id") values(106,7,5);
insert into "176502_przewodnik"(id,"176502_pracownik_id","176502_oferta_id") values(107,7,3);
insert into "176502_przewodnik"(id,"176502_pracownik_id","176502_oferta_id") values(108,8,4);
insert into "176502_przewodnik"(id,"176502_pracownik_id","176502_oferta_id") values(109,9,7);
insert into "176502_przewodnik"(id,"176502_pracownik_id","176502_oferta_id") values(110,9,8);

insert into "176502_turysta"(id,imie_przedstawiciela,nazwisko_przedstawiciela,kategoria_wiek,liczba_os?b,nr_telefonu,"176502_przewodnik_id") values(1,'Dagmara','Mazowiecka','doro?li',1,'605-123-009',101);
insert into "176502_turysta"(id,imie_przedstawiciela,nazwisko_przedstawiciela,kategoria_wiek,liczba_os?b,nr_telefonu,"176502_przewodnik_id") values(2,'Anna','Ochocka','dzieci',14,'606-124-010',104);
insert into "176502_turysta"(id,imie_przedstawiciela,nazwisko_przedstawiciela,kategoria_wiek,liczba_os?b,nr_telefonu,"176502_przewodnik_id") values(3,'Krzysztof','Niew?g?owski','rodzina',4,'605-123-010',110);
insert into "176502_turysta"(id,imie_przedstawiciela,nazwisko_przedstawiciela,kategoria_wiek,liczba_os?b,nr_telefonu,"176502_przewodnik_id") values(4,'Konrad','J?druszczak','rodzina',3,'606-124-011',105);
insert into "176502_turysta"(id,imie_przedstawiciela,nazwisko_przedstawiciela,kategoria_wiek,liczba_os?b,nr_telefonu,"176502_przewodnik_id") values(5,'Izolda','Figura','mlodzie?',25,'605-123-011',102);
insert into "176502_turysta"(id,imie_przedstawiciela,nazwisko_przedstawiciela,kategoria_wiek,liczba_os?b,nr_telefonu,"176502_przewodnik_id") values(6,'Oktawian','Terlecki','seniorzy',15,'606-124-012',108);
insert into "176502_turysta"(id,imie_przedstawiciela,nazwisko_przedstawiciela,kategoria_wiek,liczba_os?b,nr_telefonu,"176502_przewodnik_id") values(7,'Augustyn','Zalewski','doro?li',1,'605-123-012',109);
insert into "176502_turysta"(id,imie_przedstawiciela,nazwisko_przedstawiciela,kategoria_wiek,liczba_os?b,nr_telefonu,"176502_przewodnik_id") values(8,'Andrzej','Sienkiewicz','mlodzie?',30,'606-124-013',107);


insert into "176502_kategoria"(id,nazwa,opis) values(1,'botanika','zbiory ro?linne i grzyby');
insert into "176502_kategoria"(id,nazwa,opis) values(2,'entomologia','zbiory owad?w');
insert into "176502_kategoria"(id,nazwa,opis) values(3,'zoologia','zbiory ssakow, ptakow, gadow');
insert into "176502_kategoria"(id,nazwa,opis) values(4,'mineralogia','ska?y i kamienie');
insert into "176502_kategoria"(id,nazwa,opis) values(5,'paleontologia','skamienia?o?ci i wykopaliska');
insert into "176502_kategoria"(id,nazwa,opis) values(6,'antropologia','zbiory zwi?zane z czlowiekiem');
insert into "176502_kategoria"(id,nazwa,opis) values(7,'geologia','zbiory zwi?zane z ziemi?');
insert into "176502_kategoria"(id,nazwa,opis) values(8,'inne','zbiory nie pasuj?ce do ?adnej kategorii');


insert into "176502_eksponaty"(id,nazwa,opis,data_przyjecia,"176502_kategoria_id") values(1,'szkielet dinozaura','prawdziwy szkielet Tyranozaura',to_date('01/01/2014' , 'dd/mm/yy'),3);
insert into "176502_eksponaty"(id,nazwa,opis,data_przyjecia,"176502_kategoria_id") values(2,'wapie?','1000letni ',to_date('01/01/2014' , 'dd/mm/yy'),4);
insert into "176502_eksponaty"(id,nazwa,opis,data_przyjecia,"176502_kategoria_id") values(3,'motyle','rozne gatunki',to_date('01/01/2014' , 'dd/mm/yy'),2);
insert into "176502_eksponaty"(id,nazwa,opis,data_przyjecia,"176502_kategoria_id") values(4,'szmaragdy','2 duze kamienie',to_date('01/01/2016' , 'dd/mm/yy'),4);
insert into "176502_eksponaty"(id,nazwa,data_przyjecia,"176502_kategoria_id") values(5,'grzyby',to_date('12/05/2017' , 'dd/mm/yy'),1);
insert into "176502_eksponaty"(id,nazwa,opis,data_przyjecia,"176502_kategoria_id") values(6,'skamieliny morskie','szkielety drobnych ryb',to_date('12/05/2017' , 'dd/mm/yy'),5);
insert into "176502_eksponaty"(id,nazwa,opis,data_przyjecia,"176502_kategoria_id") values(7,'ludzkie czaszki','pierwsze gatunki czlowieka',to_date('12/05/2017' , 'dd/mm/yy'),6);
insert into "176502_eksponaty"(id,nazwa,data_przyjecia,"176502_kategoria_id") values(8,'makieta gor',to_date('30/06/2017' , 'dd/mm/yy'),7);
insert into "176502_eksponaty"(id,nazwa,data_przyjecia,"176502_kategoria_id") values(9,'ptak dodo',to_date('1/07/2017' , 'dd/mm/yy'),3);
insert into "176502_eksponaty"(id,nazwa,opis,data_przyjecia,"176502_kategoria_id") values(10,'papro?','1000letnia papro?',to_date('21/04/2020' , 'dd/mm/yy'),1);
insert into "176502_eksponaty"(id,nazwa,data_przyjecia,"176502_kategoria_id") values(11,'skarabeusz',to_date('18/08/2019' , 'dd/mm/yy'),8);
insert into "176502_eksponaty"(id,nazwa,opis,data_przyjecia,"176502_kategoria_id") values(12,'makieta wulkanu','imituje wybuch',to_date('18/08/2019' , 'dd/mm/yy'),7);
insert into "176502_eksponaty"(id,nazwa,opis,data_przyjecia,"176502_kategoria_id") values(13,'szkielet mamuta','syntetyczny',to_date('18/08/2019' , 'dd/mm/yy'),3);


insert into "176502_opiekun_eksponatu"("176502_pracownik_id","176502_eksponaty_id") values(11,1);
insert into "176502_opiekun_eksponatu"("176502_pracownik_id","176502_eksponaty_id") values(12,1);
insert into "176502_opiekun_eksponatu"("176502_pracownik_id","176502_eksponaty_id") values(13,2);
insert into "176502_opiekun_eksponatu"("176502_pracownik_id","176502_eksponaty_id") values(14,3);
insert into "176502_opiekun_eksponatu"("176502_pracownik_id","176502_eksponaty_id") values(11,4);
insert into "176502_opiekun_eksponatu"("176502_pracownik_id","176502_eksponaty_id") values(16,5);
insert into "176502_opiekun_eksponatu"("176502_pracownik_id","176502_eksponaty_id") values(17,6);
insert into "176502_opiekun_eksponatu"("176502_pracownik_id","176502_eksponaty_id") values(18,6);
insert into "176502_opiekun_eksponatu"("176502_pracownik_id","176502_eksponaty_id") values(13,7);
insert into "176502_opiekun_eksponatu"("176502_pracownik_id","176502_eksponaty_id") values(16,8);
insert into "176502_opiekun_eksponatu"("176502_pracownik_id","176502_eksponaty_id") values(17,9);
insert into "176502_opiekun_eksponatu"("176502_pracownik_id","176502_eksponaty_id") values(15,10);
insert into "176502_opiekun_eksponatu"("176502_pracownik_id","176502_eksponaty_id") values(12,11);
insert into "176502_opiekun_eksponatu"("176502_pracownik_id","176502_eksponaty_id") values(18,12);


insert into "176502_lokalizacja"("176502_pomieszczenie_id","176502_eksponaty_id") values(1,3);
insert into "176502_lokalizacja"("176502_pomieszczenie_id","176502_eksponaty_id") values(11,4);
insert into "176502_lokalizacja"("176502_pomieszczenie_id","176502_eksponaty_id") values(1,5);
insert into "176502_lokalizacja"("176502_pomieszczenie_id","176502_eksponaty_id") values(4,1);
insert into "176502_lokalizacja"("176502_pomieszczenie_id","176502_eksponaty_id") values(5,2);
insert into "176502_lokalizacja"("176502_pomieszczenie_id","176502_eksponaty_id") values(6,6);
insert into "176502_lokalizacja"("176502_pomieszczenie_id","176502_eksponaty_id") values(7,7);
insert into "176502_lokalizacja"("176502_pomieszczenie_id","176502_eksponaty_id") values(8,8);
insert into "176502_lokalizacja"("176502_pomieszczenie_id","176502_eksponaty_id") values(9,9);
insert into "176502_lokalizacja"("176502_pomieszczenie_id","176502_eksponaty_id") values(10,10);
insert into "176502_lokalizacja"("176502_pomieszczenie_id","176502_eksponaty_id") values(11,11);
insert into "176502_lokalizacja"("176502_pomieszczenie_id","176502_eksponaty_id") values(12,12);
insert into "176502_lokalizacja"("176502_pomieszczenie_id","176502_eksponaty_id") values(13,13);


select
    (select count(*) from "176502_dzia?") as "176502_dzia?",
     (select count(*) from "176502_eksponaty") as "176502_eksponaty",
      (select count(*) from "176502_pracownik") as "176502_pracownik",
       (select count(*) from "176502_przewodnik") as "176502_przewodnik",
        (select count(*) from "176502_pomieszczenie") as "176502_pomieszczenie",
         (select count(*) from "176502_oferta") as "176502_oferta",
         (select count(*) from "176502_opiekun_eksponatu") as "176502_opiekun_eksponatu",
         (select count(*) from "176502_lokalizacja") as "176502_lokalizacja",
         (select count(*) from "176502_kategoria") as "176502_kategoria",
         (select count(*) from "176502_turysta") as "176502_turysta"
from dual;
    
--widoki jednotabelowe  
    
create view staz_przewodnikow as 
    select imie, nazwisko , floor((sysdate - data_zatrudnienia)/365.25) as "staz w latach", extract(year from data_zatrudnienia) as "rok zatrudnienia"
    from "176502_pracownik"
    where "176502_dzia?_id" =4;
    
    select * from staz_przewodnikow;
    
        
create view oferta_promocyjna as 
    select dla_kogo as adresat, (czas_zwiedzania + 0.5)|| ' h' as dluzsze_zwiedzanie, floor(cena*0.8)||' zl/os' as cena_promocyjna
    from "176502_oferta"
    where max_uczestnik?w > 1;
    
select * from oferta_promocyjna;


create view eksponaty_na_wystawie as 
    select nazwa , opis, floor(sysdate - data_przyjecia)-100||' dni' as "czas_na_wystawie" 
    from "176502_eksponaty"
    where (opis is not null and floor(sysdate - data_przyjecia)-100 > 0);

select * from eksponaty_na_wystawie;


create view klienci_w_liczbach as 
    select kategoria_wiek, count(*) as liczba_grup, floor(avg(liczba_os?b)) as liczba_os_w_gr, count(*)*floor(avg(liczba_os?b)) as liczba_odwiedzajacych
    from "176502_turysta"
    group by kategoria_wiek;

select * from klienci_w_liczbach;

--widoki wielotabelowe

create view gdanscy_kustosze as 
    select kat.nazwa as kategoria, e.nazwa as eksponat, extract(year from data_przyjecia) as rok_przyjecia_ekponatu, imie as imie_kustosza, nazwisko as nazwisko_kustosza
    from "176502_kategoria" kat join "176502_eksponaty" e on kat.id="176502_kategoria_id"
    join "176502_opiekun_eksponatu" o on e.id="176502_eksponaty_id" join "176502_pracownik" p on p.id="176502_pracownik_id"
    where nazwisko in (select nazwisko 
                        from "176502_pracownik" 
                        where (extract(year from data_zatrudnienia)< 2018 and miasto='Gda?sk'));

select * from gdanscy_kustosze;


create view popularnosc_ofert as 
    select czas_zwiedzania||'h' as "czas zwiedzania", floor(cena*1.25)|| ' zl' as cena, dla_kogo as adresat,
    nazwisko as nazwisko_przewodnika, liczba_os?b
    from "176502_oferta" o join ("176502_przewodnik" p join "176502_turysta" t on p.id="176502_przewodnik_id") on o.id="176502_oferta_id" 
    join "176502_pracownik" pr on pr.id="176502_pracownik_id"
    where czas_zwiedzania > ((select (avg(czas_zwiedzania)/2) 
                              from "176502_oferta"));

select * from popularnosc_ofert;

create view ilosc_pracownik?w as
    select count(p.nazwisko) as "ilo?? pracownik?w" , d.nazwa as "dzia?"
    from  "176502_dzia?" d join "176502_pracownik" p on d.id="176502_dzia?_id" 
    left join "176502_pomieszczenie" pom on pom.id="176502_pomieszczenie_id"
    group by nazwa
    having count(p.nazwisko) <= (select count(*) 
                            from "176502_pracownik" left join "176502_pomieszczenie" pom on pom.id="176502_pomieszczenie_id" 
                            where pi?tro = 0 or pi?tro=1);
                       
select * from ilosc_pracownik?w;

create view wystawa as
    select k.nazwa as kategoria , e.nazwa as nazwa_eksponatu, nr_sali as sala
    from "176502_kategoria" k join "176502_eksponaty" e on k.id="176502_kategoria_id" 
    join "176502_lokalizacja" on e.id="176502_eksponaty_id" 
    join "176502_pomieszczenie" pom on pom.id="176502_pomieszczenie_id"
    where pi?tro = (select max(pi?tro)-1 
                from "176502_pomieszczenie" 
                having max(pi?tro)-1 !=(select pi?tro 
                                        from "176502_pomieszczenie" 
                                        where opis='warsztat'));
select * from wystawa;




--funkcje procedury i wyzwalacze

--zad. 1
create or replace function sprawdz_pesel (pesel number) 
return varchar2 as
czy_pesel varchar2(35);
begin
    if 
    length(pesel)<11 then czy_pesel:='Za malo cyfr';
    elsif length(pesel)>11 then czy_pesel:='Za duzo cyfr';
    elsif mod((9*substr(pesel,1,1)+7*substr(pesel,2,1)+3*substr(pesel,3,1)+1*substr(pesel,4,1)+
        9*substr(pesel,5,1)+7*substr(pesel,6,1)+3*substr(pesel,7,1)+1*substr(pesel,8,1)+
        9*substr(pesel,9,1)+7*substr(pesel,10,1)),10)!=substr(pesel,11,1)
        then czy_pesel:='Blad w cyfrze kontrolnej';
        else  czy_pesel:='Prawidlowy pesel';
    end if;
return czy_pesel;
end sprawdz_pesel;

select sprawdz_pesel(49021201197) from dual;
select sprawdz_pesel(49021201190) from dual;
select sprawdz_pesel(490212017) from dual;
select sprawdz_pesel(4902120164537) from dual;

--zad2


create or replace function promocja (zima_lato varchar2,
                                    liczba_osob int:=1,
                                    czas_zwiedzania number,
                                    id_klienta int) 
return number as
promo number;
begin
   if zima_lato='zima' then
        select trunc(((1-0.1*mod(id_klienta,10))*cena/(liczba_osob*0.1+trunc(czas_zwiedzania)))*2,2) into promo from "176502_oferta" where id=1;
    elsif zima_lato='lato' then
        select cena*0.2*(substr(id_klienta,length(id_klienta),1)*liczba_osob/10)+2*czas_zwiedzania into promo from "176502_oferta" where id=1;
    end if;
return promo;
end;

select promocja('zima',1,1.5,2408) from dual;
select promocja('lato',30,1,2401) from dual;

select * from "176502_dzia?";


--zad3
CREATE OR REPLACE PROCEDURE obnizka
(liczba_uczestnikow IN NUMBER, p_procent IN NUMBER)
IS
BEGIN
if liczba_uczestnikow=30 and p_procent<50 then 
UPDATE "176502_oferta" SET cena = cena * (1 - 2*p_procent/100)
WHERE max_uczestnik?w=30;
elsif liczba_uczestnikow<30 and p_procent<50 then 
UPDATE "176502_oferta" SET cena = cena * (1 - p_procent/100)
WHERE max_uczestnik?w<30;
else raise_application_error(-20900,'zle argumenty');
end if;
END obnizka;


select * from "176502_oferta";


execute obnizka(30,5);
execute obnizka(5,30);
execute obnizka(36,79);


--zad4

--drop trigger ograniczenia;
create or replace trigger ograniczenia before insert on "176502_pracownik" for each row
declare
pesel number:=to_number(:new.pesel);
begin 
    if sprawdz_pesel(pesel)!='Prawidlowy pesel' then raise_application_error(-20500,'zly pesel');
    elsif :new."176502_pomieszczenie_id" is not null then insert into "176502_pomieszczenie" (id,nr_sali,pi?tro) values (:new."176502_pomieszczenie_id", '-',0);
   end if;
end;


select * from "176502_pomieszczenie";
insert into "176502_pracownik" values(25,'Pawe?','Kotek','49021201197','609-709-208',to_date('12/02/2016' , 'dd/mm/yy'),'Gda?ska','145','12-355','Gda?sk',7,21);
insert into "176502_pracownik" values(26,'Agata','Mazur','95092836103','609-709-108',to_date('12/02/2016' , 'dd/mm/yy'),'Mrozna','15','12-350','Gdynia',7,15);
select * from "176502_pracownik" where id in (25,26);

insert into "176502_pracownik" values(27,'Adam','Mazur','950928361','609-709-108',to_date('12/02/2016' , 'dd/mm/yy'),'Zimna','15','12-350','Gdynia',6,16);


--zad5

--drop table modyfikacje;
create table modyfikacje(
id integer primary key,
nazwa_eksponatu varchar2(35),
data_akcji date,
rodzaj_akcji varchar2(15)
);

CREATE SEQUENCE "modyfikacje_id_SEQ" START WITH 1 NOCACHE ORDER;

Create or replace trigger logi after delete or update on "176502_eksponaty" for each row

begin 
    if updating then insert into modyfikacje values ("modyfikacje_id_SEQ".nextval, :old.nazwa, sysdate ,'zmodyfikowano');
    elsif deleting then insert into modyfikacje values ("modyfikacje_id_SEQ".nextval, :old.nazwa, sysdate ,'usunieto');
    end if;
end logi;


select * from "176502_eksponaty";
delete from "176502_oferta" where id=8;
update "176502_eksponaty" set nazwa='owady latajace' where nazwa='motyle';

select * from modyfikacje;






-- -- Oracle SQL Developer Data Modeler Summary Report:
-- CREATE TABLE                            10
-- CREATE INDEX                             0
-- ALTER TABLE                             23
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           8
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          8
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
