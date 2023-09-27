-- atividade 1
DELIMITER //
CREATE PROCEDURE sp_ListarAutores()
BEGIN
	select nome 
    from Autor;
END;
//
DELIMITER ;

call sp_ListarAutores()
