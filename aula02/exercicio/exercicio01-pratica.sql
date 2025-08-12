-- EXERCÍCIO 1 PRÁTICA ---------------------------------------------------------------------------------------------------------
-- criando as tabelas:

create table marin(mid integer primary key,
					mnome varchar(30),
					status integer,
					idade numeric(10,2));

create table barcos(bid integer primary key,
						bnome varchar(30),
						cor varchar(30));

create table reserva(rid integer primary key,
						mid integer,
						bid integer,
						dia date);


-- criando um gatilho para a tabela auditoria(operacao, usuário, data e hora, codigo do
-- marinheiro) para ver qual usuário fez a reserva e em que data e horário

create table func_auditoria (operacao varchar(1),
								usuario varchar(30),
								data timestamp,
								mid integer);

-- criar função que tenha sequência de comando:

create function processo_audit_func() returns trigger as $$
begin
	if (tg_op = 'DELETE') then
		insert into func_auditoria values ('E', user, now(), old.mid);
		return old;
	elseif (tg_op = 'UPDATE') then
		insert into func_auditoria values ('A', user, now(), old.mid);
		return new;
	elseif (tg_op = 'INSERT') then
		insert into func_auditoria values ('I', user, now(), new.mid);
		return new;
	end if;
	return null;
end;
$$ language plpgsql; 

-- criando um gatilho que antes da inserção na tabela MARIN verifica se o nome do marinheiro é nulo.

create function verifica() returns trigger as $$
begin 
	if new.mnome is null then 
		raise exception 'O nome do marinheiro não pode ser nulo';
	end if;
	return new;
	end;
	$$ language plpgsql;


-- criar trigger funcionario_audit:

create trigger funcionario_audit
after insert or update or delete on reserva
for each row execute procedure processo_audit_func();

create trigger novo_func before insert or update on marin
for each row execute procedure verifica();

------ OBS: importar os arquivos de cada tabela clicando em cima da tabela específica
-- ir em import/export data, ativar o header e o delimitador ser ;


-------- TESTES --------
-- teste do nome ser nulo
insert into marin(mid, status, idade) values(3, 0, 40);

-- atualização do bid em reserva:
update reserva set bid = 300;



