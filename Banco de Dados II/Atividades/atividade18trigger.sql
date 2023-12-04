#1 - crie uma Triggers na Tabela Cliente não permitindo que o cliente seja criado como inativo.
delimiter //
create trigger clientes_antes_insert
before insert on cliente for each row
begin
	if new.ativo = 0 then
    signal sqlstate value '45000'
    set message_text = 'O CLIENTE NÃO PODE SER INATIVO';
end if;
end; //
delimiter ;

INSERT INTO cliente
(loja_id,primeiro_nome,ultimo_nome,email,endereco_id,ativo,data_criacao,ultima_atualizacao)
VALUES
(1,'ARIANA','GRANDE','grande@gmail.com',10,0,now(),now());

#2 - Crie uma Triggers na tabela Pagamento que não permita valores de pagamento negativo.
delimiter //
create trigger pagamentos_insert
before insert on pagamento for each row
begin
	if new.valor < 0 then
    signal sqlstate value '45000'
    set message_text = 'NÃO PODE SER NEGATIVO';
end if;
end; //
delimiter ;

INSERT INTO pagamento
(cliente_id,funcionario_id,aluguel_id,valor,data_de_pagamento,ultima_atualizacao)
VALUES
(1,2,573,-2,now(),now());

select * from pagamento;

#3 - Crie uma Triggers na tabela pagamento que não permita pagamento com data maior que a atual.
delimiter //
create trigger pagamentos_data
before insert on pagamento for each row
begin
	if new.data_de_pagamento > now() then
    signal sqlstate value '45000'
    set message_text = 'Não pode ser maior que a data atual';
end if;
end; //
delimiter ;

INSERT INTO pagamento
(cliente_id,funcionario_id,aluguel_id,valor,data_de_pagamento,ultima_atualizacao)
VALUES
(1,2,573,2,'2023-12-16 15:18:57',now());

select * from pagamento;




#4 - Crie uma Triggers que crie um log da alteração de Valor de locação,e do valor de reposição.
delimiter //
create trigger alterar_valor
after update on filme for each row begin
	if old.preco_da_locacao<>new.preco_da_locacao then
    begin
    insert into  log_alteracao_valor(filme_id,valor_antigo,valor_novo,data)
    values (old.filme_id,old.preco_da_locacao,new.preco_da_locacao,now());
end;
end if;
end; //
delimiter ;



#5 - Crie uma Triggers que não permita apagar um cliente que esteja ativo. Somente cliente inativos.
delimiter //
create trigger cliente_apagar
before insert on cliente for each row
begin
	if new.ativo = 1 then
    signal sqlstate value '45000'
    set message_text = 'O cliente ATIVO não pode ser removido';
end if;
end; //
delimiter ;

delete from cliente where cliente_id = 18;

select * from cliente;