Desenvolver um banco de dados espacial no **PostGIS**, importando shapefiles referentes ao município de **Santa Maria/RS**, utilizando o complemento **QuickOSM** do **QGIS**, e realizar consultas SQL para análise espacial.

### 1️⃣ Criação do Banco de Dados

1. Criar um banco de dados no PostgreSQL com suporte ao PostGIS:

   ```sql
   CREATE DATABASE santa_maria;
   \c santa_maria
   CREATE EXTENSION postgis;
   ```

---

### 2️⃣ Importação dos Dados via QuickOSM no QGIS

| Camada           | Tag (Chave=Valor)       | Tipo de Geometria | Descrição                               |
| ---------------- | ----------------------- | ----------------- | --------------------------------------- |
| Limite Municipal | `admin_level = 8`       | Polígono          | Delimitação do município de Santa Maria |
| Bairros          | `admin_level = 10`      | Polígono          | Divisão administrativa dos bairros      |
| Feiras           | `amenity = marketplace` | Ponto             | Localização das feiras livres           |

Após a importação, salve cada camada no banco de dados **PostGIS** usando o **Gerenciador de Camadas → Exportar → Banco de Dados → PostGIS**.

---

### 3️⃣ Limpeza das Tabelas

Remova colunas sem conteúdo ou irrelevantes, mantendo apenas os campos necessários, como:

* `gid`
* `name`
* `geom`

---

## 💾 Estrutura Final das Tabelas

* **limite_municipal** (polígono)
* **bairros** (polígono)
* **feira_pontos** (ponto)

---

## 🧮 Consultas SQL

### 1️⃣ Distância entre as feiras e a feira da **Avenida Roraima** (bairro Camobi)

```sql
SELECT f2.name, 
       ST_Distance(ST_Transform(f1.geom, 31982),
                   ST_Transform(f2.geom, 31982)) AS distancia
FROM feira_pontos AS f1, feira_pontos AS f2
WHERE f1.gid = 1;
```

> ⚙️ O código 31982 refere-se ao sistema de coordenadas **SIRGAS 2000 / UTM zone 22S**.

---

### 2️⃣ Nome e geometria das feiras por bairro

Usando a função [`ST_Contains`](https://postgis.net/docs/ST_Contains.html):

```sql
SELECT bairros.name AS nome_bairro, 
       feira_pontos.name AS nome_feira, 
       ST_AsText(feira_pontos.geom) AS geometria
FROM bairros, feira_pontos
WHERE ST_Contains(bairros.geom, feira_pontos.geom);
```

---

### 3️⃣ Quantas feiras existem por bairro?

```sql
SELECT bairros.name AS nome_bairro, 
       COUNT(feira_pontos.*) AS num_feiras
FROM bairros, feira_pontos
WHERE ST_Contains(bairros.geom, feira_pontos.geom)
GROUP BY bairros.name;
```

---

### 4️⃣ Quantas feiras existem no bairro **Centro**?

```sql
SELECT COUNT(feira_pontos.*) AS num_feiras
FROM bairros, feira_pontos
WHERE ST_Contains(bairros.geom, feira_pontos.geom)
  AND bairros.name = 'Centro';
```

---

### 5️⃣ Área dos bairros (em m²)

```sql
SELECT name, 
       ST_Area(ST_Transform(geom, 31982)) AS area_m2
FROM bairros;
```

---

### 6️⃣ Perímetro dos bairros (em metros)

```sql
SELECT name, 
       ST_Perimeter(ST_Transform(geom, 31982)) AS perimetro_m
FROM bairros;
```

---

### 7️⃣ Listagem das feiras (gid, name e geometria) ordenadas por nome

```sql
SELECT gid, 
       name, 
       ST_AsText(geom) AS geometria
FROM feira_pontos
ORDER BY name ASC;
```

---
