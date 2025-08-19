-- exerc4 - vendas ---------------------------------------------------------------------------------------------------------

-- criar tabelas:
CREATE table vendedor(cod_vend integer primary key,
						nome_vend varchar(50),
						salario_fixo decimal(10,2),
						faixa_comissao varchar (01));

CREATE table cliente(cod_cli integer primary key,
						nome_cli varchar(50),
						endereco varchar(60),
						numero varchar(15),
						cidade varchar(30),
						cep decimal(10,0),
						uf varchar(02),
						cnpj varchar(20),
						ie integer);

CREATE table pedido(num_ped integer primary key,
						prazo_entrega integer,
						cod_cli integer,
						cod_vend integer,
						FOREIGN KEY(cod_cli) REFERENCES cliente(cod_cli),
						FOREIGN KEY(cod_vend) REFERENCES vendedor(cod_vend));

-- inserir dados nas tabelas:

INSERT INTO vendedor (cod_vend, nome_vend, salario_fixo, faixa_comissao)
VALUES
    (209, 'José', 1800.50, 'C'),
    (111, 'Carlos', 2490.00, 'A'),
    (11,  'João', 2780.00, 'C'),
    (240, 'Antônio', 9500.00, 'C'),
    (720, 'Felipe', 4600.00, 'A'),
    (213, 'Jonas', 2300.00, 'A'),
    (101, 'João', 2650.00, 'C'),
    (310, 'Josias', 870.00, 'B'),
    (250, 'Maurício', 2930.00, 'B');


INSERT INTO cliente (cod_cli, nome_cli, endereco, numero, cidade, cep, uf, cnpj, ie)
VALUES
    (720, 'Ana', 'Dezessete', '19', 'Niterói', 24358310, 'RJ', 1211323100134, 2134),
    (870, 'Flávio', 'Presidente Vargas', '10', 'São Paulo', 22763931, 'SP', 2253412693879, 4631),
    (110, 'Jorge', 'Caiapó', '13', 'Curitiba', 30078500, 'PR', 1451276498349, 9343),
    (830, 'Maurício', 'Paulista', '1236 sl 2345', 'São Paulo', 3012683, 'SP', 3281698574656, 7431),
    (410, 'Rodolfo', 'Largo da Lapa', '27', 'Rio de Janeiro', 30078900, 'RJ', 1283512823469, 7431),
    (20, 'Beth', 'Climério', '45', 'São Paulo', 25679300, 'SP', 3248512673268, 9280);


INSERT INTO pedido (num_ped, prazo_entrega, cod_cli, cod_vend)
VALUES
    (121, 20, 410, 209),
    (97,  20, 720, 101),
    (101, 15, 720, 101),
    (137, 20, 720, 720),
    (148, 20, 720, 101),
    (189, 15, 870, 213),
    (104, 30, 110, 101),
    (203, 30, 830, 250),
    (98,  20, 410, 209),
    (143, 30,  20, 111);


-- criar gatilho para a tabela auditoria:
CREATE table func_auditoria (operacao varchar(1),
								usuario varchar(30),
								data timestamp,
								cod_vend integer);

-- criar função que tenha sequência de comando:

CREATE function processo_audit_func() returns trigger as $$
begin
	if (tg_op = 'DELETE') then
		insert into func_auditoria values ('E', user, now(), old.cod_vend);
		return old;
	elseif (tg_op = 'UPDATE') then
		insert into func_auditoria values ('A', user, now(), old.cod_vend);
		return new;
	elseif (tg_op = 'INSERT') then
		insert into func_auditoria values ('I', user, now(), new.cod_vend);
		return new;
	end if;
	return null;
end;
$$ language plpgsql; 


-- criar trigger funcionario_audit:

CREATE trigger funcionario_audit
after INSERT or UPDATE or DELETE on pedido
for each row execute procedure processo_audit_func();

-------- TESTE --------
-- inserir dados para testar o gatilho:
INSERT into pedido (num_ped, prazo_entrega, cod_cli, cod_vend)
VALUES (130, 25, 410, 209);
