-- ativando extensão postgis
create extension postgis

-- criando tabela ponto_turistico
CREATE TABLE ponto_turistico (cod_ponto integer PRIMARY kEY,
								nome character varying(50),
								numero integer,
								descricao character varying(100),
								geom GEOMETRY(POINT, 4326),
								cod_rua integer);

-- criando tabela rua
CREATE TABLE rua (cod_rua integer PRIMARY kEY,
					nome character varying(50),
					cod_bairro integer);

-- alterando tabela bairro
alter table bairro add column cod_cidade integer;

-- criação chave estrangeira
alter table bairro add constraint cod_cidade_fk
FOREIGN KEY(cod_cidade) REFERENCES cidade(cod_cidade);

alter table rua add constraint cod_bairro_fk
FOREIGN KEY(cod_bairro) REFERENCES bairro(cod_bairro);

-- atualizando bairro
UPDATE bairro
SET cod_cidade=1

-- inserir valores na rua
INSERT INTO rua (cod_rua, nome, cod_bairro)
VALUES (1, 'Avenida Nossa Sra. da Medianeira', 14)

INSERT INTO rua (cod_rua, nome, cod_bairro)
VALUES (2, 'Avenida Rio Branco', 18)

INSERT INTO rua (cod_rua, nome, cod_bairro)
VALUES (3, 'Rua Manuel Ribas', 18)				

-- inserir valores no ponto_turistico

INSERT INTO ponto_turistico (cod_ponto, nome, numero, descricao, geom, cod_rua)
VALUES (1, ' Santuário Basílica Nossa Senhora da Medianeira', 1, 'igreja', ('POINT(-53.81078468199696 -29.69973394773275)'), 1)

INSERT INTO ponto_turistico (cod_ponto, nome, numero, descricao, geom, cod_rua)
VALUES (2, ' Catedral Santa Maria', 2, 'igreja', ('POINT(-53.80805724581516 -29.68488265181293)'), 2)

INSERT INTO ponto_turistico (cod_ponto, nome, numero, descricao, geom, cod_rua)
VALUES (3, ' Vila Belga', 3, 'vila', ('POINT(-53.80868390233999 -29.67844748679839)'), 3)



			
