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