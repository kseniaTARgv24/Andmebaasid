--SQL SALVESTATUD PROTSEDUURID-- mitu SQL käsku käivitakse järjest
--SQL SERVER

CREATE DATABASE procTARgv24;

USE procTARgv24;
CREATE TABLE uudised(
uudisID int PRIMARY KEY identity(1,1),
uudiseTeema varchar(50),
kuupaev date,
autor varchar(25),
kirjeldus text
)
SELECT * FROM uudised;
INSERT INTO uudised(uudiseTeema,kuupaev,autor,kirjeldus)
VALUES(
'udune ilm', '2025-02-06', 'postimees', 'Lõunani on udune ilm')
--protseduuri loomine
--sisestab uudised tabelisse ja kohe näitab
CREATE PROCEDURE lisaUudis
@uusTeema varchar(50),
@paev date,
@autor varchar(20),
@kirjeldus text
AS
BEGIN
INSERT INTO uudised(
uudiseTeema, kuupaev, autor, kirjeldus)
VALUES(
@uusTeema,@paev, @autor, @kirjeldus);
SELECT * FROM uudised;
END;
--kutse
EXEC lisaUudis 'windows 11', '2025-02-06', 'õpetaja pant', 'w11 ei tööta multimeedia klassis'
EXEC lisaUudis 
@uusTeema= '1.märts on juba kevad',
@paev='2025-02-06',
@autor='test',
@kirjeldus='puudub';

--protsedur, mis kustutab tabelist id järgi
CREATE PROCEDURE kustutaUudis
@id int
AS
BEGIN
SELECT * FROM uudised;
DELETE FROM uudised WHERE uudisId=@id;
SELECT * FROM uudised;
END;

--kutse
EXEC kustutaUudis 3;

UPDATE uudised SET kirjeldus='uus kirjeldus'
WHERE kirjeldus Like 'puudub'
SELECT * FROM uudised;

--protseduur mis uuendab andmed tabelis/UPDATE

CREATE Procedure uuendaKirjeldus
@uuskirjeldus text
AS
BEGIN
SELECT * FROM uudised;
UPDATE uudised SET kirjeldus=@uuskirjeldus
WHERE kirjeldus Like 'puudub'
SELECT * FROM uudised;
END;

--kutse
EXEC uuendaKirjeldus 'uus tekst kirjelduses';

--protseduur mis otsib ja näitab uudist esimese tähte järgi

CREATE PROCEDURE otsingUudiseTeema
@taht char(1)
AS
BEGIN
SELECT * FROM uudised
WHERE uudiseTeema LIKE @taht+'%';
END;

--kutse
EXEC otsingUudiseTeema 'w'

--screenid on readme failis
