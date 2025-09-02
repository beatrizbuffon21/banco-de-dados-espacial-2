# USO DE GATILHOS

Exemplo dos comandos para criar uma tabela com uma geometria de polígono e para inserir os dados:

**CRIAR TABELA:**

CREATE TABLE quadra (cod int PRIMARY KEY, geom geometry(polygon, 4326));

**INSERIR DADOS NA TABELA REFERENTE A QUADRA DO PLANETÁRIO:**

INSERT INTO quadra (cod, geom) VALUES(1, ST_GeometryFromText('POLYGON

((-53.71755281454674 -29.72078228807198, -53.7164004950836 -29.72063672084071, -53.71661952242427 -29.71950925324215,
-53.71774350898254 -29.71966376647713, -53.71755281454674 -29.72078228807198 ))',4326));
Desenvolva um banco de dados que será formado pelas tabelas `bairro`, `quadra`, `supermercado`, `auditoria`.

- Exercício 1:
Crie um gatilho para a tabela auditoria(operacao, usuario, data e hora, codigo da quadra) para que se tenha estes dados para cada código de quadra que seja manipulado na tabela quadra.
Para testar o gatilho gere polígonos para duas quadras da UFSM a partir do Google Earth e armazene os dados na tabela quadra(cod, geom).

- Exercício 2:
Crie um banco de dados para armazenar os polígonos da Área Experimental da UFSM, indicados na figura, os quais devem ser digitalizados no Google Earth para obtenção das coordenadas.
Crie uma trigger para calcular a área e o perímetro dos talhões a serem inseridos no banco de dados.

- Exercício 3:
Crie um banco de dados para armazenar o polígono do campus da UFSM, a ser obtido por meio do QuickOSM no QGIS e gerado um shapefile para ser importado no banco de dados.
Crie uma tabela predio com os campos número, nome e a geometria referente ao polígono do prédio. Crie uma trigger para calcular a área e o perímetro de 3 prédios que contenham restaurantes, lanchonetes ou café próximos ao Politécnico, que serão inseridos no banco de dados.
Gere pontos  para 3 restaurantes, lanchonetes ou café próximos ao Politécnico a partir do Google Earth e armazene na tabela restaurante(cod, nome, geom).
Posteriormente, crie um gatilho para a tabela auditoria(operacao, usuario, data e hora, codigo do restaurante) para que se tenha estes dados para cada código de restaurante que seja manipulado na tabela restaurante.
