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
