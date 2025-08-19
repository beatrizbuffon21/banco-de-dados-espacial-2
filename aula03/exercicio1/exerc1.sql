-- exerc1 ---------------------------------------------------------------------------------------------------------

-- criar tabelas:
create table empregado(num_emp integer primary key,
						nome_emp varchar(30),
						salario decimal(10,2),
						num_dept decimal(10,2));

create table departamento (num_dept integer primary key,
							nome varchar(30),
							ramal decimal(10,2));

-- criar gatilho para a tabela auditoria:
create table func_auditoria (operacao varchar(1),
								usuario varchar(30),
								data timestamp,
								num_dept decimal(10,2));


-- criar função que tenha sequência de comando:

create function processo_audit_func() returns trigger as $$
begin
	if (tg_op = 'DELETE') then
		insert into func_auditoria values ('E', user, now(), old.num_dept);
		return old;
	elseif (tg_op = 'UPDATE') then
		insert into func_auditoria values ('A', user, now(), old.num_dept);
		return new;
	elseif (tg_op = 'INSERT') then
		insert into func_auditoria values ('I', user, now(), new.num_dept);
		return new;
	end if;
	return null;
end;
$$ language plpgsql; 


-- criar trigger funcionario_audit:

create trigger funcionario_audit
after insert or update or delete on empregado
for each row execute procedure processo_audit_func();

-- inserir dados na tabela:

INSERT INTO empregado (num_emp, nome_emp, salario, num_dept)
VALUES
    (32, 'J Silva', 3800, 21),
    (74, 'M Reis', 4000, 25),
	(89, 'C Melo', 5200, 28),
    (92, 'R Silva', 4800, 25),
    (112, 'R Pinto', 3900, 21),
    (121, 'V Simão', 1905, 28);


INSERT INTO departamento (num_dept, nome, ramal)
VALUES
    (21, 'Pessoal', 142),
    (25, 'Financeiro', 143),
	(28, 'Técnico', 144);


-------- TESTE --------
-- inserir dados para testar o gatilho:
insert into empregado(num_emp, nome_emp, salario, num_dept)
VALUES (131, 'L Silveira', 3500, 28);

