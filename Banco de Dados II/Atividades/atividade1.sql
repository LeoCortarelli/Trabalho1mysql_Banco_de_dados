select Nome_cliente from Clientes where ID_Cliente not in (select ID_Cliente from Vendas);

