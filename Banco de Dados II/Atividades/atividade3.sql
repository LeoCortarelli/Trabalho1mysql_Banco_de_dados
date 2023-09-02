select Vendas.ID_Venda , Vendas.ID_Cliente , Clientes.Nome_cliente , date_format(Data_Venda , '%d/%m/%Y') as Data,
format(sum(Itens_Venda.Quantidade * Produtos.Valor),2)as Total from Vendas 
inner join Itens_Venda on Itens_Venda.ID_Venda = Vendas.ID_Venda
inner join Produtos on Produtos.ID_Produto = Itens_Venda.ID_Produto
inner join Clientes on Vendas.ID_Cliente = Clientes.ID_Cliente
where month(Data_Venda) = 11 and year(Data_Venda) = 1996
group by Vendas.ID_Venda , Vendas.ID_Cliente , Vendas.Data_Venda , Clientes.Nome_cliente;


