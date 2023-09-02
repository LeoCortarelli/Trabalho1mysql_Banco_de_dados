use Sakila_PT;
-- ############## Exercicio 1 ######################

create view Lista_Filmes as
select filme.filme_id as ID_FILME,
filme.titulo as TITULO_FILME,
filme.descricao as DESCRICAO_FILME,
categoria.nome as CATEGORIA_FILME,
filme.preco_da_locacao as VALOR,
filme.duracao_do_filme as DURACAO_FILME,
filme.classificacao as CLASSIFICACAO_FILME,
group_concat(ator.primeiro_nome, " ",ator.ultimo_nome, ",") as ATORES
from filme
inner join filme_categoria on filme.filme_id = filme_categoria.filme_id
inner join categoria on filme_categoria.categoria_id = categoria.categoria_id
left join filme_ator on categoria.categoria_id = filme_ator.filme_id
left join ator on filme_ator.ator_id = ator.ator_id
group by ID_FILME, TITULO_FILME,DESCRICAO_FILME,CATEGORIA_FILME,VALOR,DURACAO_FILME,CLASSIFICACAO_FILME;

select * from Lista_Filmes;

-- ############## Exercicio 2 ######################

