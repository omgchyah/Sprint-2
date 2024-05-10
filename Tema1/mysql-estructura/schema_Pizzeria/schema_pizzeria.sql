DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

-- Tabla para la tienda
CREATE TABLE tienda (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(60) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    localidad VARCHAR(20) NOT NULL,
    provincia VARCHAR(20) NOT NULL
    );
    
-- Tabla para empleados
CREATE TABLE empleado (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('cocinero', 'repartidor'),
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    nif VARCHAR(9) NOT NULL,
    telefono INT(9) NOT NULL,
    id_tienda INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_tienda) REFERENCES tienda(id)
);

CREATE TABLE cliente (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    direccion VARCHAR(60) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    localidad VARCHAR(60) NOT NULL,
    provincia VARCHAR(20) NOT NULL,
    telefono INT(9) NOT NULL
);

-- Tabla para pedidos, un cliente puede tener varios pedidos
CREATE TABLE pedido (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT UNSIGNED NOT NULL,
    fecha_hora_entrega DATETIME NOT NULL,
    tipo_entrega ENUM('A domicilio', 'Recogida en tienda') NOT NULL,
	id_repartidor INT UNSIGNED NULL,
	precio_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    FOREIGN KEY (id_repartidor) REFERENCES empleado(id)
    -- CONSTRAINT chk_repartidor_required CHECK (tipo_entrega = 'A domicilio' AND id_repartidor IS NOT NULL)
);

-- Tabla para tipos de pizza
CREATE TABLE pizza (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(60),
    descripcion VARCHAR(100),
    fecha_cambio DATE
);

-- Tabla para productos (hamburguesa, pizza, bebida)
CREATE TABLE producto (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('pizza', 'hamburguesa', 'bebida') NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    imagen BLOB NOT NULL,
    precio INT NOT NULL,
    id_pedido INT UNSIGNED NOT NULL,
    id_pizza INT UNSIGNED NULL,
    FOREIGN KEY (id_pizza) REFERENCES pizza(id),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id)
);


/*-- Tabla para definir que producto y cantidad por cada pedido (eliminado para simplificar)
-- Al final he usado la tabla de producto para definir la cantidad de productos por pedido
CREATE TABLE pedido_lista_productos (
    id_pedido INT UNSIGNED,
    id_tipo_producto INT UNSIGNED,
    cantidad INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_pedido, id_tipo_producto),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id),
    FOREIGN KEY (id_tipo_producto) REFERENCES tipo_producto(id)
);*/


INSERT INTO tienda (direccion, codigo_postal, localidad, provincia) 
VALUES 
    ('Calle Mayor, 1', '28001', 'Madrid', 'Madrid'),
    ('Calle Gran Vía, 25', '08001', 'Barcelona', 'Barcelona'),
    ('Calle Real, 15', '41001', 'Sevilla', 'Sevilla');

INSERT INTO empleado (tipo, nombre, apellidos, nif, telefono, id_tienda)
VALUES 
    ('cocinero', 'Juan', 'García', '12345678A', 666555444, 1),
    ('repartidor', 'Pedro', 'Martínez', '87654321B', 677888999, 2),
    ('repartidor', 'Ana', 'López', '11223344C', 688777999, 3);
    
-- Inserting values into the cliente table
INSERT INTO cliente (nombre, apellidos, direccion, codigo_postal, localidad, provincia, telefono)
VALUES
    ('Alexia', 'Rossi', 'Rambla Catalunya, 34', '08007', 'Barcelona', 'Barcelona', 112233445),
	('Marco', 'Verdi', 'Gran Vía, 78', '28013', 'Madrid', 'Madrid', 678901234);

INSERT INTO pedido (id_cliente, fecha_hora_entrega, tipo_entrega, id_repartidor, precio_total)
VALUES (1, '2024-05-11 13:00:00', 'A domicilio', 2, 22.50),
       (2, '2024-05-10 20:00:00', 'Recogida en tienda', NULL, 18.75);

INSERT INTO pizza (categoria, descripcion, fecha_cambio)
VALUES ('Italiana', 'Pizza con mozzarella, tomate y albahaca fresca', '2024-05-09'),
       ('Americana', 'Pizza con pepperoni, champiñones y pimiento verde', '2024-05-10');

-- Pizza
INSERT INTO producto (tipo, descripcion, imagen, precio, id_pedido, id_pizza)
VALUES ('pizza', 'Pizza italiana mediana', 'pizza_italiana.jpg', 18.50, 1, 1),
		('hamburguesa', 'Hamburguesa con queso y bacon', 'hamburguesa_con_queso.jpg', 12.00, 2, NULL),
		('bebida', 'Refresco de cola 33cl', 'refresco_cola.jpg', 2.00, 1, NULL),
		('bebida', 'Cerveza rubia 33cl', 'cerveza_rubia.jpg', 2.50, 2, NULL);
