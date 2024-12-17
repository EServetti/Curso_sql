create schema if not exists heladerias_servetti;
use heladerias_servetti; 

CREATE TABLE Provincias (
    id_provincia INT PRIMARY KEY AUTO_INCREMENT,
    nombre_provincia VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE Ciudades (
    id_ciudad INT PRIMARY KEY AUTO_INCREMENT,
    nombre_ciudad VARCHAR(30) UNIQUE NOT NULL,
    id_provincia INT NOT NULL,
    FOREIGN KEY (id_provincia) REFERENCES Provincias(id_provincia)
);

CREATE TABLE Fabricas (
    id_fabrica INT PRIMARY KEY AUTO_INCREMENT,
    id_ciudad INT NOT NULL,
    FOREIGN KEY (id_ciudad) REFERENCES Ciudades(id_ciudad)
);

CREATE TABLE Gerentes (
    dni_gerente INT PRIMARY KEY NOT NULL,
    nombre_gerente VARCHAR(25),
    edad_gerente INT NOT NULL
);

CREATE TABLE Sucursales (
    id_sucursal INT PRIMARY KEY AUTO_INCREMENT,
    fecha_apertura VARCHAR(15),
    id_fabrica INT NOT NULL,
    FOREIGN KEY (id_fabrica) REFERENCES Fabricas(id_fabrica),
    id_ciudad INT NOT NULL,
    FOREIGN KEY (id_ciudad) REFERENCES Ciudades(id_ciudad),
    dni_gerente INT NOT NULL,
    FOREIGN KEY (dni_gerente) REFERENCES Gerentes(dni_gerente)
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
    FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id_sucursal),
    UNIQUE (mes, año, id_sucursal)
);
