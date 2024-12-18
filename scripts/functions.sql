-- Funcion para calcular los ingresos/perdidas totales
delimiter //
create function calc_ganancias(ingresos float, egresos float)
returns float deterministic
begin
  declare total float;
  set total = ingresos - egresos;
  return total;
end//

delimiter ; 

-- Funcion que retorna el nombre de la ciudad en la que se encuentra cada sucursal
delimiter //
create function devolver_ciudad(sucursal int)
returns varchar(100) deterministic
begin
  declare nombre_ciudad varchar (100);
  select c.nombre_ciudad into nombre_ciudad from sucursales s 
    join ciudades c on c.id_ciudad = s.id_ciudad 
    where s.id_sucursal = sucursal;
  return nombre_ciudad;
end // 
delimiter ;
