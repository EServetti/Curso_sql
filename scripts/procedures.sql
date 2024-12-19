-- Procedimiento para cambiar la fabrica que provee a una sucursal
DELIMITER //
create procedure cambiar_fabrica(in id_sucursal int, in id_fabrica int)
begin
  update sucursales s set s.id_fabrica = id_fabrica where s.id_sucursal = id_sucursal;
  
end //

DELIMITER ;

-- Procedimiento para cambiar el gerente de una sucursal
DELIMITER //
create procedure cambiar_gerente(in id_sucursal int, in dni_gerente int)
begin
  update sucursales s set s.dni_gerente = dni_gerente where s.id_sucursal = id_sucursal;
end //

DELIMITER ;
