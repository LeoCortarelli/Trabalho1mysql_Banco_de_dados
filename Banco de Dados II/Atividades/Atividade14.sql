#1 - Função para Calcular a Soma de Dois Números:
delimiter //
create function FC_soma_numeros($num1 int, $num2 int) returns int deterministic
begin
declare $resultado int;

set  $resultado = $num1 + $num2;

return $resultado; 

end;
//

select FC_soma_numeros(2,2) as soma;



#2 - Função para Encontrar o Comprimento de uma String:
delimiter //
create function FC_Tamanho_String($texto varchar(255)) returns int deterministic
begin

return length($texto); 

end;
//

select FC_Tamanho_String('Corinthians') as tamanho; 



#3 - Função para Verificar se um Número é Par:
delimiter //
create function FC_Numero_par_impar($numero int) returns varchar(255) deterministic
begin

	IF($numero % 2 = 0) THEN
		return 'PAR';
	ELSE
		return 'IMPAR';
	END IF;
end;
//

select FC_Numero_par_impar(35) as PAR_ou_IMPAR;



#4 - Função para Encontrar o Quadrado de um Número:
delimiter //
create function FC_QuadradoNumero($numero int) returns double deterministic
begin

return $numero * $numero;
	
end;
//

select FC_QuadradoNumero(2) as Quadrado;

#5 - Função para Calcular o Imposto sobre Vendas: (deve ser enviado dois valores, o valor a venda e a porcentagem do imposto.
delimiter //
create function FC_Calculo_Imposto($vendas int, porc_imposto int) returns double deterministic
begin
declare $resultado double;
declare $imposto double;

	set $imposto = porc_imposto / 100;
    
    set $resultado = $vendas * $imposto;

	
    
    return $resultado;
	
end;
//

select FC_Calculo_Imposto(1000,10) as imposto;



#1 - Faça uma procedure que retorne um select onde voce passa o id do filme e ele mostra o id do inventario:
delimiter //
create procedure Obter_Inventario_por_filme(in $filme_ID int) 
begin

	select inventario_id from inventario where filme_id = $filme_id;

end //
delimiter ;

call Obter_Inventario_por_filme(1);


#2 - Faça uma procedure onde você passe uma parte do nome e  mostre as informações de Cliente com nome em uma coluna, o endereço cidade e pais.
delimiter //
create procedure informacoes_Cliente(in $parte_nome varchar(50)) deterministic
begin

	select 
    concat(primeiro_nome, ' ',ultimo_nome) AS NOME,
    endereco as ENDERECO,
    cidade as CIDADE,
    pais as PAIS
    from 
    cliente
    join endereco on cliente.endereco_id = endereco.endereco_id
    join cidade on endereco.cidade_id = cidade.cidade_id
    join pais on cidade.pais_id = pais.pais_id
    where
    primeiro_nome like concat('%', $parte_nome, '%') or
    ultimo_nome like concat('%', $parte_nome, '%');

end //
delimiter ;
drop procedure informacoes_Cliente;
call informacoes_Cliente('John');



#3 - Faça uma procedure que retorne somente uma variavel mas não em forma de select, onde foce passe o ID do cliente e ele retorno o nome da Cidade onde ele mora.
delimiter //
create procedure nome_cidade_cliente(in $id_cliente int, out $cidade_cliente varchar(50)) 
begin

	select cidade into $cidade_cliente from cliente 
    inner join endereco on cliente.endereco_id = endereco.endereco_id
    inner join cidade on endereco.cidade_id = cidade.cidade_id where cliente.cliente_id = $id_cliente;

end //
delimiter ;

drop procedure nome_cidade_cliente;
call nome_cidade_cliente(22,@cidade);

select @cidade;