select Vendas.ID_Venda , Clientes.Nome_cliente , Fornecedores.Nome_Fornecedor , Produtos.Nome_Produto from Vendas
inner join Clientes on Vendas.ID_Cliente = Clientes.ID_Cliente
inner join Itens_Venda on Itens_Venda.ID_Venda = Vendas.ID_Venda
inner join Produtos on Produtos.ID_Produto = Itens_Venda.ID_Produto
inner join Fornecedores on  Produtos.ID_Fornecedor = Fornecedores.ID_Fornecedor
where
Fornecedores.Pais = 'Japan';



