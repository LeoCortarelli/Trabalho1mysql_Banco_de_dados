#1 - Crie uma procedure que remova um filme, a partir do ID do filme, que remova os filmes relacionados  no inventário, e uma triggersque não permita a exclusão caso o filme esteja 
#		locado, caso ocorra um erro a operação seja desfeita.

delimiter //
create procedure remover_filme(
    in $filme_id int
)
begin
    declare $inventario_id int;

   
    select inventario_id into $inventario_id
    from inventario
    where filme_id = $filme_id;

    
    delete from aluguel
    where exemplar_id in (select exemplar_id from exemplar where inventario_id = $inventario_id);

    
    delete from pagamento
    where aluguel_id in (select aluguel_id from aluguel where exemplar_id in (select exemplar_id from exemplar where inventario_id = $inventario_id));

   
    delete from exemplar
    where inventario_id = $inventario_id;

   
    delete from inventario
    where inventario_id = $inventario_id;


    delete from filme
    where filme_id = $filme_id;

    select 'Filme removido com sucesso' as mensagem;
end //

delimiter ;

delimiter //
create trigger antes_de_remover_filme
before delete on filme
for each row
begin
    declare $locado int;

    select COUNT(*) into $locado
    from aluguel
    where exemplar_id in (select exemplar_id from exemplar where inventario_id = old.filme_id);

    if $locado > 0 then
        signal sqlstate '45000'
            set message_text = 'Voce nao pode excluir um filme locado';
    end if;
end //

delimiter ;

use Sakila_PT;


#2 - crie uma stored procedure que cadastre um usuario, e crie uma trigger que não permita a inserção do usuario caso não exista ID do endereço ou ID da loja nas tabelas 
#		Endereço e loja respectivamente. caso ocorra algum erro a operação deve ser desfeita. 

delimiter //
create procedure cadastrar_usuario(
    in $primeiro_nome varchar(45),
    in $ultimo_nome varchar(45),
    in $endereco_id int,
    in $loja_id int
)
begin
    declare $endereco_existe int;
    declare $loja_existe int;

    
    select COUNT(*) into $endereco_existe
    from endereco
    where endereco_id = $endereco_id;

    
    select COUNT(*) into $loja_existe
    from loja
    where loja_id = $loja_id;

    
    if $endereco_existe > 0 and $loja_existe > 0 then
        insert into usuario (primeiro_nome, ultimo_nome, endereco_id, loja_id)
        values ($primeiro_nome, $ultimo_nome, $endereco_id, $loja_id);

        select 'Usuário cadastrado com sucesso' as mensagem;
    else
        signal sqlstate '45000'
            set message_text = 'Não é permitido cadastrar um usuário sem endereço ou loja existente.';
    end if;
end //
delimiter ;

delimiter //
create trigger verificar_endereco_loja
before insert on usuario
for each row
begin
    declare $endereco_existe int;
    declare $loja_existe int;

    select COUNT(*) into $endereco_existe
    from endereco
    where endereco_id = new.endereco_id;


    select COUNT(*) into $loja_existe
    from loja
    where loja_id = new.loja_id;

    if $endereco_existe = 0 or $loja_existe = 0 then
        signal sqlstate '45000'
            set message_text = 'Não é permitido cadastrar um usuário sem endereço ou loja existente.';
    end if;
end //
delimiter ;


#3 - Crie uma procedure que insira um aluguel, e crie uma trigger que valide se o usuario e o filme pertencem a mesma filial, caso contrario a procedure precisa desfazer toda a alteração

delimiter //
create procedure inserir_aluguel(
    in $cliente_id int,
    in $filme_id int,
    in $funcionario_id int,
    in $data_aluguel datetime,
    in $data_devolucao datetime
)
begin
    declare $filial_cliente int;
    declare $filial_filme int;

    select filial_id into $filial_cliente
    from usuario
    where usuario_id = $cliente_id;

    select filial_id into $filial_filme
    from inventario
    where filme_id = $filme_id;

    if v_filial_cliente = v_filial_filme then
        insert into aluguel (cliente_id, exemplar_id, funcionario_id, data_aluguel, data_devolucao)
        values ($cliente_id, $filme_id, $funcionario_id, $data_aluguel, $data_devolucao);

        select 'Aluguel inserido com sucesso' as mensagem;
    else
        signal sqlstate '45000'
            set message_text = 'Não é permitido alugar um filme de outra filial.';
    end if;
end //
delimiter ;


delimiter //
create trigger validar_filial
before insert on aluguel
for each row
begin
    declare $filial_cliente int;
    declare $filial_filme int;

    select filial_id into $filial_cliente
    from usuario
    where usuario_id = new.cliente_id;

    select filial_id into $filial_filme
    from inventario
    where inventario_id = new.exemplar_id;

    if $filial_cliente <> $filial_filme then
        signal sqlstate '45000'
            set message_text = 'Não é permitido alugar um filme de outra filial.';
    end if;
end //
delimiter ;


#4 - Crie uma procedure que apague o cliente, e uma trigger que caso o cliente seja apagado ele insira em uma tabela de log o Id do cliente,nome do cliente, 
#email, id de quem apagou o cliente e data que foi apagado. caso ocorra algum erro a operação deve ser desfeita. 


delimiter //
create procedure apagar_cliente(
    in $cliente_id int,
    in $funcionario_id int
)
begin
    declare $cliente_nome varchar(255);
    declare $cliente_email varchar(255);

    select primeiro_nome, ultimo_nome, email
    into $cliente_nome, $cliente_email
    from cliente
    where cliente_id = $cliente_id;

    delete from cliente
    where cliente_id = $cliente_id;

    insert into log_cliente_apagado (cliente_id, nome_cliente, email_cliente, funcionario_id, data_apagado)
    values ($cliente_id, CONCAT($cliente_nome, ' ', $cliente_email), $funcionario_id, NOW());

    select 'Cliente apagado com sucesso' as mensagem;
end //
delimiter ;


delimiter //
create trigger log_apagar_cliente
after delete on cliente
for each row
begin
    declare $cliente_id int;
    declare $cliente_nome varchar(255);
    declare $cliente_email varchar(255);

    set $cliente_id = old.cliente_id;
    set $cliente_nome = CONCAT(old.primeiro_nome, ' ', old.ultimo_nome);
    set $cliente_email = old.email;

    insert into log_cliente_apagado (cliente_id, nome_cliente, email_cliente, funcionario_id, data_apagado)
    values ($cliente_id, CONCAT($cliente_nome, ' ', $cliente_email), $funcionario_id, NOW());
end //
delimiter ;
