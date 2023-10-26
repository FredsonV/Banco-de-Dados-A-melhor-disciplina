--atividade 1
CREATE TRIGGER novo_cliente
AFTER INSERT ON Clientes
FOR EACH ROW
    INSERT INTO Auditoria (texto, Dataehora)
    VALUES ('Novo cliente inserido em ' + NOW());

--atividade 2
CREATE TRIGGER mensagem_auditoria
BEFORE DELETE ON Clientes
FOR EACH ROW
    INSERT INTO Auditoria (texto)
    VALUES ('Atenção!!! tentativa de exclusão na tabela Cliente ');

--atividade 3
CREATE TRIGGER cliente_updtae
AFTER UPDATE ON Clientes
FOR EACH ROW
    INSERT INTO Auditoria (texto)
    VALUES ('O antigo nome: ' + OLD.Nome 'Foi alterado para:' + New.Nome)

--atividade 4
CREATE TRIGGER cliente_nome_update_trigger
BEFORE UPDATE ON Clientes
FOR EACH ROW
    IF NEW.Nome IS NULL OR NEW.Nome = '' THEN
        INSERT INTO Auditoria (texto)
        VALUES ('Não coloque um valor nulo nem um texto vazio em seu nome');
    END IF;

--atividade 5
CREATE TRIGGER novo_pedido
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    UPDATE Produtos
    SET Estoque = Estoque - NEW.Quantidade
    WHERE ProdutoID = NEW.ProdutoID;
    IF (SELECT Estoque FROM Produtos WHERE ProdutoID = NEW.ProdutoID) <= 5 THEN
        INSERT INTO Auditoria (texto)
        VALUES ('Estoque do produto ' + CAST(NEW.ProdutoID AS CHAR) + ' ficou abaixo de 5 unidades.');
    END IF;
