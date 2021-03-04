CREATE DATABASE gerenciamentoMercado;

USE gerenciamentoMercado;

-- Entidades --

CREATE TABLE cliente(
CPF varchar(20),
nome varchar(100) not null,
contato varchar(50) not null,
data_nasc date not null,
email varchar(50) not null,
primary key(CPF)
);

CREATE TABLE endereco(
id int auto_increment,
uf character(2) not null,
cidade varchar(50) not null,
endereco varchar(255),
CEP varchar(20) not null,
cliente varchar(20) not null,
primary key(id),
foreign key(cliente) references cliente(CPF)
);

CREATE TABLE tipo_usuario(
id int auto_increment,
nome varchar(100) not null,
primary key(id)
);

CREATE TABLE usuario(
id int auto_increment,
nome varchar(100) not null,
email varchar(255) not null,
senha varchar(50) not null,
tipo_usuario int not null,
foreign key(tipo_usuario) references tipo_usuario(id),
primary key(id)
);

CREATE TABLE produto(
id int auto_increment,
nome varchar(255) not null,
empresa varchar(100) not null,
categoria varchar(100) not null,
preco_compra decimal(10,2) not null,
preco_venda decimal(10,2) not null,
qtd_estoque int not null,
codigo_de_barras varchar(255),
data_vencimento date not null,
cadastro_usuario int,
primary key(id),
foreign key(cadastro_usuario) references usuario(id)
);

CREATE TABLE servico(
id int auto_increment,
descricao varchar(255) not null,
preco decimal(10,2) not null,
primary key(id)
);

CREATE TABLE forma_pagamento(
id int auto_increment,
nome varchar(50) not null,
primary key(id)
);

CREATE TABLE fatura(
id int auto_increment,
quitado boolean not null,
data_vencimento date not null,
data_pagamento date,
valor_total decimal(10,2),
valor_total_pago decimal(10,2) default 0,
primary key(id)
);

CREATE TABLE pagamento(
id int auto_increment,
parcelas int not null,
forma_pagamento int not null,
fatura int not null,
cliente varchar(20) not null,
primary key(id),
foreign key(forma_pagamento) references forma_pagamento(id),
foreign key(fatura) references fatura(id),
foreign key(cliente) references cliente(CPF)
);

-- tabelas intermediarias --

CREATE TABLE fatura_produtos(
id int auto_increment,
quantidade int not null,
produto int not null,
fatura int not null,
primary key(id),
foreign key(produto) references produto(id),
foreign key(fatura) references fatura(id)
);

CREATE TABLE fatura_servicos(
id int auto_increment,
servico int not null,
fatura int not null,
primary key(id),
foreign key(servico) references servico(id),
foreign key(fatura) references fatura(id)
);

CREATE TABLE atendimento(
id int auto_increment,
data_atend datetime not null,
usuario int not null,
cliente varchar(20) not null,
primary key(id),
foreign key(usuario) references usuario(id),
foreign key(cliente) references cliente(CPF)
);

CREATE TABLE contratacao_servicos(
id int auto_increment,
data_contrat datetime not null,
servico int not null,
cliente varchar(20) not null,
primary key(id),
foreign key(servico) references servico(id),
foreign key(cliente) references cliente(CPF)
);

CREATE TABLE compras(
id int auto_increment,
data_compra datetime not null,
quantidade int not null,
produto int not null,
cliente varchar(20) not null,
primary key(id),
foreign key(produto) references produto(id),
foreign key(cliente) references cliente(CPF)
);

-- Inserção de dados --

INSERT INTO cliente (CPF, nome, contato, data_nasc, email) VALUES 	("384.902.840-92", "Samuel Cezar", "19 99473-8290", "2001-07-18", "samuelCezar@gmail.com"), 
																	("839.992.839-02", "Pedro Lanatti", "19 99602-8127", "2001-02-19", "pedroLanatti@gmail.com");

INSERT INTO endereco(uf, cidade, endereco, CEP, cliente) VALUES 	("SP", "Hortolândia", "Rua Estreita, Nº  440", "13184-040", "384.902.840-92"), 
																	("SP", "Sumaré", "Rua Estrela Radiante, Nº 667", "14890-008", "839.992.839-02");

INSERT INTO tipo_usuario(nome) VALUES ("Administrador de sistema"), ("Funcionário do mercado"), ("Cliente com acesso especial"); 

INSERT INTO usuario(nome, email, senha, tipo_usuario) VALUES ("Samuel Cezar", "samuelCezar@gmail.com", "@1234", 3), ("João Ribeirão", "joaoRibeirao@gmail.com", "joaoRibeirao123", 2);

INSERT INTO produto	(nome, empresa, categoria, preco_compra, preco_venda, qtd_estoque, codigo_de_barras, data_vencimento, cadastro_usuario) VALUES 	
					("Pacote de feijão carioca de 1 kg", "Feijoeiros do Brasil", "Alimentos", 2.98, 4.92, 1200, "ydo26Hj1dl4sUy6h7e", "2023-08-24", 2), 
					("Pacote de arroz de 5 kg", "Albara alimentos", "Alimentos", 18.97, 28.96, 360, "Jk3s6iO54IU2dnJ1Lk4snI6Pu9sR", "2023-10-12", 2);

INSERT INTO servico(descricao, preco) VALUES ("Notificação de promoções", 29.99), ("Encomenda de produtos", 49.99);

INSERT INTO forma_pagamento(nome) VALUES ("Cartão de crédito"), ("Boleto"), ("Dinheiro"), ("Cartão de débito"); 

INSERT INTO fatura(quitado, data_vencimento, data_pagamento, valor_total, valor_total_pago) VALUES (true, "2021-03-18", "2021-03-04", 99.19, 99.19), (false, "2021-03-14", null, 58.95, 0);

INSERT INTO pagamento(parcelas, forma_pagamento, fatura, cliente) VALUES (1, 3, 1, "384.902.840-92"), (1, 2, 2, "839.992.839-02");

INSERT INTO fatura_produtos(quantidade, produto, fatura) VALUES (10, 1, 1), (1, 2, 2);

INSERT INTO fatura_servicos(servico, fatura) VALUES (2, 1),  (1, 2);

INSERT INTO atendimento(data_atend, usuario, cliente) VALUES ("2021-03-04 13:28:56", 2, "384.902.840-92"), ("2021-03-04 10:48:32", 2, "839.992.839-02");

INSERT INTO contratacao_servicos(data_contrat, servico, cliente) VALUES ("2021-03-04 13:28:56", 2, "384.902.840-92"), ("2021-03-04 10:48:32", 1, "839.992.839-02");

INSERT INTO compras(data_compra, quantidade, produto, cliente) VALUES ("2021-03-04 13:28:56", 10, 1, "384.902.840-92"), ("2021-03-04 10:48:32", 1, 2, "839.992.839-02");
