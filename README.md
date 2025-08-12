# Banco de Dados Espaciais 2 — UFSM

[![UFSM](https://img.shields.io/badge/UFSM-Universidade%20Federal%20de%20Santa%20Maria-blue)](https://www.ufsm.br)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14+-336791?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![PostGIS](https://img.shields.io/badge/PostGIS-3.3+-A6CE39?logo=postgis&logoColor=white)](https://postgis.net/)
[![QGIS](https://img.shields.io/badge/QGIS-3.30+-93b023?logo=qgis&logoColor=white)](https://qgis.org/)
[![SQL](https://img.shields.io/badge/SQL-Structured%20Query%20Language-lightgrey)](https://en.wikipedia.org/wiki/SQL)

Repositório com materiais, anotações e exercícios da disciplina **Banco de Dados Espaciais 2**, ministrada na **Universidade Federal de Santa Maria (UFSM)**.

---

## Ementa
*(Inserir ementa oficial ou um resumo dos principais tópicos da disciplina)*

- Conceitos avançados de bancos de dados espaciais  
- Consultas e índices espaciais  
- Modelagem e integração de dados geográficos  
- Funções espaciais avançadas e otimização  
- Aplicações práticas com PostGIS e QGIS

---

## Cronograma de Aulas

| Aula | Data       | Conteúdo | Observações/Links |
|------|------------|----------|-------------------|
| 01   | dd/mm/aaaa | Introdução e revisão | [Material](aulas/aula-01.md) |
| 02   | dd/mm/aaaa | *(preencher)* | [Material](aulas/aula-02.md) |
| 03   | dd/mm/aaaa | ... | ... |

---

## Anotações por Aula

### Aula 01 – Introdução e revisão
- Objetivos da disciplina  
- Revisão de conceitos básicos (geometrias, SRID, tipos espaciais)  
- Ferramentas: PostgreSQL + PostGIS, QGIS

### Aula 02 – *(adicionar título)*
- **Principais tópicos:**  
  - ...
  - ...
- **Exemplos de comandos SQL:**  
```sql
-- Consulta espacial de exemplo
SELECT id, nome
FROM lugares
WHERE ST_DWithin(
    geom,
    ST_SetSRID(ST_MakePoint(lon, lat), 4326)::geography,
    1000
);
```

### Ferramentas e Tecnologias
* **Banco de dados:** PostgreSQL + PostGIS
* **SIG:** QGIS
* **Linguagens:** SQL
* **Outros:** pgAdmin, ogr2ogr

---

### Estrutura do Repositório
banco_de_dados_espacial_2/
├── aulas/        # Notas e materiais por aula
├── scripts/      # Códigos SQL e scripts auxiliares
├── projetos/     # Trabalhos práticos e estudos de caso
├── dados/        # Shapefiles, GeoJSON (se permitido)
└── README.md     # Este arquivo

-----

### Como Utilizar

Clone o repositório:

git clone [https://github.com/SEU_USUARIO/banco_de_dados_espacial_2.git](https://github.com/SEU_USUARIO/banco_de_dados_espacial_2.git)


Crie uma branch por aula ou atividade:

git checkout -b aula-02-notas


Adicione suas notas no arquivo `aulas/aula-02.md` e envie um pull request (se for colaborativo).

-----

### Licença

Este repositório contém materiais de estudo pessoais.
Verifique os direitos autorais dos materiais utilizados antes de compartilhar publicamente.

```
```
