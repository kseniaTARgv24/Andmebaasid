
USE lapsed;

CREATE TABLE laps(
lapsID int primary key identity(1,1),
nimi varchar(10) not null,
pikkus smallint,
synniaasta smallint,
synnilinn varchar(20)
);
SELECT * FROM laps;


INSERT INTO laps(nimi, pikkus, synniaasta,synnilinn)
VALUES
('Kati', 156, 2001, 'Tallinn'),
('Mati', 166, 2005, 'Tartu'),
('Sati', 176, 2001, 'Tallinn'),
('Tati', 126, 2000, 'Tallinn'),
('Nuti', 125, 2003, 'Tartu');


-- ORDER by
-- sortimine
SELECT nimi, pikkus 
FROM laps
ORDER by pikkus DESC, nimi; -- DESC - descending order


SELECT nimi, synniaasta
FROM laps
WHERE synniaasta >=2005
ORDER by nimi;

--DISTINCT
-- eemaldab dublikaateid
SELECT synniaasta
FROM laps
WHERE synniaasta > 2000;

--BETWEEN
--lapsed mis on syndinud (2000 kuni 2005)
SELECT nimi, synniaasta
FROM laps
WHERE synniaasta BETWEEN 2000 AND 2005;  -- WHERE synniaasta >= 2000 AND <=2005


--LIKE            -- vordlemine
-- n@ita pased, kelle nimi algab K-ga  
-- % koik voimalikud symbolid  'K%'
-- sisaldab K - '%K'
SELECT nimi
FROM laps
WHERE nimi LIKE '%K%';

-- t@psem m@@ratud t@ahtade arv _
SELECT nimi
FROM laps
WHERE nimi LIKE '_a__';

-- AND OR  - tingimuse kombineerimine
SELECT nimi, synnilinn
FROM laps
WHERE nimi LIKE '%K%' OR synnilinn LIKE 'Tartu';

SELECT nimi, synnilinn
FROM laps
WHERE nimi LIKE '%M%' AND synnilinn LIKE 'Tartu';

--Agregaatfunkstioonid
--SUM, AVG, MIN, MAX, COUNT
SELECT COUNT(nimi) AS 'laste ARV '      --adds temporary column 'COUNT' to show result
FROM laps;

SELECT AVG(pikkus) AS 'keskmine pikkus'
FROM laps
WHERE synnilinn = 'Tallinn';

--n@ita keskmine pikkus linnade j@rgi
-- GROUP by
SELECT AVG(pikkus) AS 'keskmine pikkus', synnilinn
FROM laps
GROUP by synnilinn;

--n@ita lapside kogus kes on syndinud ... synniaastal
SELECT synniaasta, COUNT(*) AS 'kui palju lapsi'
FROM laps
GROUP by synniaasta;


-- HAVING  --piirang juba grupeeritud andmete osas
-- keskmine pikkus iga synniaasta j@rgi
SELECT synniaasta, AVG(pikkus) AS keskmine
FROM laps
GROUP by synniaasta
HAVING AVG(pikkus) > 150;

SELECT synniaasta, AVG(pikkus) AS keskmine
FROM laps
WHERE NOT synniaasta = 2001                        -- NOT
GROUP by synniaasta;

-- seotud tabel
CREATE TABLE loom(
loomID int PRIMARY KEY identity(1,1),
loomNimi varchar(50),
lapsID int,
FOREIGN KEY (lapsID) REFERENCES laps(lapsID)
);

INSERT INTO loom(loomNimi, lapsID)
VALUES('kass Kott', 1),
('koer Shobaka', 1),
('koer Tuzik', 2),
('kass Tuzik', 3),
('kass Mura', 3),
('kilpkonn', 2);

SELECT * FROM loom  --!!!!SELECT * FROM loom, laps;  - VALE andmeid
INNER JOIN laps                  -- INNER JOIN
ON loom.lapsID=laps.lapsID;

--lihtne
SELECT l.loomNimi, la.nimi, la.synniaasta 
FROM loom l , laps la
WHERE l.lapsID=la.lapsID;
