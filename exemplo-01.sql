-- exemplo 01 ---------------------------------------------------------------------------------------------------------

-- criar tabela:

create table func(cod integer primary key,
					nome varchar(30),
					salario decimal(10,2),
					comissao decimal(10,2));

create table func_auditoria (operacao varchar(1),
								usuario varchar(30),
								data timestamp,
								nome_func varchar(40),
								salario decimal(10,2));

-- criar função que tenha sequência de comando:

create function processo_audit_func() returns trigger as $$
begin
	if (tg_op = 'DELETE') then
		insert into func_auditoria values ('E', user, now(), old.nome, old.salario);
		return old;
	elseif (tg_op = 'UPDATE') then
		insert into func_auditoria values ('A', user, now(), old.nome, old.salario);
		return new;
	elseif (tg_op = 'INSERT') then
		insert into func_auditoria values ('I', user, now(), new.nome, new.salario);
		return new;
	end if;
	return null;
end;
$$ language plpgsql; 

-- criar trigger funcionario_audit:

create trigger funcionario_audit
after insert or update or delete on func
for each row execute procedure processo_audit_func();

-- inserir dados na tabela:

INSERT INTO func VALUES(1,'João', 1800, 500);

-- atualização do salário:

update func set salario = 2000 where cod = 1;

-- deletando com alguma condição
DELETE FROM func
WHERE cod = 1
		