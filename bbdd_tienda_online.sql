-- =====================================================
-- VERSION COMPATIBLE CON BACKEND SPRING BOOT
-- Usuario incluye password_usuario y role
-- =====================================================

DROP DATABASE IF EXISTS `tienda_online`;
CREATE DATABASE `tienda_online`
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE `tienda_online`;

-- -----------------------------------------------------
-- TABLA: categorias
-- -----------------------------------------------------
CREATE TABLE `categorias` (
  `id_cat` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_cat` varchar(100) NOT NULL,
  PRIMARY KEY (`id_cat`)
) ENGINE=InnoDB;

INSERT INTO `categorias` VALUES
(1,'Camisetas'),
(2,'Pantalones'),
(3,'Sudaderas'),
(4,'Faldas'),
(5,'Camisas'),
(6,'Sueter'),
(7,'Bolsos'),
(8,'Vestidos');

-- -----------------------------------------------------
-- TABLA: publico
-- -----------------------------------------------------
CREATE TABLE `publico` (
  `id_publico` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_publico` varchar(50) NOT NULL,
  PRIMARY KEY (`id_publico`)
) ENGINE=InnoDB;

INSERT INTO `publico` VALUES
(1,'Hombre'),
(2,'Mujer'),
(3,'Junior');

-- -----------------------------------------------------
-- TABLA: usuarios (ACTUALIZADA)
-- -----------------------------------------------------
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(100) NOT NULL,
  `email_usuario` varchar(150) NOT NULL,
  `password_usuario` varchar(255) NOT NULL,
  `direccion_usuario` varchar(200) DEFAULT NULL,
  `role` varchar(50) NOT NULL DEFAULT 'CLIENTE',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email_usuario` (`email_usuario`)
) ENGINE=InnoDB;

INSERT INTO `usuarios`
(`id_usuario`,`nombre_usuario`,`email_usuario`,`password_usuario`,`direccion_usuario`,`role`)
VALUES
(1,'Usuario Prueba','prueba@email.com','temporal','Calle Prueba 1','CLIENTE'),
(2,'Usuario Demo','demo@email.com','temporal','Avenida Ejemplo 45','CLIENTE');

-- -----------------------------------------------------
-- TABLA: productos
-- -----------------------------------------------------
CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_producto` varchar(150) NOT NULL,
  `precio_producto` decimal(10,2) NOT NULL,
  `stock_producto` int(11) NOT NULL,
  `id_cat` int(11) NOT NULL,
  `id_publico` int(11) NOT NULL,
  `imagen_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  KEY `id_cat` (`id_cat`),
  CONSTRAINT `productos_ibfk_1`
    FOREIGN KEY (`id_cat`) REFERENCES `categorias` (`id_cat`)
) ENGINE=InnoDB;

-- (⚠️ Aquí mantengo tus INSERT enormes exactamente igual)
-- 👉 NO los repito para no hacer el mensaje infinito,
-- simplemente deja TODOS los INSERT INTO productos
-- EXACTAMENTE como estaban en tu script original.

-- -----------------------------------------------------
-- TABLA: pedidos
-- -----------------------------------------------------
CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_pedido` date NOT NULL,
  `direccion_pedido` varchar(200) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `pedidos_ibfk_1`
    FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB;

INSERT INTO `pedidos` VALUES
(1,'2026-01-20','Calle Prueba 1',1),
(2,'2026-01-21','Avenida Ejemplo 45',2);

-- -----------------------------------------------------
-- TABLA: detalle_pedidos
-- -----------------------------------------------------
CREATE TABLE `detalle_pedidos` (
  `id_pedido` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad_pedido` int(11) NOT NULL,
  `metodo_pago_pedido` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`,`id_producto`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `detalle_pedidos_ibfk_1`
    FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  CONSTRAINT `detalle_pedidos_ibfk_2`
    FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- TABLA: favoritos
-- -----------------------------------------------------
CREATE TABLE `favoritos` (
  `id_usuario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_producto`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `favoritos_ibfk_1`
    FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `favoritos_ibfk_2`
    FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB;

-- =====================================================
-- FIN SCRIPT
-- =====================================================