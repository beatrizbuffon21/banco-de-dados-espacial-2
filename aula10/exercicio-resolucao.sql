create extension postgis;

--  1) O nome do bairro e das farmácias existentes em cada bairro.
select bairros.name as bairro, farmacia.name as farmacia
from bairros, farmacia
where ST_contains(bairros.geom , farmacia.geom)

-- 2) Calcule a área dos bairros e ordene o resultado em ordem decrescente pela área.
select name, st_area(st_Transform(geom, 31982))
from bairros
ORDER BY st_area DESC

-- 3) Calcule a distância entre as farmácias. A consulta deverá mostrar o código, o nome de cada farmácia com a respectiva distância.

SELECT pt1.gid AS codigo_1, pt1.name AS farmacia_1, pt2.gid AS codigo_2, pt2.name AS farmacia_2,
ST_Distance(ST_Transform(pt1.geom, 31982), ST_Transform(pt2.geom, 31982)) AS distancia
FROM farmacia pt1, farmacia pt2
WHERE pt1.gid < pt2.gid;

-- 4) Calcule a área em hectares do município.

SELECT st_area(st_transform(m.geom, 31982))/10000 as area_municipio_km2, m.name
FROM municipio as m

-- 5) Calcule a distância do hospital da Unimed em relação às farmácias. 

SELECT f.name, h.name, st_distance(st_Transform(f.geom, 31982),
st_Transform(h.geom, 31982)) AS distancia
FROM farmacia as f, hospital as h
WHERE h.gid = 5;





