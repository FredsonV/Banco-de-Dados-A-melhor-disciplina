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

-- atividade 2
DELIMITER //
CREATE PROCEDURE sp_LivrosPorCategoria(in CategoriaNome VARCHAR(50))
	BEGIN
		select Livro.titulo
		from Livro
		inner join Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
	END;
//
DELIMITER ;

call sp_LivrosPorCategoria('Autoajuda');
