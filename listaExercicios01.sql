
--atividade 1
select titulo from livros;

--atividade 2
select NOME from autores
where nascimento < '1900-01-01';

--atividade 3
select titulo.from livros 
inner join autores on autores.nome = 'J.K. Rowling';

--atividade 4
select alunos.nome
from alunos 
join matriculas on alunos.id = matriculas.aluno_id
where matriculas.curso = 'Engenharia de Software';

--atividade 5
select produto, SUM(receita) as receita_total
from vendas
group by produto;

--atividade 6
select autores.nome, count(livros.id) as livros_total
from autores
left join livros on autores.id = livros.autor_id
group by autores.id;

--atividade 7
select curso, count(aluno_id) as quantidade_de_alunos
from matriculas
group by curso;

--atividade 8
select produto, AVG(receita) as media_receita
from vendas
group by produto;

--atividade 9
select produto, SUM(receita) as receita_final
from vendas
group by produto
having receita_final > 10000;

--atividade 10
select autores.nome, count(livros.id) as total_de_livros
from autores
left join livros on autores.id = livros.autor_id
group by autores.id
having total_de_livros > 2;

--atividade 11
select titulo, autores.nome as autor
FROM livros
inner join autores where livros.autor_id = autores.id;

--atividade 12
select nome, curso from alunos
inner join matriculas on alunos.id = matriculas.aluno_id;
