-- ATIVIDADE 1
-- a)
CREATE TABLE nomes (
    nome VARCHAR(50)
);

INSERT INTO nomes (nome)
VALUES
    ('Roberta'),
    ('Roberto'),
    ('Maria Clara'),
    ('João');


-- b)
SELECT UPPER(nome) as nome_maiusculo
FROM nomes;


-- c)
SELECT nome, LENGTH(nome) as tamanho_nome
FROM nomes;

-- d)
SELECT
    CASE
        when nome like '%João%' or nome like '%Roberto%' then CONCAT('Sr. ', nome)
        when nome like '%Maria%' then CONCAT('Sra. ', nome)
        else nome
    end as nome_com_prefixo
FROM nomes;


-- ATIVIDADE 2
-- a) 
CREATE TABLE produtos (
    produto VARCHAR(50),
    preco DECIMAL(6, 2),
    quantidade INT
);

-- b)
UPDATE produtos
SET preco = ROUND(preco, 2);

-- c)
SELECT produto, preco, ABS(quantidade) as quantidade_absoluta
FROM produtos;

-- d)
SELECT AVG(preco) as media_de_precos
FROM produtos;

