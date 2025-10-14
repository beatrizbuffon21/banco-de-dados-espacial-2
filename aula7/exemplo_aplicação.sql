-- EXEMPLOS DE APLICAÇÃO DE CONSULTAS SQL:

-- 1. Recuperar o código e o preço dos produtos:
SELECT id, preco
FROM produtos;

-- 2. Recuperar o código, nome e o preço do produto que tenha o nome Manteiga. Renomeie a tabela para “p”:
SELECT p.id, p.nome, p.preco
FROM produtos as p
WHERE p.nome = 'Manteiga'

-- 3. Recuperar os nomes e o preço dos produtos que iniciem com a letra P.
SELECT nome, preco
FROM produtos
WHERE nome
LIKE 'P%'

-- 4. Recuperar os produtos com preço entre 15 e 30:
SELECT *
FROM produtos
WHERE (preco between 15 and 30)

-- 5. Ordenar a tabela produtos em ordem ascendente pelo preço:
SELECT *
FROM produtos
ORDER BY preco ASC;

-- 6. Ordenar a tabela produtos em ordem descendente pelo preço:
SELECT * FROM produtos
ORDER BY preco DESC;

-- 7. Encontrar a média de preço dos produtos:
SELECT AVG(preco) as media
FROM produtos;

-- 8. Encontrar o menor preço dos produtos:
SELECT MIN(preco) as minimo
FROM produtos;

-- 9. Encontrar o maior preço:
SELECT MAX(preco) as maximo
FROM produtos;

-- 10. Encontrar o total de preço dos produtos:
SELECT SUM(preco) as soma
FROM produtos;

-- 11. Encontre o produto que tenha seu nome iniciado com a letra P e preço menor que 15:
SELECT *
FROM produtos
WHERE nome
LIKE 'P%' AND preco < 15

-- 12. Encontra o produto que tenha seu nome iniciado com a letra P ou preço menor que 15:
SELECT *
FROM produtos
WHERE nome
LIKE 'P%' OR preco < 15
