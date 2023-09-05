--atividade 1
select titulo from livros;

--atividade 2
select NOME from autores
WHERE nascimento < '1900-01-01';

--atividade 3
select titulo.from livros 
inner join autores on autores.nome = 'J.K. Rowling';
