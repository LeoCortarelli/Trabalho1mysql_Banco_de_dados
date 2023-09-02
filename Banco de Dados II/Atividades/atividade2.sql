select 
replace(cast((sum(IV.Quantidade*P.Valor)) as CHAR), ".", ",") as Total , 
date_format(V.Data_Venda,"%m/%Y") as Data
from Vendas V inner join Itens_Venda IV on IV.ID_Venda = V.ID_Venda
inner join Produtos P on P.ID_Produto = IV.ID_Produto
where month(Data_Venda) = 11 and year(Data_Venda)= 1996
group by Data;