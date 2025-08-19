-- exerc3 ---------------------------------------------------------------------------------------------------------

-- criar tabelas:
CREATE table cliente(cod_cliente integer primary key,
						nome varchar(30),
						cpf varchar(14));

CREATE table conta(num_cta integer primary key,
					saldo decimal(11,2),
					limite decimal(11,2),
					cod_cliente decimal(11,2));

-- inserir dados nas tabelas:

INSERT INTO cliente(cod_cliente, nome, cpf)
VALUES 
	(1, 'José', 31875638735),
	(2, 'Maria', 30045667856);

INSERT INTO conta(num_cta, saldo, limite, cod_cliente)
VALUES 
	(1, 1000, 500, 1),
	(2, 2000, 700, 2);


-- criar gatilho para a tabela auditoria:
CREATE table func_auditoria (operacao varchar(1),
								usuario varchar(30),
								data timestamp,
								num_cta decimal(10,2));

-- criar função que tenha sequência de comando:

CREATE function processo_audit_func() returns trigger as $$
begin
	if (tg_op = 'DELETE') then
		insert into func_auditoria values ('E', user, now(), old.num_cta);
		return old;
	elseif (tg_op = 'UPDATE') then
		insert into func_auditoria values ('A', user, now(), old.num_cta);
		return new;
	elseif (tg_op = 'INSERT') then
		insert into func_auditoria values ('I', user, now(), new.num_cta);
		return new;
	end if;
	return null;
end;
$$ language plpgsql; 


-- criar trigger funcionario_audit:

CREATE trigger funcionario_audit
after INSERT or UPDATE or DELETE on conta
for each row execute procedure processo_audit_func();

-------- TESTE --------
-- alterar limite da conta do cliente 2 para testar o gatilho:
UPDATE conta
SET saldo = 2000,
	limite = 700,
	cod_cliente = 2
WHERE num_cta = 2;
