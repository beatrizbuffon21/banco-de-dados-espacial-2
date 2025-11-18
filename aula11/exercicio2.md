### onfiguração Inicial e Obtenção de Dados (QuickOSM)

1.  **Criação do Banco de Dados:**
      * Crie um novo **Banco de Dados Espacial (BDE)** (ex.: PostgreSQL/PostGIS) chamado: `pet_shop`.
2.  **Busca de Dados (QGIS - QuickOSM):**
      * Utilize o complemento **QuickOSM** no QGIS para baixar os seguintes dados para **Santa Maria, RS**:

| Tema | Chave OSM | Valor OSM | Geometria |
| :--- | :--- | :--- | :--- |
| **Limite Municipal** | `boundary` | `administrative` (com `admin_level` adequado para município) | Polígono |
| **Bairros** | `boundary` | `administrative` (com `admin_level` adequado para bairro/suburb) | Polígono |
| **Pet Shops** | `shop` | `pet` | Ponto/Polígono |

3.  **Geração e Edição de Shapefiles:**
      * Exporte as camadas baixadas para **Shapefiles** (ex.: `municipio.shp`, `bairros.shp`, `pet_shops.shp`).
      * **Importe** os *shapefiles* para o BD `pet_shop`.
      * **Edição das Tabelas:**
          * No Gerenciador de BD do QGIS, **renomeie** as tabelas (ex.: de `osm_polygons` para `bairros`) e **elimine colunas desnecessárias** (ex.: `osm_id`, `name:en`, etc.) para manter apenas `geom`, `nome` (ou `name`), e colunas essenciais.

-----

### Criação e Preenchimento da Tabela `hospital`

Crie uma nova tabela chamada `hospital` no banco de dados `pet_shop` com as seguintes colunas e insira os dados dos hospitais veterinários.

| Coluna | Tipo de Dado | Descrição |
| :--- | :--- | :--- |
| `codigo` | Integer | Identificador único |
| `nome` | Text | Nome do hospital |
| `endereco` | Text | Endereço completo |
| `numero` | Text | Número do endereço |
| `fone` | Text | Telefone |
| `cep` | Text | CEP |
| `geom` | Geometry (Point) | Coordenada geográfica |

1.  **Obtenção das Coordenadas:**
      * Busque no Google Earth/Maps as coordenadas do **Hospital Veterinário da UFSM** e do **Hospital Ninho**.
2.  **Inserção dos Dados (Exemplo em SQL - PostGIS):**
      * **Atenção:** Substitua `[COORDENADA_X]` e `[COORDENADA_Y]` pelos valores obtidos e `[SRID]` pelo código do sistema de referência (ex.: 31982 para SIRGAS 2000 / UTM zone 22S).

-----

### Consultas Espaciais no QGIS (Gerenciador de BD)

Utilize a aba **SQL Janela** no **Gerenciador de BD** do QGIS. Para cada consulta, marque **"Carregar como nova camada"** e salve o projeto.

#### 1\. Pet Shops dentro do Bairro Camobi

**Objetivo:** Filtrar `pet_shops` contidos na geometria do bairro `Camobi`.

  * **Função PostGIS:** `ST_WITHIN(geom_a, geom_b)`

<!-- end list -->

```sql
SELECT
    p.nome,
    p.geom
FROM
    pet_shops p,
    bairros b
WHERE
    b.nome ILIKE 'Camobi'
    AND ST_WITHIN(p.geom, b.geom);
```

#### 2\. Pet Shops dentro do Bairro Centro

**Objetivo:** Filtrar `pet_shops` contidos na geometria do bairro `Centro`.

```sql
SELECT
    p.nome,
    p.geom
FROM
    pet_shops p,
    bairros b
WHERE
    b.nome ILIKE 'Centro'
    AND ST_WITHIN(p.geom, b.geom);
```

#### 3\. Pet Shops até 3 km do Hospital Veterinário da UFSM

**Objetivo:** Encontrar `pet_shops` a uma distância máxima de 3.000 metros (3 km) do **Hospital Veterinário da UFSM**.

  * **Função PostGIS:** `ST_DWithin(geom_a, geom_b, distance)`
  * **Atenção:** Requer que o SRC (`[SRID]`) do projeto e das geometrias esteja em **metros** (ex.: UTM).

<!-- end list -->

```sql
SELECT
    p.nome,
    p.geom
FROM
    pet_shops p,
    hospital h
WHERE
    h.nome ILIKE 'Hospital Veterinário da UFSM'
    AND ST_DWithin(p.geom, h.geom, 3000);
```

#### 4\. Nome e Centróides dos Bairros de Santa Maria

**Objetivo:** Obter o nome de cada bairro e o seu ponto central (centróide).

  * **Função PostGIS:** `ST_Centroid(geom)`

<!-- end list -->

```sql
SELECT
    nome,
    ST_Centroid(geom) AS geom
FROM
    bairros;
```

-----
