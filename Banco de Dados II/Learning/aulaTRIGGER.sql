delimiter //
create trigger filme_BEFORE_UPDATE 
BEFORE update ON filme for each row
begin
	if (new.preco_da_locacao<=0) or (new.preco_da_locacao is null) then
	begin
		signal sqlstate value '45000'
        set message_text = 'O VALOR NAO PODE SER NULL OU MENOR QUE ZERO';
end;
end if;
end;

delimiter //

CREATE DEFINER=`usuario`@`%` TRIGGER `filme_AFTER_UPDATE` AFTER UPDATE ON `filme` FOR EACH ROW BEGIN
	if old.preco_da_locacao<>new.preco_da_locacao then
    begin
    insert into  log_alteracao_valor(filme_id,valor_antigo,valor_novo,data)
    values (old.filme_id,old.preco_da_locacao,new.preco_da_locacao,now());
END;
end if;
end;


update filme set 
preco_da_locacao = 22
where filme_id = 1;