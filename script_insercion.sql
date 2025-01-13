-- Seleccionar el esquema
USE heladerias_servetti;

-- Tabla Paises
INSERT INTO Paises (nombre_pais) VALUES
('Argentina'),
('Brasil'),
('Chile'),
('Uruguay'),
('Paraguay');

-- Tabla Provincias
INSERT INTO Provincias (id_pais, nombre_provincia) VALUES
(1, 'Buenos Aires'),
(1, 'Córdoba'),
(1, 'Santa Fe'),
(1, 'Mendoza'),
(1, 'Tucumán');

-- Tabla Ciudades
INSERT INTO Ciudades (nombre_ciudad, id_provincia) VALUES
('La Plata', 1),
('Córdoba', 2),
('Rosario', 3),
('Mendoza', 4),
('San Miguel de Tucumán', 5);

-- Tabla Proveedores
INSERT INTO Proveedores (nombre_proveedor) VALUES
('Productos lacteos ORG'),
('Frutas Córdoba'),
('Azucar SA'),
('Envasados Santa Fe'),
('Plasticos SA');

-- Tabla Fabricas
INSERT INTO Fabricas (id_ciudad) VALUES
(1),
(2),
(3),
(4),
(5);

-- Tabla Fabricas_proveedores
insert into Fabricas_proveedores (id_fabrica, id_proveedor) values
(1,1),
(1,3),
(2,1),
(2,2),
(2,4),
(3,3),
(4,1),
(4,2),
(4,3),
(4,4),
(5,3),
(5,4),
(5,5);

-- Tabla Rangos_empleados
INSERT INTO Rangos_empleados (rango_empleado) VALUES
('Gerente'),
('Supervisor'),
('Cajero'),
('Vendedor'),
('Limpieza');

-- Tabla Socios
INSERT INTO Socios (dni, nombre, puntos) VALUES
(12345678, 'Juan Pérez', 150.5),
(23456789, 'Ana López', 200.0),
(34567890, 'Carlos Gómez', 120.7),
(45678901, 'María Díaz', 300.3),
(56789012, 'Lucía Fernández', 50.8);

-- Tabla Sucursales
INSERT INTO Sucursales (fecha_apertura, id_fabrica, id_ciudad) VALUES
('2020-01-01', 1, 1),
('2021-02-01', 2, 2),
('2022-03-01', 3, 3),
('2023-04-01', 4, 4),
('2024-05-01', 5, 5);

-- Tabla Empleados
INSERT INTO Empleados (id_rango, id_sucursal, dni, nombre, fecha_nacimiento) VALUES
(1, 1, 12345678, 'Juan Pérez', '1990-05-15'),
(2, 1, 87654321, 'María López', '1985-09-20'),
(3, 2, 45678901, 'Carlos Gómez', '1995-03-10'),
(1, 3, 78901234, 'Ana Torres', '1998-12-25'),
(2, 4, 23456789, 'Lucía Fernández', '1992-07-30'),
(2, 3, 50123458, 'Julia Gómez', '1985-07-12'), 
(3, 2, 51234589, 'Marta Fernández', '1990-03-22'),
(1, 2, 52345678, 'Lucas Pérez', '1992-01-15'),
(1, 4, 53456789, 'Nicolás Díaz', '1988-10-08'),
(1, 5, 54567890, 'Andrea García', '1995-12-19'),
(3, 1, 55678901, 'Daniel López', '1987-04-05'),
(2, 4, 56789012, 'Sofía Morales', '1983-09-16'), 
(3, 5, 57890123, 'Patricia Ruiz', '1991-11-29'),
(2, 5, 58901234, 'Mariana Ortega', '1986-02-10'), 
(4, 2, 59012345, 'Guillermo Castro', '1993-05-14');


-- Tabla Productos
INSERT INTO Productos (nombre_producto, precio_producto) VALUES
('1/4 kg Helado', 600.0),
('1/2 kg Helado', 1100.0),
('1 kg Helado', 2000.0),
('Helado 1 Bocha', 300.0),
('Helado 2 Bochas', 500.0);

-- Tabla Sabores
INSERT INTO Sabores (nombre_sabor) VALUES
('Chocolate'),
('Vainilla'),
('Frutilla'),
('Dulce de Leche'),
('Limón');

-- Tabla Formas_pago
INSERT INTO Formas_pago (nombre_forma_pago) VALUES
('Efectivo'),
('Tarjeta de Crédito'),
('Tarjeta de Débito'),
('Mercado Pago'),
('Transferencia Bancaria');

INSERT INTO Ventas (id_producto, id_sabor, id_forma_pago, fecha, id_sucursal) VALUES
(1, 1, 1, '2023-01-01', 1),
(1, 2, 1, '2023-01-02', 1),
(2, 1, 2, '2023-01-03', 2),
(2, 3, 3, '2023-01-04', 2),
(3, 2, 1, '2023-01-05', 3),
(3, 1, 2, '2023-01-06', 3),
(4, 1, 1, '2023-01-07', 4),
(4, 3, 3, '2023-01-08', 4),
(5, 1, 2, '2023-01-09', 5),
(5, 2, 3, '2023-01-10', 5),
(4, 2, 1, '2023-01-11', 4),
(1, 3, 2, '2023-01-12', 3),
(1, 1, 1, '2023-01-13', 2),
(2, 2, 3, '2023-01-14', 4),
(1, 1, 2, '2023-01-15', 4),
(4, 3, 1, '2023-01-16', 1),
(1, 2, 3, '2023-01-17', 1),
(5, 1, 1, '2023-01-18', 5),
(2, 3, 2, '2023-01-19', 2),
(2, 1, 3, '2023-01-20', 2),
(3, 2, 1, '2023-01-21', 3),
(1, 3, 3, '2023-01-22', 1),
(4, 1, 2, '2023-01-23', 1),
(4, 2, 1, '2023-01-24', 4),
(5, 3, 1, '2023-01-25', 5),
(1, 1, 2, '2023-01-26', 5);

-- Tabla Ingresos
INSERT INTO Ingresos (monto, mes, año, id_sucursal) VALUES
(15000.0, 1, 2024, 1),
(20000.0, 1, 2024, 2),
(18000.0, 1, 2024, 3),
(22000.0, 1, 2024, 4),
(25000.0, 1, 2024, 5);

-- Tabla Egresos
INSERT INTO Egresos (monto, mes, año, id_sucursal) VALUES
(5000.0, 1, 2024, 1),
(7000.0, 1, 2024, 2),
(6000.0, 1, 2024, 3),
(8000.0, 1, 2024, 4),
(9000.0, 1, 2024, 5);
