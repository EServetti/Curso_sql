create schema if not exists heladerias_servetti;
use heladerias_servetti; 

-- Creación de tablas

CREATE TABLE Paises (
    id_pais INT PRIMARY KEY AUTO_INCREMENT,
    nombre_pais VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE Provincias (
    id_provincia INT PRIMARY KEY AUTO_INCREMENT,
    id_pais int not null,
    nombre_provincia VARCHAR(30) UNIQUE NOT NULL,
    foreign key (id_pais) references Paises(id_pais)
);

CREATE TABLE Ciudades (
    id_ciudad INT PRIMARY KEY AUTO_INCREMENT,
    nombre_ciudad VARCHAR(30) UNIQUE NOT NULL,
    id_provincia INT NOT NULL,
    FOREIGN KEY (id_provincia) REFERENCES Provincias(id_provincia)
);

create table Proveedores (
id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
nombre_proveedor varchar(30) not null
);

CREATE TABLE Fabricas (
    id_fabrica INT PRIMARY KEY AUTO_INCREMENT,
    id_ciudad INT NOT NULL,
    FOREIGN KEY (id_ciudad) REFERENCES Ciudades(id_ciudad)
);

CREATE TABLE Fabricas_proveedores (
    id_fabrica INT NOT NULL,
    id_proveedor INT NOT NULL,
    PRIMARY KEY (id_fabrica , id_proveedor),
    FOREIGN KEY (id_fabrica)
        REFERENCES Fabricas (id_fabrica),
    FOREIGN KEY (id_proveedor)
        REFERENCES Proveedores (id_proveedor)
);

CREATE TABLE Rangos_empleados (
    id_rango INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    rango_empleado VARCHAR(15) NOT NULL
);

CREATE TABLE Socios (
    dni INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(25),
    puntos FLOAT
);

CREATE TABLE Sucursales (
    id_sucursal INT PRIMARY KEY AUTO_INCREMENT,
    fecha_apertura VARCHAR(20),
    id_fabrica INT NOT NULL,
    FOREIGN KEY (id_fabrica) REFERENCES Fabricas(id_fabrica),
    id_ciudad INT NOT NULL,
    FOREIGN KEY (id_ciudad) REFERENCES Ciudades(id_ciudad)
);

CREATE TABLE Empleados (
    id_rango int not null,
    id_sucursal int not null,
    dni INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(25),
    fecha_nacimiento varchar(20),
    foreign key(id_rango) references Rangos_empleados(id_rango),
    foreign key(id_sucursal) references Sucursales(id_sucursal)
);

create table Productos (
id_producto int primary key auto_increment,
nombre_producto varchar(30) not null,
precio_producto float not null
);

create table Sabores (
id_sabor int primary key auto_increment,
nombre_sabor varchar(30) not null
);

create table Formas_pago (
id_forma_pago int primary key auto_increment,
nombre_forma_pago varchar(30)
);

create table Ventas (
id_venta int primary key auto_increment,
id_sucursal int not null,
id_producto int not null,
id_sabor int not null,
id_forma_pago int not null,
dni_comprador int,
fecha varchar(20),
foreign key(id_sucursal) references Sucursales(id_sucursal),
foreign key(id_producto) references Productos(id_producto),
foreign key(id_sabor) references Sabores(id_sabor),
foreign key(id_forma_pago) references Formas_pago (id_forma_pago)
);

CREATE TABLE Ingresos (
    monto FLOAT NOT NULL,
    mes INT NOT NULL,
    año INT NOT NULL,
    id_sucursal INT NOT NULL,
    FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal),
    UNIQUE (mes, año, id_sucursal)
);

CREATE TABLE Egresos (
    monto FLOAT NOT NULL,
    mes INT NOT NULL,
    año INT NOT NULL,
    id_sucursal INT NOT NULL,
    FOREIGN KEY (id_sucursal)
        REFERENCES Sucursales (id_sucursal),
    UNIQUE (mes , año , id_sucursal)
);

-- Creación de vistas
create view Info_empleados as select e.nombre, e.dni, e.fecha_nacimiento, r.rango_empleado, s.id_sucursal, c.nombre_ciudad as ciudad_sucursal from Empleados e 
join Rangos_empleados r on e.id_rango = r.id_rango 
join Sucursales s on e.id_sucursal = s.id_sucursal
join Ciudades c on s.id_ciudad = c.id_ciudad;

create view Info_ventas as select v.id_venta, v.id_sucursal, p.nombre_producto, s.nombre_sabor, p.precio_producto as monto, v.fecha from Ventas v 
join Productos p on p.id_producto = v.id_producto
join Sabores s on s.id_sabor = v.id_sabor
join Formas_pago f on f.id_forma_pago = v.id_forma_pago;

create view Info_sucursales as select s.id_sucursal, c.nombre_ciudad, ps.nombre_pais, e.nombre as gerente from Sucursales s 
join Ciudades c on c.id_ciudad = s.id_ciudad  
join Provincias p on p.id_provincia = c.id_provincia
join Paises ps on ps.id_pais = p.id_pais 
left join Empleados e on e.id_sucursal = s.id_sucursal and e.id_rango = 1;

CREATE VIEW Info_fabricas AS
    SELECT 
        f.id_fabrica,
        c.nombre_ciudad,
        GROUP_CONCAT(p.nombre_proveedor
            SEPARATOR ', ') AS proveedores
    FROM
        Fabricas f
            JOIN
        Ciudades c ON c.id_ciudad = f.id_ciudad
            JOIN
        Fabricas_proveedores fp ON fp.id_fabrica = f.id_fabrica
            JOIN
        Proveedores p ON p.id_proveedor = fp.id_proveedor
    GROUP BY f.id_fabrica;

CREATE VIEW Mas_vendidos AS
    SELECT 
        p.nombre_producto,
        s.nombre_sabor,
        COUNT(*) AS cantidad_vendida
    FROM
        Ventas v
            JOIN
        Productos p ON p.id_producto = v.id_producto
            JOIN
        Sabores s ON s.id_sabor = v.id_sabor
    GROUP BY p.id_producto , s.id_sabor
    ORDER BY cantidad_vendida DESC;
    
-- Creación de procedimientos

delimiter //
create procedure actualizar_rango ( in dni_empleado int, in new_id_rango int)
begin
update Empleados set id_rango = new_id_rango where dni = dni_empleado;
end //

delimiter ;

delimiter //
create procedure agregar_sabor (in nombre varchar(20))
begin
insert into Sabores (nombre_sabor) values (nombre);
end // 
delimiter ;

-- Creación de funciones

delimiter //
create function ventas_sucursal(id int) returns int deterministic
begin
declare cant_ventas int;
SELECT 
    COUNT(*)
INTO cant_ventas FROM
    Ventas
WHERE
    id_sucursal = id;
return cant_ventas;
end //
    
delimiter ;

delimiter //
create function ver_gerente(id_suc int) returns varchar(20) deterministic
begin
declare gerente varchar(20);
select e.nombre into gerente from Empleados e where e.id_sucursal = id_suc and e.id_rango = 1;
return gerente;
end //
delimiter ;

-- Creación de triggers

delimiter //
create trigger sumar_puntos 
after insert on Ventas
for each row
begin
declare nuevosPuntos int;
select p.precio_producto into nuevosPuntos from Productos p where p.id_producto = new.id_producto;
update Socios set puntos = puntos + nuevosPuntos where dni = new.dni_comprador;
end //

delimiter ;

delimiter //
create trigger chequear_empleados 
before delete on Sucursales
for each row
begin
if exists(
select 1 from Empleados where id_sucursal = old.id_sucursal
) then 
signal sqlstate "45000" set message_text = "No se puede eliminar, hay empleados relacionados a esta sucursal";
end if;
end // 

delimiter ; 




