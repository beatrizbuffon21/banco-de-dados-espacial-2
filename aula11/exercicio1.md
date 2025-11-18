### Exportação para Shapefiles

Utilize o **Gerenciador de BD** (DB Manager) do QGIS ou ferramentas externas (como o *shp2pgsql* inverso) para exportar as seguintes tabelas do seu banco de dados **"turismo"** para o formato Shapefile (.shp):

1.  **Tabela `ponto_turistico`** $\rightarrow$ Shapefile: `ponto_turistico.shp`
2.  **Tabela `hospedagem`** $\rightarrow$ Shapefile: `hospedagem.shp`

-----

### Consultas Espaciais no QGIS (Gerenciador de BD)

Utilize a aba **SQL Janela** no **Gerenciador de BD** do QGIS para elaborar e executar as seguintes consultas. Para cada consulta, marque a opção **"Carregar como nova camada"** e adicione o resultado ao projeto do QGIS.

**Assunções:**

  * As tabelas são `ponto_turistico` e `hospedagem`.
  * A coluna de geometria é `geom` (ou similar).
  * A coluna de nome é `nome` (ou similar).
  * As colunas de endereço/localização são `endereco` e `bairro` (ou similar).
  * O Sistema de Referência de Coordenadas (SRC) utiliza metros como unidade de medida para as consultas de distância (`ST_DWithin`).

-----
1) Quais os nomes e a geometria das hospedagens localizadas na rua Nossa Senhora das Dores?
2) Quais os nomes e a geometria das hospedagens localizados no bairro Cerrito?
3) Quais os nomes e a geometria das hospedagens localizados no bairro Camobi?
4) Quais os nomes e a geometria dos pontos turísticos localizados na Praça Saldanha Marinho?
5) Quais os nomes e a geometria das hospedagens que estão à 5 km de Camobi? 
