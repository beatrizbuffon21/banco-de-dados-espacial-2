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
