DROP DATABASE IF EXISTS ventasdecoches;
CREATE DATABASE ventasdecoches;
USE ventasdecoches;

CREATE TABLE coches (
    idCoche INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    VIN VARCHAR (50),
    fabricante VARCHAR(50),
    modelo VARCHAR(50),
    anio MEDIUMINT,
    color VARCHAR(50)
);

CREATE TABLE clientes (
    idCliente INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    IDdeCliente INT,
    nombre VARCHAR(50),
    telefono VARCHAR(50),
    email VARCHAR(50),
    direccion VARCHAR(50),
    ciudad VARCHAR(50),
    estado_provincia VARCHAR(50),
    pais VARCHAR(50),
    codigo_postal VARCHAR(50)
);
CREATE TABLE vendedores (
    idVendedor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    IDdePersonal INT,
    nombre VARCHAR(50),
    tienda VARCHAR(50)
);

CREATE TABLE facturas (
    IdFactura INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    NumFactura INT,
    Fecha DATE,
    idCoche INT,
    idCliente INT,
    idVendedor INT,
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente),
    FOREIGN KEY (idVendedor) REFERENCES vendedores(idVendedor),
    FOREIGN KEY (idCoche) REFERENCES coches(idCoche)
);

-- Insertar datos en ventasdecoches
INSERT INTO coches (idCoche, VIN, fabricante, modelo, anio, color) VALUES
(0, '3K096I98581DHSNUP', 'Volkswagen', 'Tiguan', 2019, 'Azul'),
(1, 'ZM8G7BEUQZ97IH46V', 'Peugeot', 'Rifter', 2019, 'Rojo'),
(2, 'RKXVNNIHLVVZOUB4M', 'Ford', 'Fusion', 2018, 'Blanco'),
(3, 'HKNDGS7CU31E9Z7JW', 'Toyota', 'RAV4', 2018, 'Plata'),
(4, 'DAM41UDN3CHU2WVF6', 'Volvo', 'V60', 2019, 'Gris'),
(5, 'DAM41UDN3CHU2WVF6', 'Volvo', 'V60 Cross Country', 2019, 'Gris');

SELECT * FROM coches;

INSERT INTO clientes (idCliente, IDdeCliente, nombre, telefono, email, direccion, ciudad, estado_provincia, pais, codigo_postal) VALUES
(0, 10001, 'Pablo Picasso', '+34 636 17 63 82', '-', 'Paseo de la Chopera, 14', 'Madrid', 'Madrid', 'España', '28045'),
(1, 20001, 'Abraham Lincoln', '+1 305 907 7086', '-', '120 SW 8th St', 'Miami', 'Florida', 'Estados Unidos', '33130'),
(2, 30001, 'Napoléon Bonaparte', '+33 1 79 75 40 00', '-', '40 Rue du Colisée', 'Paris', 'Île-de-France', 'Francia', '75008');

SELECT * FROM clientes;

INSERT INTO vendedores (idVendedor, IDdePersonal, nombre, tienda) VALUES
(0, 00001, 'Petey Cruiser', 'Madrid'),
(1, 00002, 'Anna Sthesia', 'Barcelona'),
(2, 00003, 'Paul Molive', 'Berlín'),
(3, 00004, 'Gail Forcewind', 'París'),
(4, 00005, 'Paige Turner', 'Mimia'),
(5, 00006, 'Bob Frapples', 'Ciudad de México'),
(6, 00007, 'Walter Melon', 'Ámsterdam'),
(7, 00008, 'Shonda Leer', 'São Paulo');

SELECT * FROM vendedores;

INSERT INTO facturas (IdFactura, NumFactura, Fecha, idCoche, idCliente, idVendedor) VALUES
(0, 852399038, '2018-08-22', 0, 1, 3),
(1, 731166526, '2018-12-31', 3, 0, 5),
(2, 271135104, '2019-01-22', 2, 2, 7);

SELECT * FROM facturas;
