-- Questão 1

select avg(f.salario) as media_salarial, d.nome_departamento
from funcionario f
inner join departamento d
on d.numero_departamento = f.numero_departamento
group by d.nome_departamento;

-- Questão 2

select avg(f.salario) as media_salarial, f.sexo
from funcionario f
group by f.sexo;


-- Questão 3

select d.nome_departamento,
concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_funcionario,
f.data_nascimento,
timestampdiff (year, data_nascimento, curdate()) as idade,
f.salario
from departamento d
inner join funcionario f
on f.numero_departamento = d.numero_departamento;

-- Questão 4

select concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_funcionario,
f.data_nascimento,
timestampdiff (year, data_nascimento, curdate()) as idade,
f.salario as salario_atual,
(case
when (f.salario < 35) then 20
else 15
end) as taxa_reajuste,
(case
when (f.salario < 35) then f.salario + (f.salario * 0.2)
else f.salario + (f.salario * 0.15)
end) as salario_ajustado
from funcionario f;

-- Questão 5

with gerente as (
select concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome,
f.cpf
from funcionario f
)
select d.nome_departamento,
concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_funcionario,
f.data_nascimento,
timestampdiff (year, data_nascimento, curdate()) as idade,
f.salario,
g.nome as nome_gerente
from departamento d
inner join funcionario f
on f.numero_departamento = d.numero_departamento
inner join gerente g on g.cpf = d.cpf_gerente
order by d.nome_departamento asc, f.salario desc;

-- Questão 6

select concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) funcionário, dpt.nome_departamento Departamento, 
concat(d.nome_dependente, ' ', f.nome_meio, ' ', f.ultimo_nome) dependente, timestampdiff(year, d.data_nascimento, curdate()) "Idade do Dependente",
case
when d.sexo = 'M' then "Masculino"
when d.sexo = 'F' then "Feminino"
end "Sexo do Dependente"
from funcionario f
inner join departamento dpt
on f.numero_departamento = dpt.numero_departamento
inner join dependente d
on f.cpf = d.cpf_funcionario;

-- Questão 7

select concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) funcionário, dpt.nome_departamento departamento,
concat("R$", ' ', f.salario) Salário
from funcionario f
left outer join dependente d
on f.cpf = d.cpf_funcionario
inner join departamento dpt
on f.numero_departamento = dpt.numero_departamento
where d.cpf_funcionario is null;

-- Questão 8

select dpt.nome_departamento departamento, p.nome_projeto projeto,
concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) "Nome Completo", concat(t.horas, "h") Horas
from funcionario f 
inner join departamento dpt 
inner join projeto p 
inner join trabalha_em t
where f.numero_departamento = dpt.numero_departamento 
and p.numero_projeto = t.numero_projeto 
and f.cpf = t.cpf_funcionario 
order by p.numero_projeto;

-- Questão 9

select dpt.nome_departamento Departamento, p.nome_projeto Projeto, sum(distinct(t.horas)) "Tempo Total"
from trabalha_em t
inner join funcionario f
on t.cpf_funcionario = f.cpf
inner join departamento dpt
on f.numero_departamento = dpt.numero_departamento
inner join projeto p
on t.numero_projeto = p.numero_projeto
group by p.nome_projeto;


-- Questão 10

select avg(f.salario) as media_salarial, d.nome_departamento
from funcionario f
inner join departamento d
on d.numero_departamento = f.numero_departamento
group by d.nome_departamento;

-- Questão 11

select concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) Funcionário, p.nome_projeto Projeto,
case
when t.horas > 0 then concat("R$", ' ', t.horas * 50)
else "R$ 0.0"
end "Total Recebido"
from funcionario f
inner join trabalha_em t
on f.cpf = t.cpf_funcionario
inner join projeto p
on t.numero_projeto = p.numero_projeto
order by t.horas desc;

-- Questão 12

select dpt.nome_departamento Departamento, p.nome_projeto Projeto,
f.primeiro_nome Funcionário, concat(t.horas, "h") "Horas de Trabalho"
from funcionario f 
inner join departamento dpt
on f.numero_departamento = dpt.numero_departamento
inner join projeto p
on dpt.numero_departamento = p.numero_departamento
inner join trabalha_em t
on p.numero_projeto = t.numero_projeto
where t.horas = 0;

-- Questão 13

select concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) "Nome Completo",
case 
when f.sexo = "M" then "Masculino"
when f.sexo = "F" then "Feminino"
end Sexo,
timestampdiff(year, f.data_nascimento, curdate()) Idade
from funcionario f
union
select concat(d.nome_dependente, ' ', f.nome_meio, ' ', f.ultimo_nome) "Nome Completo",
case
when d.sexo = "M" then "Masculino"
when d.sexo = "F" then "Feminino"
end Sexo,
timestampdiff(year, d.data_nascimento, curdate()) Idade
from dependente d 
inner join funcionario f
on d.cpf_funcionario = f.cpf
order by idade desc;
