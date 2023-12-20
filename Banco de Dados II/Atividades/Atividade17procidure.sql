# Crie uma procedure que faça o cadastro de um filme e insira no inventario a quantidade de filmes que foram adquiridos, use transaction na procedure e teste para ver se a transaction funciona.
	delimiter //
	create procedure cadastrar_filme_inventario(in $titulo varchar(255),
    in $descricao varchar(255),
    in $ano_de_lancamento year,
    in $idioma_id int,
    in $duracao_da_locacao int,
    in $preco_da_locacao decimal,
    in $duracao_do_filme int,
    in $custo_de_substituicao decimal,
    in $classificacao enum('G','PG','PG-13','R','NC-17'),
    in $recursos_especiais enum('Trailers','Comentários','Cenas Deletadas','Outros'))
    
    begin
    insert into filme(titulo,descricao,ano_de_lancamento,idioma_id,duracao_da_locacao,preco_da_locacao,duracao_do_filme,custo_de_substituicao,classificacao,recursos_especiais)
    values ($titulo,$descricao,$ano_de_lancamento,$idioma_id,$duracao_da_locacao,$preco_da_locacao,$duracao_do_filme,$custo_de_substituicao,$classificacao,$recursos_especiais);
    
    set @novo_filme_id = LAST_INSERT_ID();  
    
    insert into inventario(filme_id,loja_id,ultima_atualizacao)
    values (@novo_filme_id,1,now());
    
    end //
    delimiter ;

call cadastrar_filme_inventario('OPPENHAIMER','Criação da bomba atomica',2023,1,5,3.99,180,20.99,'R','Trailers');
drop procedure cadastrar_filme_inventario;
select * from filme;
select * from inventario;


# Crie uma procedure que faz o emprestimo de um filme, utilize procedure
delimiter //
create procedure emprestar_filme(in $cliente_id int, in $inventario_id int, in $funcionario_id int, in $dataEmprestimo datetime,in $dataDevolucao datetime)
begin
	declare $filme_id int;
    declare $preco_aluguel decimal(5,2);
    
    select filme_id into $filme_id 
    from inventario
    where inventario_id = $inventario_id and quantidade > 0 limit 1;
    
    if v_filme_id is not null then
        select preco_aluguel into v_preco_aluguel
        from filme
        where filme_id = v_filme_id;
    
    INSERT INTO aluguel(data_de_aluguel,inventario_id,cliente_id,data_de_devolucao,funcionario_id,ultima_atualizacao)
		VALUES
		($dataEmprestimo,$inventario_id,$cliente_id,$dataDevolucao,$funcionario_id,now());
	
    update inventario
    set quantidade = quantidade - 1
    where inventario_id = $inventario_id;
    
    INSERT INTO pagamento(cliente_id,funcionario_id,valor,data_de_pagamento,ultima_atualizacao)
		VALUES
		($cliente_id,$funcionario_id,$preco_aluguel,$dataEmprestimo,now());
        
		select 'Empréstimo realizado com sucesso' as mensagem;
    else
        select 'Filme não disponível no inventário' as mensagem;
    end if;
	
end //
delimiter ;

call emprestar_filme(1, 1, 1, '2023-11-01 10:00:00', '2023-11-15 10:00:00');


# Crie uma procedure que faça a devolução de um fime com o seu pagamento.

delimiter //
create procedure devolucao_filme(in $aluguel_id int,in $funcionario_id int,in $data_devolucao datetime)
begin
	declare $filme_id int;
    declare $cliente_id int;
    declare $valor_pago decimal(5,2);
    
    select filme_id, cliente_id into $filme_id, $cliente_id
    from aluguel
    where aluguel_id = $aluguel_id;
    
    if $filme_id is not null then
        update exemplar
        set emprestado = 0
        where exemplar_id = $filme_id;

        select valorpreco_da_locacao into $valor_pago
        from filme
        where filme_id = $filme_id;
        
        INSERT INTO pagamento(cliente_id,funcionario_id,valor,data_de_pagamento,ultima_atualizacao)
			VALUES
			($cliente_id,$funcionario_id,$valor_pago,$data_devolucao,now());

        update aluguel
        set data_de_devolucao = $data_devolucao
        where aluguel_id = $aluguel_id;
        
        select 'Devolução realizada com sucesso' as mensagem;
    else
        select 'Aluguel não encontrado' as mensagem;
    end if;

end //
delimiter ;

call devolucao_filme(1, 1, '2023-11-15 10:00:00');