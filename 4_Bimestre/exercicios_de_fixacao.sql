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


-- ATIVIDADE 3
-- a)
CREATE TABLE eventos (
    data_evento DATE
);

INSERT INTO eventos (data_evento)
VALUES
    ('1999-12-06'),
    ('2020-02-13'),
    ('2022-10-06'),
    ('2023-04-09');

-- b)
INSERT INTO eventos (data_evento)
VALUES (NOW());

-- c)
SELECT
    data_evento as data_inicial,
    CURDATE() as data_final,
    DATEDIFF(CURDATE(), data_evento) as dias_entre_datas
FROM eventos;

-- d)
SELECT
    data_evento,
    DAYNAME(data_evento) as dia_da_semana
FROM eventos;


-- ATIVIDADE 4
-- a) 
SELECT
    produto,
    quantidade,
    IF(quantidade > 0, 'Em estoque', 'Fora de estoque') as status_estoque
FROM produtos;

-- b)
SELECT
    produto,
    quantidade,
    preco,
    IF(quantidade > 0, quantidade * preco, 0) as valor_total
FROM produtos;


-- ATIVIDADE 5
-- a) 
CREATE FUNCTION TOTAL_VALOR(preco DECIMAL(6, 2), quantidade INT)
RETURNS DECIMAL(6, 2)
BEGIN
    DECLARE valor_total DECIMAL(6, 2);
    SET valor_total = preco * quantidade;
    RETURN valor_total;
END;

-- b)
SELECT
    produto,
    preco,
    quantidade,
    TOTAL_VALOR(preco, quantidade) as valor_total
FROM produtos;


-- ATIVIDADE 6 
-- a)
SELECT COUNT(*) as numero_total_de_produtos
FROM produtos;

-- b)
SELECT produto, MAX(preco) as produto_mais_caro
FROM produtos;

-- c)
SELECT produto, MIN(preco) as produto_mais_barato
FROM produtos;

-- d)
SELECT SUM(IF(quantidade > 0, preco * quantidade, 0)) as soma_total_em_estoque
FROM produtos;


-- ATIVIDADE 7
-- a) 
CREATE or REPLACE FUNCTION calcular_fatorial(n in NUMBER)
RETURN NUMBER IS
BEGIN
    IF n <= 1 THEN
        RETURN 1;
    ELSE
        RETURN n * calcular_fatorial(n - 1);
    END IF;
END calcular_fatorial;

-- b) 
CREATE OR REPLACE FUNCTION f_exponencial(base IN NUMBER, expoente IN NUMBER)
RETURN NUMBER IS
    resultado NUMBER := 1;
BEGIN
    IF expoente < 0 THEN
        RETURN NULL;
    ELSIF expoente = 0 THEN
        RETURN 1;
    ELSE
        FOR i IN 1..expoente LOOP
            resultado := resultado * base;
        END LOOP;
        RETURN resultado;
    END IF;
END f_exponencial;
/

-- c) 
CREATE or REPLACE FUNCTION is_palindromo(palavra in VARCHAR2)
RETURN NUMBER IS
    palavra_invertida VARCHAR2(4000);
BEGIN
    palavra_invertida := REVERSE(palavra);
    
    IF palavra = palavra_invertida THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END is_palindromo;
/


