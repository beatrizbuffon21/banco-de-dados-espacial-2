## Exercício 1  

Desenvolva um banco de dados que será formado pelas tabelas **bairro**, **quadra**, **supermercado**, **auditoria**.

- **bairro(cod_bairro, nome, geom)**  
- **quadra(cod_q, cod_bairro, area, perimetro, geom)**  
- **supermercado(cod_super, nome, cod_q, geom)**  
- **auditoria(operacao, usuario, data, cod_super)**  

Busque os bairros de Santa Maria que serão armazenados usando a geometria polígono e obtidos por meio do complemento **QuickOSM** no **QGIS**, usando a tag `"admin_level"` com o valor `10` e gere um shapefile para ser importado no banco de dados.  

Após a importação, a tabela deverá ser alterada de modo a seguir a especificação anterior para os campos da mesma.  

---

Gere a tabela **quadra** e crie um **trigger** para calcular a área e o perímetro dos polígonos de **3 quadras** obtidas no Google Earth, que contenham supermercados no bairro **Camobi**.  

Na tabela **supermercado**, crie um **trigger** para a tabela `auditoria(operacao, usuario, data, cod_super)` para que se tenha estes dados para cada código de supermercado que seja incluído, alterado ou excluído na tabela **supermercado**, onde deverá ser incluído um supermercado para cada quadra incluída.  

O supermercado será representado pela geometria **ponto**.  

## Exercício 2:
No banco de dados criado para realização do exercício 2 da aula 4, acrescente a tabela area_exper com os campos cod_area, nome, geom, onde deverá ser armazenado o polígono que contém a área total da área experimental Coxilha-UFSM. Posteriormente, acrescente na tabela talhao, o campo cod_area referente a área experimental.

Crie uma trigger que verifique se a geometria do talhão está dentro do polígono da área experimental.

## Exercício 3:
No banco de dados criado para realização do exercício 3 da aula 4, acrescente à tabela restaurante o código do prédio e crie um gatilho para verificar se a geometria do restaurante está dentro do polígono do prédio.
