-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: tienda_online
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `tienda_online`
--

/*!40000 DROP DATABASE IF EXISTS `tienda_online`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tienda_online` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `tienda_online`;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias` (
  `id_cat` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_cat` varchar(100) NOT NULL,
  PRIMARY KEY (`id_cat`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Camisetas'),(2,'Pantalones'),(3,'Sudaderas'),(4,'Faldas'),(5,'Camisas'),(6,'Sueter'),(7,'Bolsos'),(8,'vestidos');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_pedidos`
--

DROP TABLE IF EXISTS `detalle_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle_pedidos` (
  `id_pedido` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad_pedido` int(11) NOT NULL,
  `metodo_pago_pedido` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`,`id_producto`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `detalle_pedidos_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  CONSTRAINT `detalle_pedidos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_pedidos`
--

LOCK TABLES `detalle_pedidos` WRITE;
/*!40000 ALTER TABLE `detalle_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favoritos`
--

DROP TABLE IF EXISTS `favoritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favoritos` (
  `id_usuario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_producto`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritos`
--

LOCK TABLES `favoritos` WRITE;
/*!40000 ALTER TABLE `favoritos` DISABLE KEYS */;
/*!40000 ALTER TABLE `favoritos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_pedido` date NOT NULL,
  `direccion_pedido` varchar(200) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,'2026-01-20','Calle Prueba 1',1),(2,'2026-01-21','Avenida Ejemplo 45',2);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_cat`) REFERENCES `categorias` (`id_cat`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (3,'Vestido Woodbine',49.99,20,8,2,'http://localhost:9008/img/mujer_vestido_1.jpg'),(4,'Vestido Coeli',49.99,20,8,2,'http://localhost:9008/img/mujer_vestido_2.jpg'),(5,'Tribal Otoño',49.99,20,8,2,'http://localhost:9008/img/mujer_vestido_3.jpg'),(6,'Flora',64.00,20,8,2,'http://localhost:9008/img/mujer_vestido_4.jpg'),(7,'Sonne',49.00,20,8,2,'http://localhost:9008/img/mujer_vestido_5.jpg'),(8,'Spring',79.99,20,8,2,'http://localhost:9008/img/mujer_vestido_6.jpg'),(9,'Venetzia',59.99,20,8,2,'http://localhost:9008/img/mujer_vestido_7.jpg'),(10,'Altair',79.99,20,8,2,'http://localhost:9008/img/mujer_vestido_8.jpg'),(11,'Setareh',59.99,20,4,2,'http://localhost:9008/img/mujer_falda_1.jpg'),(12,'Roya',45.55,20,4,2,'http://localhost:9008/img/mujer_falda_2.jpg'),(13,'Nazrin',29.99,20,4,2,'http://localhost:9008/img/mujer_falda_4.jpg'),(14,'Helka',30.25,20,4,2,'http://localhost:9008/img/mujer_falda_3.jpg'),(15,'Prisa',29.99,20,4,2,'http://localhost:9008/img/mujer_falda_5.jpg'),(16,'Carolingia',30.25,20,4,2,'http://localhost:9008/img/mujer_falda_7.jpg'),(17,'Bahar',59.99,20,4,2,'http://localhost:9008/img/mujer_falda_6.jpg'),(18,'Shirin',29.99,20,4,2,'http://localhost:9008/img/mujer_falda_8.jpg'),(27,'Vlaad Bird',19.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_1.jpg'),(29,'Symbols',24.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_3.jpg'),(30,'VLDSP',29.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_4.jpg'),(31,'Abril',29.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_5.jpg'),(32,'Magius',34.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_6.jpg'),(33,'Larache',29.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_7.jpg'),(34,'Romantique',34.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_8.jpg'),(35,'Marina',24.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_2.jpg'),(36,'Solera',49.99,20,2,1,'http://localhost:9008/img/hombre_pantalon_1.jpg'),(37,'Vldsp',49.99,20,2,1,'http://localhost:9008/img/hombre_pantalon_2.jpg'),(38,'Hudson',59.99,20,2,1,'http://localhost:9008/img/hombre_pantalon_3.jpg'),(39,'Antequera',49.99,20,2,1,'http://localhost:9008/img/hombre_pantalon_4.jpg'),(40,'Neon',49.99,20,2,1,'http://localhost:9008/img/hombre_pantalon_5.jpg'),(41,'Skinny Puppy',34.99,20,2,1,'http://localhost:9008/img/hombre_pantalon_6.jpg'),(42,'Gradas',45.55,20,2,1,'http://localhost:9008/img/hombre_pantalon_7.jpg'),(43,'Maestre',79.99,20,2,1,'http://localhost:9008/img/hombre_pantalon_8.jpg'),(44,'VladdESP',39.99,20,3,1,'http://localhost:9008/img/hombre_sudadera_1.jpg'),(45,'Bones',45.55,20,3,1,'http://localhost:9008/img/hombre_sudadera_2.jpg'),(46,'Japan',59.99,20,3,1,'http://localhost:9008/img/hombre_sudadera_3.jpg'),(47,'DAW',39.99,20,3,1,'http://localhost:9008/img/hombre_sudadera_4.jpg'),(48,'80s',45.55,20,3,1,'http://localhost:9008/img/hombre_sudadera_5.jpg'),(49,'Grid',39.99,20,3,1,'http://localhost:9008/img/hombre_sudadera_6.jpg'),(50,'Nirvana',44.99,20,3,1,'http://localhost:9008/img/hombre_sudadera_7.jpg'),(51,'Nostromo',59.99,20,3,1,'http://localhost:9008/img/hombre_sudadera_8.jpg'),(52,'Nápoles',45.55,20,5,1,'http://localhost:9008/img/hombre_camisa_1.jpg'),(53,'Velázquez',49.99,20,5,1,'http://localhost:9008/img/hombre_camisa_2.jpg'),(54,'Thomas',47.99,20,5,1,'http://localhost:9008/img/hombre_camisa_3.jpg'),(55,'Bleach Sand',59.99,20,5,1,'http://localhost:9008/img/hombre_camisa_4.jpg'),(56,'Martial',39.99,20,5,1,'http://localhost:9008/img/hombre_camisa_5.jpg'),(57,'Tokyo',49.99,20,5,1,'http://localhost:9008/img/hombre_camisa_6.jpg'),(58,'Alaska',65.55,20,5,1,'http://localhost:9008/img/hombre_camisa_7.jpg'),(59,'Sorrentino',59.99,20,5,1,'http://localhost:9008/img/hombre_camisa_8.jpg'),(60,'The Cramps',59.99,20,5,2,'http://localhost:9008/img/mujer_camisa_1.jpg'),(61,'Jaifa',65.55,20,5,2,'http://localhost:9008/img/mujer_camisa_2.jpg'),(62,'Katya',59.45,20,5,2,'http://localhost:9008/img/mujer_camisa_3.jpg'),(63,'Harlem',39.99,20,5,2,'http://localhost:9008/img/mujer_camisa_4.jpg'),(64,'Vesna',46.25,20,5,2,'http://localhost:9008/img/mujer_camisa_5.jpg'),(65,'Vlaad Les',38.55,20,5,2,'http://localhost:9008/img/mujer_camisa_6.jpg'),(66,'Boletus',59.99,20,5,2,'http://localhost:9008/img/mujer_camisa_7.jpg'),(67,'Dakota',63.25,20,5,2,'http://localhost:9008/img/mujer_camisa_8.jpg'),(68,'Vlaadcrin 70s',65.25,20,2,2,'http://localhost:9008/img/mujer_pantalon_1.jpg'),(69,'Oblast',45.55,20,2,2,'http://localhost:9008/img/mujer_pantalon_2.jpg'),(70,'Peggy',68.25,20,2,2,'http://localhost:9008/img/mujer_pantalon_3.jpg'),(71,'Boreal',59.99,20,2,2,'http://localhost:9008/img/mujer_pantalon_4.jpg'),(72,'Chicago',63.25,20,2,2,'http://localhost:9008/img/mujer_pantalon_5.jpg'),(73,'Shoreline Gold',79.99,20,2,2,'http://localhost:9008/img/mujer_pantalon_7.jpg'),(74,'Pompeya',68.55,20,2,2,'http://localhost:9008/img/mujer_pantalon_8.jpg'),(75,'Mahnaz',75.55,20,2,2,'http://localhost:9008/img/mujer_pantalon_6.jpg'),(76,'Polar Vlaad',75.55,20,6,2,'http://localhost:9008/img/mujer_sueter_1.jpg'),(78,'Oliv',65.55,20,6,2,'http://localhost:9008/img/mujer_sueter_3.jpg'),(79,'Carmen',59.99,20,6,2,'http://localhost:9008/img/mujer_sueter_4.jpg'),(81,'Crystal',68.45,20,6,2,'http://localhost:9008/img/mujer_sueter_6.jpg'),(82,'Aachen',49.99,20,6,2,'http://localhost:9008/img/mujer_sueter_7.jpg'),(83,'Wintertalk',74.45,20,6,2,'http://localhost:9008/img/mujer_sueter_8.jpg'),(86,'Sunny Day',39.99,20,6,2,'http://localhost:9008/img/mujer_sueter_12.jpg'),(87,'Primavera',65.55,20,6,2,'http://localhost:9008/img/mujer_sueter_5.jpg');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publico`
--

DROP TABLE IF EXISTS `publico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publico` (
  `id_publico` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_publico` varchar(50) NOT NULL,
  PRIMARY KEY (`id_publico`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publico`
--

LOCK TABLES `publico` WRITE;
/*!40000 ALTER TABLE `publico` DISABLE KEYS */;
INSERT INTO `publico` VALUES (1,'Hombre'),(2,'Mujer'),(3,'Junior');
/*!40000 ALTER TABLE `publico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(100) NOT NULL,
  `email_usuario` varchar(150) NOT NULL,
  `direccion_usuario` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email_usuario` (`email_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Usuario Prueba','prueba@email.com','Calle Prueba 1'),(2,'Usuario Demo','demo@email.com','Avenida Ejemplo 45');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-28 12:42:29
