-- exercício 01 ---------------------------------------------------------------------------------------------------------

CREATE extension postgis;

-- criar tabelas:

CREATE table quadra(cod_q integer primary key,
					cod_bairro integer,
					area decimal(10,2),
					perimetro decimal(10,2),
					geom geometry(polygon, 4326));

CREATE table supermercado(cod_super integer primary key,
					nome varchar(30),
					cod_q integer,
					geom geometry(point, 4326));		

CREATE table func_auditoria (operacao varchar(1),
								usuario varchar(30),
								data timestamp,
								cod_super integer);

-- criar uma trigger para calcular a área e o perímetro da quadra:

CREATE or replace function fun_area_perimetro()
returns trigger as $$
begin
	new.area = st_area((st_transform(new.geom, 31982)))::decimal(10,2);
	new.perimetro = st_perimeter((st_transform(new.geom, 31982)))::decimal(10,2);
	
return new;
end;
$$
language 'plpgsql';

drop trigger if exists trg_area_perimetro on quadra;

CREATE trigger trg_area_perimetro before INSERT or UPDATE
on quadra for each row execute procedure fun_area_perimetro();

-- criar função que tenha sequência de comando:

CREATE function audit_func() returns trigger as $$
begin
	if (tg_op = 'DELETE') then
		INSERT into audit_func values ('E', user, now(), old.cod_super);
		return old;
	elseif (tg_op = 'UPDATE') then
		INSERT into audit_func values ('A', user, now(), old.cod_super);
		return new;
	elseif (tg_op = 'INSERT') then
		INSERT into audit_func values ('I', user, now(), new.cod_super);
		return new;
	end if;
	return null;
end;
$$ language plpgsql; 

-- criar trigger tgr_super:

CREATE trigger tgr_super
after INSERT or UPDATE or DELETE on supermercado
for each row execute procedure audit_func();

-- inserindo os dados na tabela quadra:

INSERT INTO quadra (cod_q, cod_bairro, geom) VALUES(1, 25, ST_GeometryFromText('POLYGON
((-53.72314631153348 -29.70272678245547,
  -53.72240706578632 -29.70269241265155,
  -53.72245853093477 -29.70154590055382,
  -53.72318462649164 -29.70154853958881,
  -53.72314631153348 -29.70272678245547))',4326));

INSERT INTO quadra (cod_q, cod_bairro, geom) VALUES(2, 25, ST_GeometryFromText('POLYGON
((-53.72229522073339 -29.7051696345083,
  -53.72142017098327 -29.70515756239424,
  -53.72145926123027 -29.7038910332961,
  -53.72238548134251 -29.70390822101315,
  -53.72229522073339 -29.7051696345083))',4326));
	
INSERT INTO quadra (cod_q, cod_bairro, geom) VALUES(3, 25, ST_GeometryFromText('POLYGON
((-53.71903313229075 -29.7013627764927,
  -53.71811311958798 -29.70152542662423,
  -53.71833073675573 -29.69834632464209,
  -53.71921403443514 -29.69830828352658,
  -53.71903313229075 -29.7013627764927))',4326));

-- inserindo os dados na tabela supermercado:

INSERT INTO supermercado (cod_super, cod_q, geom) VALUES(1, 25, ST_GeometryFromText('POINT
(-53.72275644263554 -29.70188157565755)',4326));

INSERT INTO supermercado (cod_super, cod_q, geom) VALUES(2, 25, ST_GeometryFromText('POINT
(-53.72179802261991 -29.7044594871462)',4326));

INSERT INTO supermercado (cod_super, cod_q, geom) VALUES(3, 25, ST_GeometryFromText('POINT
(-53.71873548125777 -29.70119679916137)',4326));

