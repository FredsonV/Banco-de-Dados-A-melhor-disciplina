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
