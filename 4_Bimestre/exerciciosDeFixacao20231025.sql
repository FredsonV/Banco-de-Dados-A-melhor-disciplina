--atividade 1
CREATE TRIGGER novo_cliente
AFTER INSERT ON Clientes
FOR EACH ROW
    INSERT INTO Auditoria (texto, Dataehora)
    VALUES ('Novo cliente inserido em ' + NOW());
