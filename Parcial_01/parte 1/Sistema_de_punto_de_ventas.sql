CREATE DATABASE IF NOT EXISTS Sistema_de_punto_de_ventas;

USE Sistema_de_punto_de_ventas;

CREATE TABLE provincias (
    codpro INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    region ENUM('Norte', 'Sur', 'Este', 'Oeste') NOT NULL,
    capital VARCHAR(50) UNIQUE
);

CREATE TABLE pueblos (
    codpue INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    codpro INT NOT NULL,
    tipo_pueblo ENUM('Urbano', 'Rural', 'Turístico') NOT NULL,
    poblacion INT,
    FOREIGN KEY (codpro) REFERENCES provincias(codpro)
);

CREATE TABLE articulos (
    codart INT PRIMARY KEY AUTO_INCREMENT,
    descrip VARCHAR(50) NOT NULL,
    precio FLOAT NOT NULL,
    stock INT NOT NULL,
    stock_min INT NOT NULL,
    dto FLOAT NOT NULL,
    tipo_lista ENUM('Electrónico', 'Ropa', 'Alimentos', 'Hogar') NOT NULL,
    activo ENUM('Si' , 'No') NOT NULL
);

CREATE TABLE clientes (
    codcli INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    codpostal VARCHAR(30) NOT NULL,
    codpue INT NOT NULL,
    tipo_cliente ENUM('Regular', 'VIP', 'Mayorista') NOT NULL,
    correo_electronico VARCHAR(50) UNIQUE,
    FOREIGN KEY (codpue) REFERENCES pueblos(codpue)
);

CREATE TABLE vendedores (
    codven INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    codpostal VARCHAR(30) NOT NULL,
    codpue INT NOT NULL,
    codjefe INT DEFAULT NULL,
    tipo_contrato ENUM('Tiempo completo', 'Medio tiempo', 'Temporal') NOT NULL,
    activo ENUM('Si' , 'No') NOT NULL,
    FOREIGN KEY (codpue) REFERENCES pueblos(codpue),
    FOREIGN KEY (codjefe) REFERENCES vendedores(codven)
);

CREATE TABLE facturas (
    codfac INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    codcli INT NOT NULL,
    codven INT NOT NULL,
    iva FLOAT NOT NULL,
    dto FLOAT NOT NULL,
    estado ENUM('Pagada', 'Pendiente', 'Cancelada') NOT NULL,
    metodo_pago ENUM('Efectivo', 'Tarjeta de crédito', 'Transferencia bancaria', 'Tarjeta de débito', 'Yappy') NOT NULL,
    FOREIGN KEY (codcli) REFERENCES clientes(codcli),
    FOREIGN KEY (codven) REFERENCES vendedores(codven)
);

CREATE TABLE lineas_fac (
    codfac INT NOT NULL,
    linea INT NOT NULL,
    cant INT NOT NULL,
    codart INT NOT NULL,
    dto FLOAT NOT NULL,
    precio FLOAT NOT NULL,
    tipo_descuento ENUM('Promoción', 'Cliente frecuente', 'Ninguno', 'Venta especial', 'Cliente VIP') NOT NULL,
    PRIMARY KEY (codfac, linea),
    FOREIGN KEY (codfac) REFERENCES facturas(codfac),
    FOREIGN KEY (codart) REFERENCES articulos(codart)
);

INSERT INTO provincias (codpro, nombre, region, capital) VALUES
(101, 'Buenos Aires', 'Norte', 'La Plata'),
(102, 'Córdoba', 'Este', 'Córdoba'),
(103, 'Santa Fe', 'Norte', 'Santa Fe'),
(104, 'Mendoza', 'Oeste', 'Mendoza'),
(105, 'Salta', 'Sur', 'Salta');

INSERT INTO pueblos (codpue, nombre, codpro, tipo_pueblo, poblacion) VALUES
(201, 'Mar del Plata', 101, 'Urbano', 650000),
(202, 'Villa Carlos Paz', 102, 'Turístico', 75000),
(203, 'Rosario', 103, 'Urbano', 1200000),
(204, 'San Rafael', 104, 'Rural', 200000),
(205, 'Cafayate', 105, 'Turístico', 15000);

INSERT INTO clientes (codcli, nombre, direccion, codpostal, codpue, tipo_cliente, correo_electronico) VALUES
(301, 'Juan Pérez', 'Calle Falsa 123', '7600', 201, 'Regular', 'juan.perez@example.com'),
(302, 'María López', 'Av. Libertador 456', '5152', 202, 'VIP', 'maria.lopez@example.com'),
(303, 'Carlos Gómez', 'San Martín 789', '2000', 203, 'Mayorista', 'carlos.gomez@example.com'),
(304, 'Lucía Fernández', 'Mitre 321', '5600', 204, 'Regular', 'lucia.fernandez@example.com'),
(305, 'Roberto Díaz', 'Belgrano 654', '4427', 205, 'VIP', 'roberto.diaz@example.com');

INSERT INTO vendedores (codven, nombre, direccion, codpostal, codpue, codjefe, tipo_contrato, activo) VALUES
(401, 'Ana Torres', 'Calle 10', '7600', 201, NULL, 'Tiempo completo', 'Si'),
(402, 'José Martínez', 'Calle 20', '5152', 202, 401, 'Medio tiempo', 'Si'),
(403, 'Laura Castillo', 'Calle 30', '2000', 203, 401, 'Temporal', 'Si'),
(404, 'Pedro Ramírez', 'Calle 40', '5600', 204, 402, 'Tiempo completo', 'Si'),
(405, 'Sofía Herrera', 'Calle 50', '4427', 205, 402, 'Medio tiempo', 'Si');

INSERT INTO articulos (codart, descrip, precio, stock, stock_min, dto, tipo_lista, activo) VALUES
(501, 'Redmi note 12 pro', 199.99, 100, 10, 20, 'Electrónico', 'Si'),
(502, 'Camisa blanca', 29.99, 100, 10, 5, 'Ropa', 'Si'),
(503, 'Arroz primera 5LB', 2.00, 500, 50, 0, 'Alimentos', 'Si'),
(504, 'Cama', 499.99, 20, 2, 15, 'Hogar', 'Si'),
(505, 'Laptop Dell Inspiron 15', 899.99, 30, 3, 5, 'Electrónico', 'Si');

INSERT INTO facturas (codfac, fecha, codcli, codven, iva, dto, estado, metodo_pago) VALUES
(601, '2024-02-01', 301, 401, 21, 5, 'Pagada', 'Tarjeta de crédito'),
(602, '2024-02-02', 302, 402, 21, 10, 'Pendiente', 'Transferencia bancaria'),
(603, '2024-02-03', 303, 403, 21, 0, 'Cancelada', 'Efectivo'),
(604, '2024-02-04', 304, 404, 21, 15, 'Pagada', 'Tarjeta de débito'),
(605, '2024-02-05', 305, 405, 21, 5, 'Pendiente', 'Yappy');

INSERT INTO lineas_fac (codfac, linea, cant, codart, dto, precio, tipo_descuento) VALUES
(601, 1, 1, 501, 5, 799.99, 'Cliente VIP'),
(602, 1, 2, 502, 10, 29.99, 'Promoción'),
(603, 1, 5, 503, 0, 3.50, 'Ninguno'),
(604, 1, 1, 504, 15, 499.99, 'Venta especial'),
(605, 1, 1, 505, 5, 899.99, 'Cliente frecuente');
