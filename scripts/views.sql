-- Vista para ver los ingresos con su sucursal y ciudad
create view ingresos_por_sucursal as 
select s.id_sucursal, c.nombre_ciudad, i.monto as ingresos, i.mes, i.año from sucursales s
join ingresos i on i.id_sucursal = s.id_sucursal
join ciudades c on c.id_ciudad = c.id_ciudad;

-- Vista para ver los egresos con su sucursal y ciudad
create view egresos_por_sucursal as 
select s.id_sucursal, c.nombre_ciudad, e.monto as egresos, e.mes, e.año from sucursales s
join egresos e on e.id_sucursal = s.id_sucursal
join ciudades c on (c.id_ciudad = s.id_ciudad);

-- Vista con info basica de las sucursales
create view info_basica_sucursal as 
select s.id_sucursal, c.nombre_ciudad as ubicación, p.nombre_provincia as provincia,
 g.nombre_gerente, s.id_fabrica as suministrada from sucursales s
join ciudades c on c.id_ciudad = s.id_ciudad
join gerentes g on g.dni_gerente = s.dni_gerente
join provincias p on p.id_provincia = c.id_provincia;

-- Vista con info basica de las fabricas
create view info_basica_fabrica as
select f.id_fabrica, c.nombre_ciudad as ubicación,
p.nombre_provincia as provincia, s.id_sucursal as suministra_a  from fabricas f
join ciudades c on c.id_ciudad = f.id_ciudad
join provincias p on p.id_provincia = c.id_provincia
join sucursales s on s.id_fabrica = f.id_fabrica;

-- Vista con info basica de los gerentes
create view info_basica_gerente as
select g.nombre_gerente as nombre, g.edad_gerente as edad, s.id_sucursal, 
c.nombre_ciudad from gerentes g 
join sucursales s on s.dni_gerente = g.dni_gerente
join ciudades c on c.id_ciudad = s.id_ciudad;



