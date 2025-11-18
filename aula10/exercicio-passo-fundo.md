### Busca de Dados no OpenStreetMap (OSM) via QGIS

Utilize a ferramenta **QuickOSM** (ou similar) no QGIS para buscar e baixar os seguintes temas geográficos para o município de **Passo Fundo – RS**:

  * **Limite Municipal de Passo Fundo – RS:**
      * **Chave:** Utilize `admin_level` com o código apropriado para limites municipais, conforme especificado na documentação do OSM (consulte [wiki.openstreetmap.org/wiki/Pt:Boundaries](https://wiki.openstreetmap.org/wiki/Pt:Boundaries)).
      * **Valor:** O valor correspondente ao nível administrativo de município.
  * **Bairros do Município (Areas/Subdivisions):**
      * **Chave/Valor:** Busque os bairros ou subdivisões (provavelmente utilizando `boundary=administrative` e o `admin_level` correspondente ou `place=suburb`/`place=neighbourhood`).
  * **Hospitais:**
      * **Chave/Valor:** `amenity = hospital`
      * **Geometria:** Ponto (node).
  * **Farmácias:**
      * **Chave/Valor:** `amenity = pharmacy`
      * **Geometria:** Polígono (way/area) e Ponto (node).

-----

### Geração de Shapefiles (Shape)

Após a busca no QGIS, exporte as camadas baixadas do OSM para o formato **Shapefile (.shp)**.

  * **⚠️ Atenção:** Não utilize acentuação ou caracteres especiais nos nomes dos arquivos e campos das tabelas.

| Tema | Nome Sugerido para o Shapefile |
| :--- | :--- |
| Limite Municipal | **municipio** |
| Bairros | **bairros** |
| Hospitais | **hospital** |
| Farmácias | **farmacia** |

-----

### Criação e Importação para o Banco de Dados Espacial

1.  **Criação do Banco de Dados:**
      * Crie um novo **Banco de Dados Espacial (BDE)** (ex.: PostgreSQL/PostGIS) com o nome: `passo_fundo`.
2.  **Importação dos Shapefiles:**
      * Utilize o **DB Manager** do QGIS ou ferramentas como o **shp2pgsql** para importar os *shapefiles* gerados (`municipio.shp`, `bairros.shp`, `hospital.shp`, `farmacia.shp`) para o banco de dados `passo_fundo`.

-----

### Consultas em SQL (PostGIS)

Elabore as seguintes consultas SQL para responder aos enunciados, assumindo que as geometrias estejam na coluna `geom` e que os nomes das colunas de nome e código sejam `nome` e `gid` (ou similar, dependendo da importação):

Liste o nome do bairro e o nome de todas as farmácias contidas nele.

Calcule a área de cada bairro e ordene o resultado da maior para a menor área.

Calcule a distância entre pares de farmácias, mostrando o código (`gid`) e o nome de cada farmácia com a respectiva distância.

Calcule a área do município de Passo Fundo em hectares.

Calcule a distância do hospital da Unimed em relação às farmácias. 
