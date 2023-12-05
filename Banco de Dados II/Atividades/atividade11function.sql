##1 - Criar função que mostre o aumento de 10% no valor da locação. Para isso voce vai fornecer o valor e acrescentar 10%, mas eu quero este valor com 2 casas decimais.##

use Sakila_PT;

delimiter //
create function Aumento_filmes(valor double) returns double deterministic
begin
return format((valor*1.10),2);
end
//

##2 - Faça uma função que converta o valor no formato americano (12,345.67) para o formato Brasileiro (12.345,67). Obs Não utilizae funções prontas do Mysql e não busque na internet a solução para o problema, exerça sua criatividade.##

delimiter //
create function converter(valor varchar(20)) returns varchar(20) deterministic
begin

DECLARE valor_br VARCHAR(50);

set valor_br = replace((valor), ".", "@");
set valor_br = replace(valor_br, ",",".");
set valor_br = replace(valor_br, "@",",");

return valor_br;
end
//

select converter("12,345.67");


##3- Faça uma função que mostre a quantidade de exemplares disponiveis para locação de um titulo especifico, excluindo os exemplares que estão locados, pasando somente o ID do Filme e o ID da Filial.##

create function quant_exem(id_filme int, id_filial	 int) returns int deterministic
begin

declare quant_disponivel int;

select count(*) into quant_disponivel
from loja
where filme_id = id_filme and loja_id = id_filial and loja_id not in ( select distinct loja_id from aluguel where data_de_devolucao is null);

return quant_disponivel;
end
//

select quant_exem(2,1);


