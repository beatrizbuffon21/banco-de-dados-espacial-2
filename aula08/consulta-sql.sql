select mercados.geom from bairro, mercados
where st_contains(bairro.geom, mercados.geom)
and bairro.nome = 'Camobi'


select mercados.cod, mercados.geom from bairro, mercados
where st_dwithin(st_transform(bairro.geom, 31982), st_transform(mercados.geom, 31982), 5000)
and bairro.nome = 'Camobi'