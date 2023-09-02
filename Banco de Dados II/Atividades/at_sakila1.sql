use Sakila_PT;

-- ############## Exercicio 1 ######################

create view clientes_info as
select cliente.cliente_id as ID_cliente,
concat(cliente.primeiro_nome, ' ',cliente.ultimo_nome) as Nome_completo,
endereco.endereco as Endereco,
endereco.cep as CEP,
endereco.telefone as Telefone_Contato,
cidade.cidade as Cidade,
pais.pais as Pais,
IF(cliente.ativo, 'ATIVO', 'Nao ativo') as Status,
loja.loja_id as ultima_atualizacao
from cliente
join endereco on cliente.endereco_id = endereco.endereco_id 
join cidade on endereco.cidade_id = cidade.cidade_id
join pais on cidade.pais_id = pais.pais_id
join loja on cliente.loja_id = loja.loja_id;

select * from clientes_info;

-- ############## Exercicio 2 ######################

create view atores_filmes_view as 
select ator.ator_id as ator_id,
ator.primeiro_nome as nome_ator,
ator.ultimo_nome as sobrenome_ator,
group_concat(filme.titulo order by filme.titulo ASC) as filmes_que_atuou
from ator
join filme_ator on ator.ator_id = filme_ator.ator_id
join filme on filme_ator.filme_id = filme.filme_id
group by
ator.ator_id, nome_ator, sobrenome_ator;

select * from atores_filmes_view;

-- ############## Exercicio 3 ######################

drop view atores_filmes_view;
select * from atores_filmes_view;

create view atores_filmes_view as 
select ator.ator_id as ator_id,
ator.primeiro_nome as nome_ator,
ator.ultimo_nome as sobrenome_ator,
group_concat(filme.titulo," = ",categoria.nome, " ") as categoria_dos_filmes_ator
from ator
join filme_ator on ator.ator_id = filme_ator.ator_id
join filme on filme_ator.filme_id = filme.filme_id
join filme_categoria on filme.filme_id = filme_categoria.filme_id
join categoria on filme_categoria.categoria_id = categoria.categoria_id
group by
ator.ator_id, nome_ator, sobrenome_ator;
