CREATE DATABASE IF NOT EXISTS ReservasCanchas;
USE ReservasCanchas;

-- Tabla de Usuarios
CREATE TABLE Usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
    perfil ENUM('Jugador', 'Dueño', 'Administrador') NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    ultimo_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    es_dueño BOOLEAN DEFAULT FALSE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Establecimientos
CREATE TABLE Establecimientos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(255) NOT NULL,
    numero_canchas INT NOT NULL CHECK (numero_canchas >= 1),
    dueño_id INT NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    capacidad INT NOT NULL CHECK (capacidad > 0),
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dueño_id) REFERENCES Usuarios(id)
);

-- Tabla de Canchas
CREATE TABLE Canchas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tarifa DECIMAL(10,2) NOT NULL CHECK (tarifa >= 0),
    capacidad INT NOT NULL CHECK (capacidad > 0),
    establecimiento_id INT NOT NULL,
    estado ENUM('Disponible', 'Mantenimiento') DEFAULT 'Disponible',
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (establecimiento_id) REFERENCES Establecimientos(id)
);

-- Tabla de Deportes
CREATE TABLE Deportes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    imagen VARCHAR(255) DEFAULT NULL,
    icono VARCHAR(255) DEFAULT NULL,
    clasificacion ENUM('Aficionado', 'Profesional', 'Infantil') NOT NULL,
    cancha_id INT NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cancha_id) REFERENCES Canchas(id)
);

-- Tabla de Deportes Favoritos
CREATE TABLE DeportesFavoritos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    deporte_id INT NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
    FOREIGN KEY (deporte_id) REFERENCES Deportes(id)
);

-- Tabla de Métodos de Pago
CREATE TABLE FormasPago (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    usuario_id INT NOT NULL,
    establecimiento_id INT NOT NULL,
    cancha_id INT NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
    FOREIGN KEY (establecimiento_id) REFERENCES Establecimientos(id),
    FOREIGN KEY (cancha_id) REFERENCES Canchas(id)
);

-- 1. Crear un establecimiento con su cancha

INSERT INTO Usuarios (nombre, username, contraseña, perfil, correo, es_dueño)
VALUES ('Ian Hylton', 'ianh', '8-995-1338', 'Dueño', 'ianh@gmail.com', TRUE);

INSERT INTO Establecimientos (nombre, ubicacion, numero_canchas, dueño_id, telefono, capacidad)
VALUES ('Espartaco Sport Panamá', 'Via Brasil', 1, 1, '123456789', 1000);

INSERT INTO Canchas (nombre, tarifa, capacidad, establecimiento_id, estado)
VALUES ('ESP1', 90.21, 200, 1, 'Disponible');

-- 2. Crear y consultar usuarios

INSERT INTO Usuarios (nombre, username, contraseña, perfil, correo)
VALUES ('Roberto Zhong', 'roberth', 'pasapasa123', 'Jugador', 'roberth@outlook.com');

SELECT * FROM Usuarios;

-- 3. Crear y modificar un deporte

INSERT INTO Deportes (nombre, tipo, imagen, icono, clasificacion, cancha_id)
VALUES ('Fútbol', 'Colectivo', 'https://espartacopty.com/pprassets/image.jpg', 'https://espartacopty.com/pprassets/icon.png', 'Profesional', 1);

UPDATE Deportes SET clasificacion = 'Aficionado' WHERE nombre = 'Futbol';

-- 4. Asignar un usuario a un establecimiento con su deporte y cancha

INSERT INTO DeportesFavoritos (usuario_id, deporte_id, descripcion)
VALUES (2, 1, 'i like balls');

SELECT * FROM DeportesFavoritos;

-- 5. Agregar y consultar el uso de un deporte favorito

INSERT INTO DeportesFavoritos (usuario_id, deporte_id, descripcion)
VALUES (2, 1, 'i like balls.');

SELECT u.nombre, d.nombre AS deporte, df.descripcion
FROM DeportesFavoritos df
JOIN Usuarios u ON df.usuario_id = u.id
JOIN Deportes d ON df.deporte_id = d.id;

-- 6. Realizar y consultar el pago de una cancha

INSERT INTO FormasPago (nombre, usuario_id, establecimiento_id, cancha_id)
VALUES ('Tarjeta de Crédito o Débito', 2, 1, 1);

SELECT * FROM FormasPago;