-- exemplo 02 ---------------------------------------------------------------------------------------------------------

-- criar uma função com um comando de teste do nome

create function verifica() returns trigger as $$
begin 
	if new.nome is null then 
		raise exception 'O nome do funcionário não pode ser nulo';
	end if;
	return new;
	end;
	$$ language plpgsql;

-- criar a trigger 

create trigger novo_func before insert or update on func
for each row execute procedure verifica()

-- inserção de dados

insert into func(cod, nome, salario, comissao) values(3, 'Paulo', 2400, 700);