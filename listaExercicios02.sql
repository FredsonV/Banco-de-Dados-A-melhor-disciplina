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

-- atividade 3
DELIMITER //
CREATE PROCEDURE sp_ContarLivrosPorCategoria(in categoriaNome VARCHAR(50), OUT livrosTotal)
BEGIN
	select count(*) into livrosTotal
	from livro
	inner join Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
	where Categoria.Nome = categoriaNome;
END;
//	
DELIMITER;

-- atividade 4 
DELIMITER //
CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoriaNome VARCHAR(100), OUT posselivro BOOLEAN)
BEGIN
	declare qtd INT;
	select count(*) into qtd
	from Livro
	inner join Categoria on Livro.Categoria_ID = Categoria_Categoria_ID
	where Categoria.Nome = categoria_ID;

	if qtd > 0 THEN
		set posselivro = TRUE;
	else
		set posselivro = False;
END;
//
DELIMITER;

-- atividade 5
DELIMITER //
CREATE PROCEDURE sp_LivrosAteAno(IN ano INT)
BEGIN
    select Titulo, Ano_Publicacao
    from Livro
    where Ano_Publicacao <= ano;
END;
//
DELIMITER ;

