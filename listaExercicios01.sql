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
