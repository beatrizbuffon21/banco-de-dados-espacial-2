# 📍 Banco de Dados Espaciais 2 — UFSM

Repositório com materiais, anotações e exercícios da disciplina **Banco de Dados Espaciais 2** ministrada na **Universidade Federal de Santa Maria (UFSM)**.

[![UFSM](https://img.shields.io/badge/UFSM-%23007acc?style=flat&logo=university)](#) [![PostGIS](https://img.shields.io/badge/PostGIS-%23A6CE39?style=flat)](#) [![QGIS](https://img.shields.io/badge/QGIS-%23000000?style=flat)](#)

---

## 📚 Ementa
*(Inserir ementa oficial ou resumo dos principais tópicos da disciplina)*

- Conceitos avançados de bancos de dados espaciais  
- Consultas e índices espaciais  
- Modelagem e integração de dados geográficos  
- Funções espaciais avançadas e otimização  
- Aplicações práticas com PostGIS e QGIS

---

## 🗓 Cronograma de aulas

| Aula | Data       | Conteúdo | Observações/Links |
|------|------------|----------|-------------------|
| 01   | dd/mm/aaaa | Introdução e revisão | [material](aulas/aula-01.md) |
| 02   | dd/mm/aaaa | *(preencher)* | [material](aulas/aula-02.md) |
| 03   | dd/mm/aaaa | ... | ... |

---

## 📝 Anotações por aula

### 📌 Aula 01 – Introdução e revisão
- Objetivos da disciplina  
- Revisão de conceitos básicos (geometrias, SRID, tipos espaciais)  
- Ferramentas: PostgreSQL + PostGIS, QGIS

### 📌 Aula 02 – *(adicione título aqui)*
- **Principais tópicos:**  
  - ...
  - ...
- **Comandos SQL / exemplos:**  
```sql
-- exemplo de consulta espacial
SELECT id, nome
FROM lugares
WHERE ST_DWithin(geom, ST_SetSRID(ST_MakePoint(lon, lat), 4326)::geography, 1000);
