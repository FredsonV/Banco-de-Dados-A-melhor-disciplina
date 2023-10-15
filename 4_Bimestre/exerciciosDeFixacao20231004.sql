--atividade 1
CREATE FUNCTION total_livros_por_genero(genero_param VARCHAR(255))
RETURNS INT
BEGIN
  DECLARE total INT;
  SET total = 0;
  
  DECLARE cur CURSOR FOR
  SELECT Genero FROM Livro;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET total = total;
  
  OPEN cur;
  
  read_loop: LOOP
    FETCH cur INTO genero;
    IF Genero = Genero_param THEN
      SET total = total + 1;
    END IF;
  END LOOP;
  
  CLOSE cur;
  
  RETURN total;
END;

SELECT total_livros_por_genero('Ficção Científica') AS total_ficcao_cientifica;


--atividade 2
CREATE FUNCTION listar_livros_por_autor(
  primeiro_nome_autor_param VARCHAR(255),
  ultimo_nome_autor_param VARCHAR(255)
)
RETURNS VARCHAR(255)
BEGIN
  DECLARE lista_titulos VARCHAR(1000);
  SET lista_titulos = '';
  
  DECLARE cur CURSOR FOR  
  SELECT Livro_ID FROM Livro_Autor
  WHERE Autor_Primeiro_Nome = primeiro_nome_autor_param
  AND Autor_Ultimo_Nome = ultimo_nome_autor_param;
  
  DECLARE Livro_id INT;
  DECLARE done INT DEFAULT 0;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  
  OPEN cur;
  
  read_loop: LOOP
    FETCH cur INTO livro_id;
    IF done THEN
      LEAVE read_loop;
    END IF;

    SELECT Titulo INTO @titulo FROM Livro WHERE Livro_ID = livro_id;
    
    SET lista_titulos = CONCAT(lista_titulos, @titulo, ', ');
  END LOOP;
  
  CLOSE cur;
  
  RETURN lista_titulos;
END;

SELECT listar_livros_por_autor('PrimeiroNome', 'UltimoNome') AS titulos_livros_autor;


--atividade 3 
DELIMITER //
CREATE FUNCTION atualizar_resumos()
RETURNS INT
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE Livro_id INT;
  DECLARE resumo_atual VARCHAR(1000);
  
  DECLARE cur CURSOR FOR
  SELECT Livro_ID, Resumo FROM Livro;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  
  OPEN cur;
  
  update_loop: LOOP
    FETCH cur INTO Livro_id, resumo_atual;
    IF done THEN
      LEAVE update_loop;
    END IF;
    
    SET resumo_atual = CONCAT(resumo_atual, ' Este é um excelente livro!');
    
    UPDATE Livro SET Resumo = resumo_atual WHERE Livro_ID = livro_id;
  END LOOP;
  
  CLOSE cur;
  
  RETURN 1;
END;
//
DELIMITER ;

CALL atualizar_resumos();


--atividade 4 
DELIMITER //
CREATE FUNCTION media_livros_por_editora()
RETURNS DECIMAL(10,2)
BEGIN
  DECLARE total_livro INT;
  DECLARE total_editora INT;
  DECLARE media DECIMAL(10,2);
  
  SET total_livro = 0;
  SET total_editoras = 0;
  SET media = 0.00;
  
  DECLARE cur_editora CURSOR FOR
  SELECT Editora_ID FROM Editora;
  
  DECLARE editora_id INT;
  DECLARE done_editora INT DEFAULT 0;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_editora = 1;
  
  OPEN cur_editora;
  
  editoras_loop: LOOP
    FETCH cur_editora INTO editora_id;
    IF done_editora THEN
      LEAVE editora_loop;
    END IF;
    
    DECLARE cur_livro CURSOR FOR
    SELECT COUNT(*) FROM Livro WHERE Editora_ID = editora_id;
    
    DECLARE livro_count INT;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET livro_count = 0;
    
    OPEN cur_livro;
    FETCH cur_livro INTO livro_count;
    CLOSE cur_livro;

    SET total_livro = total_livro + livro_count;
    SET total_editora = total_editora + 1;
  END LOOP;
  
  CLOSE cur_editora;
  
  IF total_editora > 0 THEN
    SET media = total_livro / total_editora;
  END IF;
  
  RETURN media;
END;
//
DELIMITER ;

SELECT media_livros_por_editora() AS media_livros_por_editora;


--atividade 5
DELIMITER //
CREATE FUNCTION autores_sem_livros()
RETURNS TEXT
BEGIN
  DECLARE lista_autores TEXT;
  SET lista_autores = '';

  DECLARE cur_autores CURSOR FOR
  SELECT Autor_ID, Primeiro_Nome, Ultimo_Nome FROM Autor;

  DECLARE Autor_id INT;
  DECLARE primeiro_nome_autor VARCHAR(255);
  DECLARE ultimo_nome_autor VARCHAR(255);
  DECLARE done_autores INT DEFAULT 0;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_autores = 1;

  OPEN cur_autores;

  autores_loop: LOOP
    FETCH cur_autores INTO autor_id, primeiro_nome_autor, ultimo_nome_autor;
    IF done_autores THEN
      LEAVE autores_loop;
    END IF;

    IF NOT EXISTS (
      SELECT 1 FROM Livro_Autor WHERE Autor_ID = autor_id
    ) THEN
      SET lista_autores = CONCAT(lista_autores, primeiro_nome_autor, ' ', ultimo_nome_autor, ', ');
    END IF;
  END LOOP;

  CLOSE cur_autores;

  SET lista_autores = SUBSTRING(lista_autores, 1, LENGTH(lista_autores) - 2);

  RETURN lista_autores;
END;
//
DELIMITER ;

SELECT autores_sem_livros() AS autores_sem_livros;
