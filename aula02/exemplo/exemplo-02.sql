-- exemplo 02 ---------------------------------------------------------------------------------------------------------

-- criar uma função com um comando de teste do nome

CREATE function verifica() returns trigger as $$
begin 
	if new.nome is null then 
		raise exception 'O nome do funcionário não pode ser nulo';
	end if;
	return new;
	end;
	$$ language plpgsql;

-- criar a trigger 

CREATE trigger novo_func before INSERT or UPDATE on func
for each row execute procedure verifica()

-- inserção de dados

INSERT into func(cod, nome, salario, comissao)
VALUES(3, 'Paulo', 2400, 700);

