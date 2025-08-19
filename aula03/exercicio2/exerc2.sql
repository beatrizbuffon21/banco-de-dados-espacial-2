-- exerc2 ---------------------------------------------------------------------------------------------------------

-- criar tabelas:
create table automovel(placa varchar(30) primary key,
						marca varchar(30),
						modelo varchar(30),
						cor varchar(30));

create table propriedade (cod_propriedade integer primary key,
							placa varchar(30),
							cod_pessoa varchar(30));

create table pessoa (cod_pessoa varchar(30) primary key,
						nome varchar(30),
						endereco varchar(30),
						sexo varchar(30));

-- inserir dados na tabela:

INSERT INTO automovel (placa, marca, modelo, cor)
VALUES
    ('A1', 'Honda', 'Fit', 'Prata'),
    ('A2', 'Chevrolet', 'Astra', 'Branca');

INSERT INTO propriedade (cod_propriedade, placa, cod_pessoa)
VALUES
    (1, 'A1', 'P1'),
    (2, 'A2', 'P2');

INSERT INTO pessoa (cod_pessoa, nome, endereco, sexo)
VALUES
    ('P1', 'A', 'E1', 'M'),
    ('P2', 'B', 'E2', 'F');
	
-- criar gatilho para a tabela auditoria:
create table func_auditoria (operacao varchar(1),
								usuario varchar(30),
								data timestamp,
								cod_propriedade decimal(10,2));

-- criar função que tenha sequência de comando:

create function processo_audit_func() returns trigger as $$
begin
	if (tg_op = 'DELETE') then
		insert into func_auditoria values ('E', user, now(), old.cod_propriedade);
		return old;
	elseif (tg_op = 'UPDATE') then
		insert into func_auditoria values ('A', user, now(), old.cod_propriedade);
		return new;
	elseif (tg_op = 'INSERT') then
		insert into func_auditoria values ('I', user, now(), new.cod_propriedade);
		return new;
	end if;
	return null;
end;
$$ language plpgsql; 


-- criar trigger funcionario_audit:

create trigger funcionario_audit
after insert or update or delete on propriedade
for each row execute procedure processo_audit_func();


-- cadastrar novo automovel na tabela automovel:
INSERT INTO automovel (placa, marca, modelo, cor)
VALUES
    ('A3', 'Fiat', 'Palio', 'Preto');
	
-------- TESTE --------
-- inserir dados para testar o gatilho:
insert into propriedade(cod_propriedade, placa, cod_pessoa)
VALUES (3, 'A3', 'P2');

