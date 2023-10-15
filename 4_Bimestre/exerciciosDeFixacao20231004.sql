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
