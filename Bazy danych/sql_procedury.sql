
--I funkcja
create or replace function gender (imie varchar2) 
return varchar2 as
plec varchar2(1);
begin 
    if substr(imie,length(imie),1) ='a'
        then plec:='K';
        ELSIF imie is null THEN plec:=null;
        else plec:='M';
    end if;
return plec;
end gender;

--testowanie 
select 
    gender('Agata') as plec_agaty,
    gender('') as brak,
    gender('Karol') as plec_karola
from dual;

-- II funkcja
create or replace function waliduj_nip (nip number) 
return number as
czy_nip number;
begin
    if  mod((6*substr(nip,1,1)+5*substr(nip,2,1)+7*SUBSTR(nip,3,1)+2*SUBSTR(nip,4,1)+
        3*SUBSTR(nip,5,1)+4*SUBSTR(nip,6,1)+5*SUBSTR(nip,7,1)+6*SUBSTR(nip,8,1)+
        7*SUBSTR(nip,9,1)),11)=SUBSTR(nip,10,1)
        then czy_nip:=1;
        else czy_nip:=0;
    end if;
return czy_nip;
end waliduj_nip;


--testowanie 
select waliduj_nip(6485273008),
waliduj_nip(6485270002) 
from dual;

--III funkcja
--pomocnicze tabele
 CREATE TABLE "S176636_S"."PRODUKT" 
   (	"ID" INTEGER PRIMARY KEY, 
	"NAZWA" VARCHAR2(15 BYTE)
   );
Insert into S176636_S.PRODUKT (ID,NAZWA) values ('1','ksiazka');
Insert into S176636_S.PRODUKT (ID,NAZWA) values ('10','lozko');
Insert into S176636_S.PRODUKT (ID,NAZWA) values ('2','rêcznik');
Insert into S176636_S.PRODUKT (ID,NAZWA) values ('3','regal');

 CREATE TABLE "S176636_S"."ZAMOWIENIA" 
   (	"ID" INTEGER PRIMARY KEY, 
	"DATA_ZAMOWIENIA" DATE
   );
Insert into S176636_S.ZAMOWIENIA (ID,DATA_ZAMOWIENIA) values ('1',to_date('19/05/13','RR/MM/DD'));
Insert into S176636_S.ZAMOWIENIA (ID,DATA_ZAMOWIENIA) values ('2',to_date('19/05/04','RR/MM/DD'));
Insert into S176636_S.ZAMOWIENIA (ID,DATA_ZAMOWIENIA) values ('3',to_date('19/05/02','RR/MM/DD'));
Insert into S176636_S.ZAMOWIENIA (ID,DATA_ZAMOWIENIA) values ('4',to_date('20/02/14','RR/MM/DD'));

CREATE TABLE "S176636_S"."KOSZYK" 
   (	"ZAMOWIENIA_ID" INTEGER, 
	"PRODUKT_ID" INTEGER, 
	"CENA" NUMBER(8,2), 
	"ILOSC_SZTUK" NUMBER(38,0)
   );
 ALTER TABLE "S176636_S"."KOSZYK" ADD CONSTRAINT "KOSZYK_PK" PRIMARY KEY ("ZAMOWIENIA_ID", "PRODUKT_ID");
Insert into S176636_S.KOSZYK (ZAMOWIENIA_ID,PRODUKT_ID,CENA,ILOSC_SZTUK) values ('1','2','20','2');
Insert into S176636_S.KOSZYK (ZAMOWIENIA_ID,PRODUKT_ID,CENA,ILOSC_SZTUK) values ('2','3','10,5','3');
Insert into S176636_S.KOSZYK (ZAMOWIENIA_ID,PRODUKT_ID,CENA,ILOSC_SZTUK) values ('3','1','5','2');
Insert into S176636_S.KOSZYK (ZAMOWIENIA_ID,PRODUKT_ID,CENA,ILOSC_SZTUK) values ('4','2','20','1');

CREATE OR REPLACE FUNCTION zysk_roczny(
    rok INTEGER) 
RETURN NUMBER
IS
    zysk NUMBER;
BEGIN
    
    SELECT SUM(cena * ilosc_sztuk)
    INTO zysk
    FROM koszyk
    INNER JOIN produkt ON produkt.id = koszyk.produkt_id
    INNER JOIN zamowienia ON zamowienia.id = koszyk.zamowienia_id
    GROUP BY EXTRACT(YEAR FROM data_zamowienia)
    HAVING EXTRACT(YEAR FROM data_zamowienia) = rok;
RETURN zysk;
    END;
--testowanie
SELECT zysk_roczny(2019) FROM DUAL;

--IV funkcja
--pomocnicza tabelka
CREATE TABLE "S176636_S"."KURSY" 
   (	"ID" INTEGER PRIMARY KEY, 
	"NAZWA" VARCHAR2(15 BYTE), 
	"ILOSC_ZAPISANYCH" NUMBER(38,0), 
	"MAX_ILOSC_UCZESTNIKOW" NUMBER(38,0)
   );
Insert into S176636_S.KURSY (ID,NAZWA,ILOSC_ZAPISANYCH,MAX_ILOSC_UCZESTNIKOW) values ('1','Oracle','11','14');
Insert into S176636_S.KURSY (ID,NAZWA,ILOSC_ZAPISANYCH,MAX_ILOSC_UCZESTNIKOW) values ('2','SAS','12','12');

CREATE OR REPLACE FUNCTION czy_wolne_miejsca(
                            nazw VARCHAR) RETURN VARCHAR IS
                            ilosc INTEGER;
                            maks INTEGER;
                            
BEGIN
                           SELECT ilosc_zapisanych, max_ilosc_uczestnikow INTO ilosc, maks
                           FROM kursy
                           WHERE nazwa = nazw;
                           IF ilosc < maks
                                 THEN RETURN 'Sa wolne miejsca';
                          ELSE RETURN 'Brak wolnych miejsc';                          
                          END IF;
END;
--testowanie
SELECT czy_wolne_miejsca('Oracle') FROM DUAL;
SELECT czy_wolne_miejsca('SAS') FROM DUAL;

-- I procedura
--drop table pracownicy;
create table pracownicy (
 id                         INTEGER PRIMARY KEY,
imie_prac                       VARCHAR2(30) NOT NULL,
nazwisko_prac                   VARCHAR2(30) NOT NULL,
pesel_prac                      NUMBER(11) NOT NULL,
plec_prac                       VARCHAR2(1)
);


insert into pracownicy (id,imie_prac,nazwisko_prac,pesel_prac) values(1,'Agata','Nowak',98865976648);
insert into pracownicy (id,imie_prac,nazwisko_prac,pesel_prac) values (2,'Robert','Piwoñski ',81052308120);
insert into pracownicy (id,imie_prac,nazwisko_prac,pesel_prac) values (3,'Magda','As',81056308121);
insert into pracownicy (id,imie_prac,nazwisko_prac,pesel_prac) values (4,'Ala','Jak ',71052308121);
insert into pracownicy (id,imie_prac,nazwisko_prac,pesel_prac) values (5,'Tomasz','Mak',61052308121);
insert into pracownicy (id,imie_prac,nazwisko_prac,pesel_prac) values (6,'Daniel','Ptak',81052302321);
insert into pracownicy (id,imie_prac,nazwisko_prac,pesel_prac) values (7,'Robert','Kot ',81050008121);


create or replace procedure dodaj_plec(ilosc int) as
begin
    for vi in 1..ilosc loop
        update pracownicy set plec_prac=gender(imie_prac)
        where id=vi;
    end loop;
end;

--testowanie 
execute dodaj_plec(7);

select * from pracownicy;

--II procedura
--tabelka 
drop table pracownicy;
CREATE TABLE "S176636_S"."PRACOWNICY" 
   (	"ID" INTEGER PRIMARY KEY, 
	"ID_ZESP" INTEGER, 
	"PENSJA" NUMBER(8,2), 
	"DATA_ZATRUDNIENIA" DATE
   );
Insert into S176636_S.PRACOWNICY (ID,ID_ZESP,PENSJA,DATA_ZATRUDNIENIA) values ('1','2','1600',to_date('19/05/01','RR/MM/DD'));
Insert into S176636_S.PRACOWNICY (ID,ID_ZESP,PENSJA,DATA_ZATRUDNIENIA) values ('2','2','2640',to_date('15/05/15','RR/MM/DD'));
Insert into S176636_S.PRACOWNICY (ID,ID_ZESP,PENSJA,DATA_ZATRUDNIENIA) values ('3','1','2400',to_date('16/02/09','RR/MM/DD'));

CREATE OR REPLACE PROCEDURE Podwyzka
(przepracowane_lata IN NUMBER, p_procent IN NUMBER DEFAULT 15)
IS
BEGIN
UPDATE PRACOWNICY SET pensja = pensja * (1 + p_procent/100)
WHERE FLOOR(months_between(sysdate, data_zatrudnienia)/12)>=przepracowane_lata;
END Podwyzka;


--testowanie 
execute podwyzka(4,20);