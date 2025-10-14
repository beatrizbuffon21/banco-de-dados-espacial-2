-- CONSULTAS ESPACIAIS

-- 1) Fazer a conexão com o banco de dados “poli” e adicionar as suas tabelas em um projeto no QGIS;

-- 2) Qual a distância entre o estacionamento 1 e 3?
SELECT st_distance(st_Transform(e1.geom, 31982),
st_Transform(e2.geom, 31982)) AS distancia
FROM estacionamento as e1, estacionamento as e2
WHERE e1.cod_estac = 1 and e2.cod_estac = 3

-- 3) Qual a área de cada estacionamento cadastrado?
select cod_estac, st_area(st_Transform(geom, 31982)) from estacionamento

-- 4) Qual o somatório das áreas de todos os estacionamentos?
select sum(st_area(st_Transform(geom, 31982))) from estacionamento

-- 5) Qual o comprimento de cada acesso dos estacionamentos?
SELECT cod_acesso, st_length(st_transform(geom, 31982))
FROM acesso

-- 6) Qual a distância entre a coordenada do ponto que localiza o Politécnico e os prédios que compõem o colégio?
SELECT p.cod_pred, st_distance(st_Transform(c.geom, 31982),
st_Transform(p.geom, 31982)) AS distancia
FROM colegio as c, predio as p
WHERE c.cod_col = '081.CPSM'
