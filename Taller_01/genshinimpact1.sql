#CREATE DATABASE genshinimpact1;
USE genshinimpact1;

/*CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    nivel_aventura INT NOT NULL,
    region ENUM('mondstadt', 'liyue', 'inazuma', 'sumeru', 'fontaine', 'natlan', 'snezhnaya') NOT NULL
);

CREATE TABLE personajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    nivel INT NOT NULL,
    elemento ENUM('anemo', 'geo', 'electro', 'dendro', 'hydro', 'pyro', 'cryo') NOT NULL,
    rareza ENUM('4 estrellas', '5 estrellas') NOT NULL,
    usuario_id INT NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE armas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    tipo ENUM('espada', 'mandoble', 'arco', 'catalizador', 'lanza') NOT NULL,
    rareza ENUM('3 estrellas', '4 estrellas', '5 estrellas') NOT NULL,
    ataque_base INT NOT NULL,
    personaje_id INT,
    FOREIGN KEY (personaje_id) REFERENCES personajes(id)
);

-- Crear la tabla artefactos
CREATE TABLE artefactos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    rareza ENUM('3 estrellas', '4 estrellas', '5 estrellas') NOT NULL,
    estadistica_principal VARCHAR(30) NOT NULL,
    personaje_id INT,
    FOREIGN KEY (personaje_id) REFERENCES personajes(id)
);

CREATE TABLE misiones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    tipo ENUM('Historia', 'Evento', 'Comisión Diaria', 'Dominio') NOT NULL,
    recompensa VARCHAR(50) NOT NULL
);

CREATE TABLE misiones_personajes (
    mision_id INT,
    personaje_id INT,
    PRIMARY KEY (mision_id, personaje_id),
    FOREIGN KEY (mision_id) REFERENCES misiones(id),
    FOREIGN KEY (personaje_id) REFERENCES personajes(id)
);*/

/*INSERT INTO usuarios (nombre, nivel_aventura, region) 
VALUES 
('Aether', 55, 'mondstadt'),
('Lumine', 60, 'liyue');

INSERT INTO personajes (nombre, nivel, elemento, rareza, usuario_id) 
VALUES 
('Diluc', 80, 'pyro', '5 estrellas', 1),
('Keqing', 75, 'electro', '5 estrellas', 2),
('Xiangling', 70, 'pyro', '4 estrellas', 1);

INSERT INTO armas (nombre, tipo, rareza, ataque_base, personaje_id) 
VALUES 
('Espada del Alba', 'espada', '5 estrellas', 48, 1),
('Prototipo Rencor', 'lanza', '4 estrellas', 42, 3);

INSERT INTO artefactos (nombre, rareza, estadistica_principal, personaje_id) 
VALUES 
('Copa de Crimson Witch', '5 estrellas', 'Daño Pyro', 1),
('Pluma de la Resistencia', '4 estrellas', 'ATQ', 3);

INSERT INTO misiones (nombre, tipo, recompensa) 
VALUES 
('La leyenda de Vennessa', 'Historia', 'Protogemas x 60'),
('El banquete de los héroes', 'Evento', 'Mora x 50000');

/*SELECT p.nombre, p.nivel, p.elemento, p.rareza
FROM personajes p
JOIN usuarios u ON p.usuario_id = u.id
WHERE u.nombre = 'Aether';*/

SELECT m.nombre AS mision, m.tipo, m.recompensa
FROM misiones_personajes mp
JOIN misiones m ON mp.mision_id = m.id
JOIN personajes p ON mp.personaje_id = p.id
WHERE p.nombre = 'Diluc';