-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: tconsulting
-- ------------------------------------------------------
-- Server version	5.7.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ascensos`
--

DROP TABLE IF EXISTS `ascensos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ascensos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cue` bigint(20) unsigned NOT NULL,
  `puesto_id` bigint(20) unsigned NOT NULL,
  `sueldo_id` bigint(20) unsigned NOT NULL,
  `observacion` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ascensos_cue_foreign` (`cue`),
  KEY `ascensos_puesto_id_foreign` (`puesto_id`),
  KEY `ascensos_sueldo_id_foreign` (`sueldo_id`),
  CONSTRAINT `ascensos_cue_foreign` FOREIGN KEY (`cue`) REFERENCES `empleados` (`cue`),
  CONSTRAINT `ascensos_puesto_id_foreign` FOREIGN KEY (`puesto_id`) REFERENCES `puestos` (`id`),
  CONSTRAINT `ascensos_sueldo_id_foreign` FOREIGN KEY (`sueldo_id`) REFERENCES `sueldos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ascensos`
--

LOCK TABLES `ascensos` WRITE;
/*!40000 ALTER TABLE `ascensos` DISABLE KEYS */;
INSERT INTO `ascensos` VALUES (8,14,1,1,'Contratacion','2023-10-05 03:57:37','2023-10-05 03:57:37'),(9,15,3,5,'Contratacion','2023-10-08 02:01:43','2023-10-08 02:01:43'),(10,16,3,2,'Contratacion','2023-10-08 06:52:57','2023-10-08 06:52:57'),(11,17,2,5,'Muestra aptirudes para el puesto','2023-10-11 01:10:46','2023-10-11 01:21:26'),(12,14,1,4,'Aguste de Presupuesto','2023-10-11 02:11:00','2023-10-11 02:11:00'),(13,16,3,3,'modificacion de sueldo a sueldo correcto','2023-10-19 23:58:17','2023-10-19 23:58:17'),(14,15,3,6,'Cambio de puesto','2023-10-20 17:01:59','2023-10-20 17:01:59');
/*!40000 ALTER TABLE `ascensos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bodega_usuarios`
--

DROP TABLE IF EXISTS `bodega_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bodega_usuarios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `bodega_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bodega_usuarios_bodega_id_foreign` (`bodega_id`),
  CONSTRAINT `bodega_usuarios_bodega_id_foreign` FOREIGN KEY (`bodega_id`) REFERENCES `bodegas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bodega_usuarios`
--

LOCK TABLES `bodega_usuarios` WRITE;
/*!40000 ALTER TABLE `bodega_usuarios` DISABLE KEYS */;
INSERT INTO `bodega_usuarios` VALUES (1,1,2,NULL,NULL);
/*!40000 ALTER TABLE `bodega_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bodegas`
--

DROP TABLE IF EXISTS `bodegas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bodegas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `inventario_id` bigint(20) unsigned NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bodegas_inventario_id_foreign` (`inventario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bodegas`
--

LOCK TABLES `bodegas` WRITE;
/*!40000 ALTER TABLE `bodegas` DISABLE KEYS */;
INSERT INTO `bodegas` VALUES (2,'BODEGA MAZATE',2,1,NULL,NULL);
/*!40000 ALTER TABLE `bodegas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caja_detalles`
--

DROP TABLE IF EXISTS `caja_detalles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caja_detalles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `caja_id` bigint(20) unsigned NOT NULL,
  `gestion_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `caja_detalles_caja_id_foreign` (`caja_id`),
  KEY `caja_detalles_gestion_id_foreign` (`gestion_id`),
  CONSTRAINT `caja_detalles_caja_id_foreign` FOREIGN KEY (`caja_id`) REFERENCES `cajas` (`id`),
  CONSTRAINT `caja_detalles_gestion_id_foreign` FOREIGN KEY (`gestion_id`) REFERENCES `gestiones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caja_detalles`
--

LOCK TABLES `caja_detalles` WRITE;
/*!40000 ALTER TABLE `caja_detalles` DISABLE KEYS */;
/*!40000 ALTER TABLE `caja_detalles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cajas`
--

DROP TABLE IF EXISTS `cajas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cajas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `sucursal_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cajas_sucursal_id_foreign` (`sucursal_id`),
  KEY `cajas_user_id_foreign` (`user_id`),
  CONSTRAINT `cajas_sucursal_id_foreign` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursales` (`id`),
  CONSTRAINT `cajas_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cajas`
--

LOCK TABLES `cajas` WRITE;
/*!40000 ALTER TABLE `cajas` DISABLE KEYS */;
/*!40000 ALTER TABLE `cajas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `control_accesos`
--

DROP TABLE IF EXISTS `control_accesos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `control_accesos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `sucursal_id` bigint(20) unsigned NOT NULL,
  `serie_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `control_accesos_user_id_foreign` (`user_id`),
  KEY `control_accesos_sucursal_id_foreign` (`sucursal_id`),
  KEY `control_accesos_serie_id_foreign` (`serie_id`),
  CONSTRAINT `control_accesos_serie_id_foreign` FOREIGN KEY (`serie_id`) REFERENCES `series` (`id`),
  CONSTRAINT `control_accesos_sucursal_id_foreign` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursales` (`id`),
  CONSTRAINT `control_accesos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `control_accesos`
--

LOCK TABLES `control_accesos` WRITE;
/*!40000 ALTER TABLE `control_accesos` DISABLE KEYS */;
/*!40000 ALTER TABLE `control_accesos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `descuento_empleados`
--

DROP TABLE IF EXISTS `descuento_empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `descuento_empleados` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cue` bigint(20) unsigned NOT NULL,
  `estado` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `monto` decimal(10,6) NOT NULL,
  `tipo_descuento_id` bigint(20) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `descuento_empleados_cue_foreign` (`cue`),
  KEY `descuento_empleados_tipo_descuento_id_foreign` (`tipo_descuento_id`),
  CONSTRAINT `descuento_empleados_cue_foreign` FOREIGN KEY (`cue`) REFERENCES `empleados` (`cue`),
  CONSTRAINT `descuento_empleados_tipo_descuento_id_foreign` FOREIGN KEY (`tipo_descuento_id`) REFERENCES `tipo_descuentos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `descuento_empleados`
--

LOCK TABLES `descuento_empleados` WRITE;
/*!40000 ALTER TABLE `descuento_empleados` DISABLE KEYS */;
INSERT INTO `descuento_empleados` VALUES (1,15,'PENDIENTE',14.000000,1,'2023-10-17',1,'2023-10-18 03:30:45','2023-10-18 03:30:45'),(2,15,'PENDIENTE',3.000000,1,'2023-10-17',1,'2023-10-18 04:09:18','2023-10-18 04:09:18'),(3,15,'PENDIENTE',5.000000,1,'2023-10-17',1,'2023-10-18 04:40:46','2023-10-18 04:40:46'),(4,15,'CANCELADO',-5.000000,1,'2023-10-17',1,'2023-10-18 04:42:00','2023-10-18 04:42:00'),(5,14,'PENDIENTE',10.000000,1,'2023-10-17',1,'2023-10-18 05:00:21','2023-10-18 05:00:21'),(6,14,'ANULADO',-10.000000,1,'2023-10-17',1,'2023-10-18 05:00:55','2023-10-18 05:00:55'),(10,16,'GRABADO',150.000000,2,'2023-10-19',1,'2023-10-20 00:31:46','2023-10-20 00:31:46'),(11,17,'PENDIENTE',5.000000,1,'2023-10-17',1,'2023-10-18 04:40:46','2023-10-18 04:40:46'),(12,16,'GRABADO',150.000000,2,'2023-10-20',1,'2023-10-20 20:07:32','2023-10-20 20:07:32'),(13,17,'GRABADO',150.000000,2,'2023-10-20',1,'2023-10-20 20:14:52','2023-10-20 20:14:52');
/*!40000 ALTER TABLE `descuento_empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disponible_empleados`
--

DROP TABLE IF EXISTS `disponible_empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disponible_empleados` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cue` bigint(20) unsigned NOT NULL,
  `monto` decimal(8,2) NOT NULL,
  `monto_restante` double(10,6) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `disponible_empleados_cue_foreign` (`cue`),
  CONSTRAINT `disponible_empleados_cue_foreign` FOREIGN KEY (`cue`) REFERENCES `empleados` (`cue`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disponible_empleados`
--

LOCK TABLES `disponible_empleados` WRITE;
/*!40000 ALTER TABLE `disponible_empleados` DISABLE KEYS */;
INSERT INTO `disponible_empleados` VALUES (3,14,1000.00,1000.000000,NULL,'2023-10-18 05:00:55'),(4,15,1000.00,997.000000,NULL,'2023-10-18 04:42:00');
/*!40000 ALTER TABLE `disponible_empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `cue` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre1` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `nombre2` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombre3` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `apellido1` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `apellido2` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `apellido3` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `dpi` bigint(20) DEFAULT NULL,
  `genero` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `direccion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `celular` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `estado_civil` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `correo` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `puesto_id` bigint(20) unsigned NOT NULL,
  `sueldo_id` bigint(20) unsigned NOT NULL,
  `empresa_id` bigint(20) unsigned NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`cue`),
  KEY `empleados_puesto_id_foreign` (`puesto_id`),
  KEY `empleados_sueldo_id_foreign` (`sueldo_id`),
  KEY `empleados_cue_dpi_index` (`cue`,`dpi`),
  KEY `empleados_user_id_foreign` (`user_id`),
  KEY `empresa_id_foreign` (`empresa_id`),
  CONSTRAINT `empleados_puesto_id_foreign` FOREIGN KEY (`puesto_id`) REFERENCES `puestos` (`id`),
  CONSTRAINT `empleados_sueldo_id_foreign` FOREIGN KEY (`sueldo_id`) REFERENCES `sueldos` (`id`),
  CONSTRAINT `empleados_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (14,'Rodolfo','Jonnathan',NULL,'Cal','Monzon',NULL,3389155831001,'1','1998-06-05','Mazatenango','52200147','52145232','1','rcal@gmail.com',1,4,2,1,1,'2023-10-05 03:57:37','2023-10-11 02:13:20'),(15,'Luis','Alberto',NULL,'Caal','Monzon',NULL,1258425811001,'1','1993-09-21','Suchitepequez','54521544',NULL,'1','lmonzonn@gmail.com',3,6,1,1,1,'2023-10-08 02:01:43','2023-10-20 17:01:59'),(16,'Adolfo',NULL,NULL,'Martinez','Monzon',NULL,251846131001,'1','1996-10-15','Ciudad','15242153',NULL,'1','robert@gmail.com',3,3,2,1,1,'2023-10-08 06:52:57','2023-10-19 23:58:17'),(17,'Juan','Carlos','Habel','Recincoy','Tupul',NULL,352848521001,'1','1993-10-05','Cuyotenango','5241524','52365415','2','jcarlos@gmail.com',2,5,1,1,1,'2023-10-11 01:10:46','2023-10-11 01:21:26');
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresas`
--

DROP TABLE IF EXISTS `empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas`
--

LOCK TABLES `empresas` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
INSERT INTO `empresas` VALUES (1,'Distribuidora RJ','zona 1 Mazatenango, suchitepequez',1,NULL,NULL),(2,'GYM Planet','zona 0, Mazatenango, suchitepequez',1,NULL,NULL);
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_civils`
--

DROP TABLE IF EXISTS `estado_civils`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_civils` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_civils`
--

LOCK TABLES `estado_civils` WRITE;
/*!40000 ALTER TABLE `estado_civils` DISABLE KEYS */;
INSERT INTO `estado_civils` VALUES (1,'Casado',1,NULL,NULL),(2,'Soltero',1,NULL,NULL);
/*!40000 ALTER TABLE `estado_civils` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8_spanish_ci NOT NULL,
  `queue` text COLLATE utf8_spanish_ci NOT NULL,
  `payload` longtext COLLATE utf8_spanish_ci NOT NULL,
  `exception` longtext COLLATE utf8_spanish_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `familia_empleados`
--

DROP TABLE IF EXISTS `familia_empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `familia_empleados` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre1` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `nombre2` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombre3` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `apellido1` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `apellido2` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `apellido3` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `dpi` bigint(20) DEFAULT NULL,
  `genero` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `direccion` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `celular` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `telefono` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `estado_civil` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `correo` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `tipo_familia_id` bigint(20) unsigned NOT NULL,
  `empleado_cue` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `familia_empleados_tipo_familia_id_foreign` (`tipo_familia_id`),
  KEY `familia_empleados_empleado_cue_foreign` (`empleado_cue`),
  KEY `familia_empleados_user_id_foreign` (`user_id`),
  CONSTRAINT `familia_empleados_empleado_cue_foreign` FOREIGN KEY (`empleado_cue`) REFERENCES `empleados` (`cue`),
  CONSTRAINT `familia_empleados_tipo_familia_id_foreign` FOREIGN KEY (`tipo_familia_id`) REFERENCES `tipo_familias` (`id`),
  CONSTRAINT `familia_empleados_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `familia_empleados`
--

LOCK TABLES `familia_empleados` WRITE;
/*!40000 ALTER TABLE `familia_empleados` DISABLE KEYS */;
INSERT INTO `familia_empleados` VALUES (3,'Carlos','Benjamin',NULL,'Cal','Monzon',NULL,NULL,'1','2020-01-01','Mazatenango',NULL,NULL,'2',NULL,1,14,1,'2023-10-05 03:57:37','2023-10-05 03:57:37'),(4,'Tania','Cristel',NULL,'Caal','Martinez',NULL,NULL,'2','2009-12-20','Suchitepequez','52421535',NULL,'2',NULL,1,15,1,'2023-10-08 02:01:43','2023-10-08 02:01:43'),(5,'Rodolfo','Alfredo',NULL,'Cal','Monzon',NULL,NULL,'1','2013-05-15','Suchitepequez',NULL,NULL,'2',NULL,1,15,1,'2023-10-08 02:01:43','2023-10-08 02:01:43'),(6,'Maria',NULL,NULL,'Martinez','Cobox',NULL,NULL,'2','2018-10-10',NULL,NULL,NULL,'2',NULL,1,16,1,'2023-10-08 06:52:58','2023-10-08 06:52:58'),(7,'Clara','Sarai',NULL,'Canil','Chojolan',NULL,3365854861001,'2','2003-07-13','Mazatenango','15243231',NULL,'1',NULL,2,14,1,'2023-10-08 07:15:13','2023-10-08 07:15:13');
/*!40000 ALTER TABLE `familia_empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fidelizaciones`
--

DROP TABLE IF EXISTS `fidelizaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fidelizaciones` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `valor` decimal(8,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fidelizaciones`
--

LOCK TABLES `fidelizaciones` WRITE;
/*!40000 ALTER TABLE `fidelizaciones` DISABLE KEYS */;
INSERT INTO `fidelizaciones` VALUES (1,'Descuento',0.15),(2,'Cupon',0.05),(3,'Promocion',0.10),(4,'Ninguno',0.00);
/*!40000 ALTER TABLE `fidelizaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `generos`
--

DROP TABLE IF EXISTS `generos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `generos`
--

LOCK TABLES `generos` WRITE;
/*!40000 ALTER TABLE `generos` DISABLE KEYS */;
INSERT INTO `generos` VALUES (1,'Masculino',1,NULL,NULL),(2,'Femenino',1,NULL,NULL);
/*!40000 ALTER TABLE `generos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gestion_detalles`
--

DROP TABLE IF EXISTS `gestion_detalles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gestion_detalles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gestion_id` bigint(20) unsigned NOT NULL,
  `producto_id` bigint(20) unsigned NOT NULL,
  `cantidad` int(11) NOT NULL,
  `costo` decimal(8,2) NOT NULL,
  `monto` decimal(8,2) NOT NULL DEFAULT '0.00',
  `estado` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `descuento` decimal(8,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `gestion_detalles_gestion_id_foreign` (`gestion_id`),
  KEY `gestion_detalles_producto_id_foreign` (`producto_id`),
  CONSTRAINT `gestion_detalles_gestion_id_foreign` FOREIGN KEY (`gestion_id`) REFERENCES `gestiones` (`id`),
  CONSTRAINT `gestion_detalles_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gestion_detalles`
--

LOCK TABLES `gestion_detalles` WRITE;
/*!40000 ALTER TABLE `gestion_detalles` DISABLE KEYS */;
/*!40000 ALTER TABLE `gestion_detalles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gestiones`
--

DROP TABLE IF EXISTS `gestiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gestiones` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `serie_id` bigint(20) unsigned NOT NULL,
  `origen` bigint(20) unsigned NOT NULL,
  `destino` bigint(20) unsigned NOT NULL,
  `socio_id` bigint(20) unsigned NOT NULL,
  `tipo_pago_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `estado` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `observaciones` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gestiones_serie_id_foreign` (`serie_id`),
  KEY `gestiones_origen_foreign` (`origen`),
  KEY `gestiones_destino_foreign` (`destino`),
  KEY `gestiones_socio_id_foreign` (`socio_id`),
  KEY `gestiones_tipo_pago_id_foreign` (`tipo_pago_id`),
  KEY `gestiones_user_id_foreign` (`user_id`),
  CONSTRAINT `gestiones_destino_foreign` FOREIGN KEY (`destino`) REFERENCES `sucursales` (`id`),
  CONSTRAINT `gestiones_origen_foreign` FOREIGN KEY (`origen`) REFERENCES `sucursales` (`id`),
  CONSTRAINT `gestiones_serie_id_foreign` FOREIGN KEY (`serie_id`) REFERENCES `series` (`id`),
  CONSTRAINT `gestiones_socio_id_foreign` FOREIGN KEY (`socio_id`) REFERENCES `socios` (`id`),
  CONSTRAINT `gestiones_tipo_pago_id_foreign` FOREIGN KEY (`tipo_pago_id`) REFERENCES `tipo_pagos` (`id`),
  CONSTRAINT `gestiones_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gestiones`
--

LOCK TABLES `gestiones` WRITE;
/*!40000 ALTER TABLE `gestiones` DISABLE KEYS */;
/*!40000 ALTER TABLE `gestiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario_detalles`
--

DROP TABLE IF EXISTS `inventario_detalles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario_detalles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `inventario_id` bigint(20) unsigned NOT NULL,
  `producto_id` bigint(20) unsigned NOT NULL,
  `existencia` double(10,6) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventario_detalles_inventario_id_foreign` (`inventario_id`),
  KEY `inventario_detalles_producto_id_foreign` (`producto_id`),
  CONSTRAINT `inventario_detalles_inventario_id_foreign` FOREIGN KEY (`inventario_id`) REFERENCES `inventarios` (`id`),
  CONSTRAINT `inventario_detalles_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario_detalles`
--

LOCK TABLES `inventario_detalles` WRITE;
/*!40000 ALTER TABLE `inventario_detalles` DISABLE KEYS */;
INSERT INTO `inventario_detalles` VALUES (2,2,1,0.000000,NULL,'2023-10-18 05:00:55'),(3,2,2,300.000000,NULL,'2023-10-18 04:42:00');
/*!40000 ALTER TABLE `inventario_detalles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventarios`
--

DROP TABLE IF EXISTS `inventarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventarios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `bodega_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `inventarios_bodega_id_foreign` (`bodega_id`),
  CONSTRAINT `inventarios_bodega_id_foreign` FOREIGN KEY (`bodega_id`) REFERENCES `bodegas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventarios`
--

LOCK TABLES `inventarios` WRITE;
/*!40000 ALTER TABLE `inventarios` DISABLE KEYS */;
INSERT INTO `inventarios` VALUES (2,'',2,NULL,NULL),(3,'',2,NULL,NULL);
/*!40000 ALTER TABLE `inventarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lotes`
--

DROP TABLE IF EXISTS `lotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lotes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lotes`
--

LOCK TABLES `lotes` WRITE;
/*!40000 ALTER TABLE `lotes` DISABLE KEYS */;
INSERT INTO `lotes` VALUES (1,'LT15');
/*!40000 ALTER TABLE `lotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `order` int(11) NOT NULL,
  `parent_route` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `route` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `external_id` int(11) DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `has_children` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'Inicio',1,NULL,'index.index',NULL,'fa fa-home',0,'2023-10-21 03:31:20','2023-10-21 03:31:20'),(2,'RRHH',100,NULL,'rrhh',NULL,'fas fa-building',1,'2023-10-21 03:31:20','2023-10-21 03:31:20'),(3,'Empleados',150,'rrhh','rrhh.empleados.index',NULL,'fa fa-user',0,'2023-10-21 03:31:20','2023-10-21 03:31:20'),(4,'Solicitudes',200,NULL,'solicitudes',NULL,'fas fa-paste',1,'2023-10-21 03:31:20','2023-10-21 03:31:20'),(5,'Ausencias',30,'solicitudes','solicitudes.ausencias.index',NULL,'fas fa-newspaper',0,'2023-10-21 03:31:20','2023-10-21 03:31:20'),(6,'Autorizacion Ausencias',30,'solicitudes','solicitudes.autorizacion-ausencias.index',NULL,'fas fa-tasks',0,'2023-10-21 03:31:20','2023-10-21 03:31:20'),(7,'Abarroteria',300,NULL,'abarroteria',NULL,'fas fa-store-alt',1,'2023-10-21 03:31:20','2023-10-21 03:31:20'),(8,'Venta',10,'abarroteria','abarroteria.venta.index',NULL,'fas fa-cash-register',0,'2023-10-21 03:31:20','2023-10-21 03:31:20'),(9,'Bodegas',400,NULL,'bodegas',NULL,'fas fa-warehouse',1,'2023-10-21 03:31:20','2023-10-21 03:31:20'),(10,'Produccion Diaria',10,'bodegas','bodegas.produccion-diaria.index',NULL,'fas fa-people-carry',0,'2023-10-21 03:31:20','2023-10-21 03:31:20'),(11,'Lista de Productos',20,'bodegas','bodegas.lista-productos.index',NULL,'fas fa-layer-group',0,'2023-10-21 03:31:20','2023-10-21 03:31:20'),(12,'Planillas',500,NULL,'planillas',NULL,'fas fa-file-alt',1,'2023-10-21 03:31:20','2023-10-21 03:31:20'),(13,'Planilla',10,'planillas','planillas.planilla.index',NULL,'fas fa-clipboard',0,'2023-10-21 03:31:20','2023-10-21 03:31:20');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2014_12_15_091639_create_modules_table',1),(4,'2014_12_15_091721_create_permissions_table',1),(5,'2014_12_15_092126_create_roles_table',1),(6,'2014_12_15_092707_create_module_permissions_table',1),(7,'2014_12_15_092743_create_role_module_permissions_table',1),(8,'2014_12_15_092911_create_user_roles_table',1),(9,'2015_03_09_175117_create_menu_table',1),(10,'2016_08_28_183053_create_password_histories_table',1),(11,'2019_08_19_000000_create_failed_jobs_table',1),(12,'2019_12_14_000001_create_personal_access_tokens_table',1),(13,'2020_07_02_223053_alter_users_add_active',1),(14,'2020_08_01_190417_alter_menu_add_parameters',1),(15,'2021_01_18_170919_alter_users_add_legacy_user',1),(16,'2021_01_19_163125_remove_legacy_user',1),(17,'2021_02_19_195928_create_user_logins',1),(18,'2021_03_08_161656_alter_modules_table',1),(19,'2021_06_17_085200_add_names_to_cancerbero',1),(20,'2021_06_18_175117_alter_menu_use_names',1),(21,'2022_09_20_214800_create_productos_table',1),(22,'2022_09_20_215036_create_tipo_sedes_table',1),(23,'2022_09_20_215228_create_sucursals_table',1),(24,'2022_09_20_220121_create_precios_table',1),(25,'2022_09_20_220432_create_ofertas_table',1),(26,'2022_09_20_220931_create_lotes_table',1),(27,'2022_09_20_221058_create_inventarios_table',1),(28,'2022_09_20_221458_create_tipo_pagos_table',1),(29,'2022_09_20_221600_create_tipo_socios_table',1),(30,'2022_09_20_221622_create_fidelizacions_table',1),(31,'2022_09_20_221634_create_socios_table',1),(32,'2022_09_20_222053_create_series_table',1),(33,'2022_09_20_222222_create_gestions_table',1),(34,'2022_09_20_222647_create_gestion_detalles_table',1),(35,'2022_09_20_223215_create_cajas_table',1),(36,'2022_09_20_223422_create_caja_detalles_table',1),(37,'2022_09_24_151532_alter_add_estado_to_sucursales',1),(38,'2022_09_24_163347_alter_add_estado_to_productos',1),(39,'2022_09_24_173940_alter_drop_foreign_to_ofertas',1),(40,'2022_09_24_174036_alter_add_foreign_to_precios',1),(41,'2022_09_24_182334_alter_add_valor_to_fidelizaciones',1),(42,'2022_09_24_221745_create_control_accesos_table',1),(43,'2022_09_26_175254_alter_add_monto_to_gestion_detalles',1),(44,'2023_09_21_040036_create_puestos_table',2),(45,'2023_09_21_040529_create_sueldos_table',3),(46,'2023_09_21_041608_create_tipo_familias_table',4),(47,'2023_09_21_041955_create_empleados_table',5),(48,'2023_09_21_042416_create_familia_empleados_table',6),(49,'2023_09_21_043537_create_ascensos_table',7),(50,'2023_09_21_044459_alter_add_index_to_empleados',8),(55,'2023_09_23_102244_create_empresas_table',9),(56,'2023_09_27_190900_alter_add_colum_genero_and_correo_and_user_id_to_empleados',10),(57,'2023_10_03_192312_alter_add_colum_user_id_and_genero_and_correo_to_familia_empleados',11),(58,'2023_10_03_200801_alter_add_colum_empresa_id_to_empleados',12),(60,'2023_10_04_214151_alter_colum_dpi_to_empleados_and_to_famila_empleados',13),(61,'2023_10_04_215521_alter_colum_correo_and_celular_and_direccion_to_familia_empleados',14),(62,'2023_10_07_172233_create_motivo_ausencias_table',15),(63,'2023_10_07_231937_create_generos_table',16),(64,'2023_10_07_232540_create_estado_civils_table',17),(65,'2023_10_08_023238_create_tipo_ausencias_table',18),(66,'2023_10_08_025104_create_tipo_solicitudes_table',19),(72,'2023_10_08_030424_create_solicitud_ausencias_table',20),(73,'2023_10_09_211152_alter_add_empresa_id_and_cue_to_users',21),(74,'2023_10_10_233317_create_venta_comisiones_table',22),(75,'2023_10_13_135038_create_bodegas_table',23),(76,'2023_10_13_141813_alter_drop_colum_sucursal_id_and_lote_id_to_inventarios',24),(77,'2023_10_13_142357_alter_add_colum_bodega_id_and_lote_id_to_inventarios',25),(78,'2023_10_13_143116_create_ventas_table',26),(79,'2023_10_13_143435_create_venta_detalles_table',27),(80,'2023_10_13_145634_create_disponible_empleados_table',28),(81,'2023_10_13_185834_create_tipo_descuentos_table',29),(82,'2023_10_13_191217_alter_add_colum_tipo_pago_to_ventas',30),(83,'2023_10_13_192124_create_descuento_empleados_table',31),(84,'2023_10_16_192036_create_bodega_usuarios_table',32),(85,'2023_10_16_204406_alter_add_colum_precio_to_productos',33),(86,'2023_10_17_184454_create_inventario_detalles_table',34),(88,'2023_10_17_185728_alter_to_inventarios',35),(90,'2023_10_17_212058_alter_colum_produto_id_to_venta_detalles',36),(91,'2023_10_17_215008_alter_add_colu_monto_restante_to_disponible_empleados',37),(93,'2023_10_19_141700_create_procedure_sueldo_por_dia',38),(95,'2023_10_19_184622_create_produccion_diarias_table',39),(96,'2023_10_19_204143_create_periodos_table',40),(98,'2023_10_19_213124_create_planes_table',41),(99,'2023_10_20_053758_create_tipo_planillas_table',42),(100,'2023_10_20_054441_create_planillas_table',43),(101,'2023_10_20_055624_create_planilla_empleados_table',44),(103,'2023_10_20_064852_alter_two_colum_to_planillas',45),(109,'2023_10_20_113803_create_procedure__i_g_s_s',46),(111,'2023_10_20_141941_create_procedure_descuentos',47),(113,'2023_10_20_151116_create_procedure_comision_ventas',48),(115,'2023_10_20_200933_alter_add_empresa_id_and_planilla_id_to_planilla_empledos',49);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_permissions`
--

DROP TABLE IF EXISTS `module_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `module_permissions` (
  `name` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_permissions`
--

LOCK TABLES `module_permissions` WRITE;
/*!40000 ALTER TABLE `module_permissions` DISABLE KEYS */;
INSERT INTO `module_permissions` VALUES ('abarroteria.venta.detail'),('abarroteria.venta.index'),('abarroteria.venta.show'),('abarroteria.venta.store'),('bodegas.lista-productos.create'),('bodegas.lista-productos.data'),('bodegas.lista-productos.destroy'),('bodegas.lista-productos.detail'),('bodegas.lista-productos.edit'),('bodegas.lista-productos.index'),('bodegas.lista-productos.store'),('bodegas.lista-productos.update'),('bodegas.produccion-diaria.create'),('bodegas.produccion-diaria.data'),('bodegas.produccion-diaria.edit'),('bodegas.produccion-diaria.index'),('bodegas.produccion-diaria.show'),('bodegas.produccion-diaria.store'),('index.index'),('planillas.planilla.detail'),('planillas.planilla.index'),('planillas.planilla.show'),('planillas.planilla.store'),('planillas.planilla.update'),('rrhh.empleados.detail'),('rrhh.empleados.edit'),('rrhh.empleados.index'),('rrhh.empleados.store'),('rrhh.empleados.update'),('solicitudes.ausencias.create'),('solicitudes.ausencias.data'),('solicitudes.ausencias.edit'),('solicitudes.ausencias.index'),('solicitudes.ausencias.store'),('solicitudes.ausencias.update'),('solicitudes.autorizacion-ausencias.data'),('solicitudes.autorizacion-ausencias.edit'),('solicitudes.autorizacion-ausencias.index'),('solicitudes.autorizacion-ausencias.update');
/*!40000 ALTER TABLE `module_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules` (
  `name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(300) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES ('abarroteria.venta','Abarroteria - Venta'),('bodegas.lista-productos','Bodegas - Lista de Productos'),('bodegas.produccion-diaria','Bodegas - Produccion Diaria'),('index','Inicio'),('planillas.planilla','Planillas - Planilla'),('rrhh.empleados','RRHH - Empleados'),('solicitudes.ausencias','Inventarios - Ausencias'),('solicitudes.autorizacion-ausencias','Inventarios - Autorizacion Ausencias');
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motivo_ausencias`
--

DROP TABLE IF EXISTS `motivo_ausencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `motivo_ausencias` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `motivo_ausencias_user_id_foreign` (`user_id`),
  CONSTRAINT `motivo_ausencias_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motivo_ausencias`
--

LOCK TABLES `motivo_ausencias` WRITE;
/*!40000 ALTER TABLE `motivo_ausencias` DISABLE KEYS */;
INSERT INTO `motivo_ausencias` VALUES (1,'Vacacion',1,1,NULL,NULL),(2,'Lluvia',1,1,NULL,NULL),(3,'Asunto Familiar',1,1,NULL,NULL),(4,'Enfermedad',1,1,NULL,NULL);
/*!40000 ALTER TABLE `motivo_ausencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofertas`
--

DROP TABLE IF EXISTS `ofertas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ofertas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `valor` decimal(8,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofertas`
--

LOCK TABLES `ofertas` WRITE;
/*!40000 ALTER TABLE `ofertas` DISABLE KEYS */;
/*!40000 ALTER TABLE `ofertas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_histories`
--

DROP TABLE IF EXISTS `password_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `password` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `password_histories_user_id_foreign` (`user_id`),
  CONSTRAINT `password_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_histories`
--

LOCK TABLES `password_histories` WRITE;
/*!40000 ALTER TABLE `password_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodos`
--

DROP TABLE IF EXISTS `periodos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `periodos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `periodos_user_id_foreign` (`user_id`),
  CONSTRAINT `periodos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodos`
--

LOCK TABLES `periodos` WRITE;
/*!40000 ALTER TABLE `periodos` DISABLE KEYS */;
INSERT INTO `periodos` VALUES (1,'octubre',NULL,NULL,NULL);
/*!40000 ALTER TABLE `periodos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `name` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `parent` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `description` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES ('create',NULL,'Crear'),('data','index','Obtener datos'),('destroy',NULL,'Borrar'),('detail','edit','Obtener datos edición'),('edit',NULL,'Editar'),('index',NULL,'Ver'),('show',NULL,'Información'),('store','create','Guardar'),('update','edit','Actualizar');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `token` varchar(64) COLLATE utf8_spanish_ci NOT NULL,
  `abilities` text COLLATE utf8_spanish_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planes`
--

DROP TABLE IF EXISTS `planes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_desde` date NOT NULL,
  `fecha_hasta` date NOT NULL,
  `serie_dias` int(11) NOT NULL,
  `periodo_id` bigint(20) unsigned NOT NULL,
  `numero_plan` int(11) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `planes_fecha_desde_fecha_hasta_periodo_id_index` (`fecha_desde`,`fecha_hasta`,`periodo_id`),
  KEY `planes_periodo_id_numero_plan_index` (`periodo_id`,`numero_plan`),
  CONSTRAINT `planes_periodo_id_foreign` FOREIGN KEY (`periodo_id`) REFERENCES `periodos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planes`
--

LOCK TABLES `planes` WRITE;
/*!40000 ALTER TABLE `planes` DISABLE KEYS */;
INSERT INTO `planes` VALUES (1,'primera quincena','2023-10-01','2023-10-15',15,1,1,1,NULL,NULL),(2,'quincena 2','2023-10-16','2023-10-31',15,1,2,1,NULL,NULL);
/*!40000 ALTER TABLE `planes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planilla_empleados`
--

DROP TABLE IF EXISTS `planilla_empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planilla_empleados` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cue` bigint(20) unsigned NOT NULL,
  `liquido` double(16,6) NOT NULL,
  `dias_laborados` int(11) NOT NULL,
  `planilla_id` bigint(20) unsigned NOT NULL,
  `empresa_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `planilla_empleados_cue_foreign` (`cue`),
  KEY `planilla_empleados_planilla_id_foreign` (`planilla_id`),
  CONSTRAINT `planilla_empleados_cue_foreign` FOREIGN KEY (`cue`) REFERENCES `empleados` (`cue`),
  CONSTRAINT `planilla_empleados_planilla_id_foreign` FOREIGN KEY (`planilla_id`) REFERENCES `planillas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planilla_empleados`
--

LOCK TABLES `planilla_empleados` WRITE;
/*!40000 ALTER TABLE `planilla_empleados` DISABLE KEYS */;
INSERT INTO `planilla_empleados` VALUES (22,14,7735.025000,15,3,2,1,'2023-10-21 02:36:10','2023-10-21 02:36:10'),(23,16,2055.457500,15,3,2,1,'2023-10-21 02:36:10','2023-10-21 02:36:10');
/*!40000 ALTER TABLE `planilla_empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planillas`
--

DROP TABLE IF EXISTS `planillas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planillas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `tipo_planilla_id` bigint(20) unsigned NOT NULL,
  `estado` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `empresa_id` bigint(20) NOT NULL,
  `crea_user_id` bigint(20) NOT NULL,
  `calcula_user_id` bigint(20) DEFAULT NULL,
  `cierra_user_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `planillas_tipo_planilla_id_foreign` (`tipo_planilla_id`),
  CONSTRAINT `planillas_tipo_planilla_id_foreign` FOREIGN KEY (`tipo_planilla_id`) REFERENCES `tipo_planillas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planillas`
--

LOCK TABLES `planillas` WRITE;
/*!40000 ALTER TABLE `planillas` DISABLE KEYS */;
INSERT INTO `planillas` VALUES (2,'2023-10-16','2023-10-31',1,'GRABADO',1,0,1,NULL,NULL,NULL),(3,'2023-10-16','2023-10-31',1,'APLICADO',2,1,NULL,NULL,'2023-10-21 00:18:08','2023-10-21 02:36:10');
/*!40000 ALTER TABLE `planillas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `precios`
--

DROP TABLE IF EXISTS `precios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `precios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sucursal_id` bigint(20) unsigned NOT NULL,
  `producto_id` bigint(20) unsigned NOT NULL,
  `precio_mayoreo` decimal(8,2) DEFAULT NULL,
  `precio_supermercado` decimal(8,2) NOT NULL,
  `oferta_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `precios_sucursal_id_foreign` (`sucursal_id`),
  KEY `precios_producto_id_foreign` (`producto_id`),
  KEY `precios_oferta_id_foreign` (`oferta_id`),
  CONSTRAINT `precios_oferta_id_foreign` FOREIGN KEY (`oferta_id`) REFERENCES `ofertas` (`id`),
  CONSTRAINT `precios_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `precios_sucursal_id_foreign` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursales` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `precios`
--

LOCK TABLES `precios` WRITE;
/*!40000 ALTER TABLE `precios` DISABLE KEYS */;
/*!40000 ALTER TABLE `precios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produccion_diaria`
--

DROP TABLE IF EXISTS `produccion_diaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produccion_diaria` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cue` bigint(20) unsigned NOT NULL,
  `bodega_id` bigint(20) unsigned NOT NULL,
  `producto_id` bigint(20) unsigned NOT NULL,
  `cantidad` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `produccion_diaria_cue_foreign` (`cue`),
  KEY `produccion_diaria_bodega_id_foreign` (`bodega_id`),
  KEY `produccion_diaria_producto_id_foreign` (`producto_id`),
  CONSTRAINT `produccion_diaria_bodega_id_foreign` FOREIGN KEY (`bodega_id`) REFERENCES `bodegas` (`id`),
  CONSTRAINT `produccion_diaria_cue_foreign` FOREIGN KEY (`cue`) REFERENCES `empleados` (`cue`),
  CONSTRAINT `produccion_diaria_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produccion_diaria`
--

LOCK TABLES `produccion_diaria` WRITE;
/*!40000 ALTER TABLE `produccion_diaria` DISABLE KEYS */;
INSERT INTO `produccion_diaria` VALUES (1,15,2,3,5,1,'2023-10-19'),(2,16,2,3,6,1,'2023-10-19');
/*!40000 ALTER TABLE `produccion_diaria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `codigo_barra` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `precio` decimal(10,6) NOT NULL,
  `estado` varchar(255) COLLATE utf8_spanish_ci NOT NULL DEFAULT 'ACTIVO',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Coca-Cola','12',5.000000,'1',NULL,NULL),(2,'Tortrix','15',1.000000,'1',NULL,NULL),(3,'Zapato GT','16',350.000000,'1',NULL,NULL),(4,'Tenis Nila','1012',225.000000,'1','2023-10-21 03:29:26','2023-10-21 03:29:26');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puestos`
--

DROP TABLE IF EXISTS `puestos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `puestos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puestos`
--

LOCK TABLES `puestos` WRITE;
/*!40000 ALTER TABLE `puestos` DISABLE KEYS */;
INSERT INTO `puestos` VALUES (1,'Gerente de Sistemas',1,NULL,NULL),(2,'Programador Web',1,NULL,NULL),(3,'Recutador',1,NULL,NULL);
/*!40000 ALTER TABLE `puestos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_module_permissions`
--

DROP TABLE IF EXISTS `role_module_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_module_permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned NOT NULL,
  `module_permission` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_module_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_module_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6734 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_module_permissions`
--

LOCK TABLES `role_module_permissions` WRITE;
/*!40000 ALTER TABLE `role_module_permissions` DISABLE KEYS */;
INSERT INTO `role_module_permissions` VALUES (6695,1,'abarroteria.venta.detail','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6696,1,'abarroteria.venta.index','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6697,1,'abarroteria.venta.show','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6698,1,'abarroteria.venta.store','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6699,1,'bodegas.lista-productos.create','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6700,1,'bodegas.lista-productos.data','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6701,1,'bodegas.lista-productos.destroy','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6702,1,'bodegas.lista-productos.detail','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6703,1,'bodegas.lista-productos.edit','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6704,1,'bodegas.lista-productos.index','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6705,1,'bodegas.lista-productos.store','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6706,1,'bodegas.lista-productos.update','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6707,1,'bodegas.produccion-diaria.create','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6708,1,'bodegas.produccion-diaria.data','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6709,1,'bodegas.produccion-diaria.edit','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6710,1,'bodegas.produccion-diaria.index','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6711,1,'bodegas.produccion-diaria.show','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6712,1,'bodegas.produccion-diaria.store','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6713,1,'index.index','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6714,1,'planillas.planilla.detail','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6715,1,'planillas.planilla.index','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6716,1,'planillas.planilla.show','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6717,1,'planillas.planilla.store','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6718,1,'planillas.planilla.update','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6719,1,'rrhh.empleados.detail','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6720,1,'rrhh.empleados.edit','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6721,1,'rrhh.empleados.index','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6722,1,'rrhh.empleados.store','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6723,1,'rrhh.empleados.update','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6724,1,'solicitudes.ausencias.create','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6725,1,'solicitudes.ausencias.data','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6726,1,'solicitudes.ausencias.edit','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6727,1,'solicitudes.ausencias.index','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6728,1,'solicitudes.ausencias.store','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6729,1,'solicitudes.ausencias.update','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6730,1,'solicitudes.autorizacion-ausencias.data','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6731,1,'solicitudes.autorizacion-ausencias.edit','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6732,1,'solicitudes.autorizacion-ausencias.index','2023-10-21 03:31:26','2023-10-21 03:31:26'),(6733,1,'solicitudes.autorizacion-ausencias.update','2023-10-21 03:31:26','2023-10-21 03:31:26');
/*!40000 ALTER TABLE `role_module_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Backdoor','Rol Backdoor',NULL,NULL),(2,'RRHH','Recursos Humanos',NULL,NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `series`
--

DROP TABLE IF EXISTS `series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `series` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `series`
--

LOCK TABLES `series` WRITE;
/*!40000 ALTER TABLE `series` DISABLE KEYS */;
INSERT INTO `series` VALUES (1,'VENTA'),(2,'TRASLADO'),(3,'COMPRA'),(4,'RECEPCION'),(5,'RRHH');
/*!40000 ALTER TABLE `series` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socios`
--

DROP TABLE IF EXISTS `socios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `nit` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `fidelizacion_id` bigint(20) unsigned NOT NULL,
  `tipo_socio_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `socios_fidelizacion_id_foreign` (`fidelizacion_id`),
  KEY `socios_tipo_socio_id_foreign` (`tipo_socio_id`),
  CONSTRAINT `socios_fidelizacion_id_foreign` FOREIGN KEY (`fidelizacion_id`) REFERENCES `fidelizaciones` (`id`),
  CONSTRAINT `socios_tipo_socio_id_foreign` FOREIGN KEY (`tipo_socio_id`) REFERENCES `tipo_socios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socios`
--

LOCK TABLES `socios` WRITE;
/*!40000 ALTER TABLE `socios` DISABLE KEYS */;
/*!40000 ALTER TABLE `socios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solicitud_ausencias`
--

DROP TABLE IF EXISTS `solicitud_ausencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `solicitud_ausencias` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cue` bigint(20) unsigned NOT NULL,
  `tipo_solicitud_id` bigint(20) unsigned NOT NULL,
  `motivo_ausencia_id` bigint(20) unsigned NOT NULL,
  `fecha_desde` date NOT NULL,
  `fecha_hasta` date NOT NULL,
  `estado` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_ausencia_id` bigint(20) unsigned DEFAULT NULL,
  `observacion` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `solicitud_ausencias_cue_foreign` (`cue`),
  KEY `solicitud_ausencias_tipo_solicitud_id_foreign` (`tipo_solicitud_id`),
  KEY `solicitud_ausencias_motivo_ausencia_id_foreign` (`motivo_ausencia_id`),
  KEY `solicitud_ausencias_tipo_ausencia_id_foreign` (`tipo_ausencia_id`),
  CONSTRAINT `solicitud_ausencias_cue_foreign` FOREIGN KEY (`cue`) REFERENCES `empleados` (`cue`),
  CONSTRAINT `solicitud_ausencias_motivo_ausencia_id_foreign` FOREIGN KEY (`motivo_ausencia_id`) REFERENCES `motivo_ausencias` (`id`),
  CONSTRAINT `solicitud_ausencias_tipo_ausencia_id_foreign` FOREIGN KEY (`tipo_ausencia_id`) REFERENCES `tipo_ausencias` (`id`),
  CONSTRAINT `solicitud_ausencias_tipo_solicitud_id_foreign` FOREIGN KEY (`tipo_solicitud_id`) REFERENCES `tipo_solicitudes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solicitud_ausencias`
--

LOCK TABLES `solicitud_ausencias` WRITE;
/*!40000 ALTER TABLE `solicitud_ausencias` DISABLE KEYS */;
INSERT INTO `solicitud_ausencias` VALUES (1,15,1,4,'2023-10-10','2023-10-10','AUTORIZADO',2,NULL,'2023-10-10 02:49:54','2023-10-11 00:58:55'),(2,16,1,3,'2023-10-11','2023-10-11','AUTORIZADO',1,'Se le autiliza el permiso','2023-10-11 00:53:32','2023-10-20 00:31:46'),(3,16,1,2,'2023-10-20','2023-10-20','AUTORIZADO',1,'se autoriza la ausencia','2023-10-20 20:06:20','2023-10-20 20:07:32'),(4,17,1,2,'2023-10-20','2023-10-20','AUTORIZADO',1,'Se le autiliza el permiso estragos naturales','2023-10-20 20:14:22','2023-10-20 20:14:52');
/*!40000 ALTER TABLE `solicitud_ausencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sucursales`
--

DROP TABLE IF EXISTS `sucursales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sucursales` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `estado` varchar(255) COLLATE utf8_spanish_ci NOT NULL DEFAULT 'ACTIVO',
  `tipo_sede_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sucursales_tipo_sede_id_foreign` (`tipo_sede_id`),
  CONSTRAINT `sucursales_tipo_sede_id_foreign` FOREIGN KEY (`tipo_sede_id`) REFERENCES `tipo_sedes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sucursales`
--

LOCK TABLES `sucursales` WRITE;
/*!40000 ALTER TABLE `sucursales` DISABLE KEYS */;
/*!40000 ALTER TABLE `sucursales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sueldos`
--

DROP TABLE IF EXISTS `sueldos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sueldos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `puesto_id` bigint(20) unsigned NOT NULL,
  `sueldo` decimal(10,2) NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sueldos_puesto_id_foreign` (`puesto_id`),
  CONSTRAINT `sueldos_puesto_id_foreign` FOREIGN KEY (`puesto_id`) REFERENCES `puestos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sueldos`
--

LOCK TABLES `sueldos` WRITE;
/*!40000 ALTER TABLE `sueldos` DISABLE KEYS */;
INSERT INTO `sueldos` VALUES (1,1,11500.00,1,NULL,NULL),(2,2,6500.00,1,NULL,NULL),(3,3,4500.00,1,NULL,NULL),(4,1,10000.00,1,NULL,NULL),(5,2,4500.00,1,NULL,NULL),(6,3,3500.00,1,NULL,NULL);
/*!40000 ALTER TABLE `sueldos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_ausencias`
--

DROP TABLE IF EXISTS `tipo_ausencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_ausencias` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_ausencias`
--

LOCK TABLES `tipo_ausencias` WRITE;
/*!40000 ALTER TABLE `tipo_ausencias` DISABLE KEYS */;
INSERT INTO `tipo_ausencias` VALUES (1,'Descuento',1,NULL,NULL),(2,'Pagar',1,NULL,NULL);
/*!40000 ALTER TABLE `tipo_ausencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_descuentos`
--

DROP TABLE IF EXISTS `tipo_descuentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_descuentos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_descuentos`
--

LOCK TABLES `tipo_descuentos` WRITE;
/*!40000 ALTER TABLE `tipo_descuentos` DISABLE KEYS */;
INSERT INTO `tipo_descuentos` VALUES (1,'abarroteria',1,NULL,NULL),(2,'ausencia',1,NULL,NULL),(3,'prestamo',1,NULL,NULL),(4,'cooperativa',1,NULL,NULL);
/*!40000 ALTER TABLE `tipo_descuentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_familias`
--

DROP TABLE IF EXISTS `tipo_familias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_familias` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_familias`
--

LOCK TABLES `tipo_familias` WRITE;
/*!40000 ALTER TABLE `tipo_familias` DISABLE KEYS */;
INSERT INTO `tipo_familias` VALUES (1,'progenie',NULL,NULL),(2,'conyuge',NULL,NULL);
/*!40000 ALTER TABLE `tipo_familias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_pagos`
--

DROP TABLE IF EXISTS `tipo_pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_pagos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_pagos`
--

LOCK TABLES `tipo_pagos` WRITE;
/*!40000 ALTER TABLE `tipo_pagos` DISABLE KEYS */;
INSERT INTO `tipo_pagos` VALUES (1,'Ninguno'),(2,'Efectivo'),(3,'POS'),(4,'Credito');
/*!40000 ALTER TABLE `tipo_pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_planillas`
--

DROP TABLE IF EXISTS `tipo_planillas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_planillas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `dias_plan` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_planillas`
--

LOCK TABLES `tipo_planillas` WRITE;
/*!40000 ALTER TABLE `tipo_planillas` DISABLE KEYS */;
INSERT INTO `tipo_planillas` VALUES (1,'Nomina',15,NULL,NULL);
/*!40000 ALTER TABLE `tipo_planillas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_sedes`
--

DROP TABLE IF EXISTS `tipo_sedes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_sedes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_sedes`
--

LOCK TABLES `tipo_sedes` WRITE;
/*!40000 ALTER TABLE `tipo_sedes` DISABLE KEYS */;
INSERT INTO `tipo_sedes` VALUES (1,'Supermercado'),(2,'Tienda de Mayoreo'),(3,'Bodega Central');
/*!40000 ALTER TABLE `tipo_sedes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_socios`
--

DROP TABLE IF EXISTS `tipo_socios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_socios` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_socios`
--

LOCK TABLES `tipo_socios` WRITE;
/*!40000 ALTER TABLE `tipo_socios` DISABLE KEYS */;
INSERT INTO `tipo_socios` VALUES (1,'Cliente'),(2,'Proveedor'),(3,'Colaborador');
/*!40000 ALTER TABLE `tipo_socios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_solicitudes`
--

DROP TABLE IF EXISTS `tipo_solicitudes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_solicitudes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_solicitudes`
--

LOCK TABLES `tipo_solicitudes` WRITE;
/*!40000 ALTER TABLE `tipo_solicitudes` DISABLE KEYS */;
INSERT INTO `tipo_solicitudes` VALUES (1,'AUSENCIA',1,NULL,NULL);
/*!40000 ALTER TABLE `tipo_solicitudes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_logins`
--

DROP TABLE IF EXISTS `user_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_logins` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `browser` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_logins`
--

LOCK TABLES `user_logins` WRITE;
/*!40000 ALTER TABLE `user_logins` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_roles_user_id_role_id_unique` (`user_id`,`role_id`),
  KEY `user_roles_role_id_foreign` (`role_id`),
  CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,1,1,NULL,NULL),(3,2,2,'2023-10-18 02:55:15','2023-10-18 02:55:15');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `cue` bigint(20) unsigned DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `empresa_id` bigint(20) unsigned DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_cue_foreign` (`cue`),
  KEY `users_empresa_id_foreign` (`empresa_id`),
  CONSTRAINT `users_cue_foreign` FOREIGN KEY (`cue`) REFERENCES `empleados` (`cue`),
  CONSTRAINT `users_empresa_id_foreign` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Rodolfo Cal','rcal',14,NULL,'$2y$10$RwQApg/F7giQ3Runm33rfOVBsaWHxFj8wOCpH1H9IuEKKyf18UgiK',NULL,2,1,NULL,NULL),(2,'Jonnathan Monzon','yony',NULL,NULL,'$2y$10$jo2N8kBJTTxCLFei5vu6WOcO8H0o.tGkiv5lYkiAMsWi3hoaAWOc6',NULL,NULL,1,'2023-09-23 16:44:59','2023-10-18 02:55:15');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta_comisiones`
--

DROP TABLE IF EXISTS `venta_comisiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta_comisiones` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `monto_inicio` double NOT NULL,
  `monto_fin` double NOT NULL,
  `porcentaje` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta_comisiones`
--

LOCK TABLES `venta_comisiones` WRITE;
/*!40000 ALTER TABLE `venta_comisiones` DISABLE KEYS */;
INSERT INTO `venta_comisiones` VALUES (1,'Bajo',0,100000,0,NULL,NULL),(2,'Medio-Bajo',100001,200000,0.025,NULL,NULL),(3,'Medio',200001,400000,0.035,NULL,NULL),(4,'Alto',400001,10000000,0.045,NULL,NULL);
/*!40000 ALTER TABLE `venta_comisiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venta_detalles`
--

DROP TABLE IF EXISTS `venta_detalles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta_detalles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `venta_id` bigint(20) unsigned NOT NULL,
  `producto_id` bigint(20) unsigned NOT NULL,
  `precio` decimal(10,6) NOT NULL,
  `cantidad` bigint(20) NOT NULL,
  `total` bigint(20) NOT NULL,
  `estado` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `venta_detalles_venta_id_foreign` (`venta_id`),
  KEY `venta_detalles_producto_id_foreign` (`producto_id`),
  CONSTRAINT `venta_detalles_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `venta_detalles_venta_id_foreign` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta_detalles`
--

LOCK TABLES `venta_detalles` WRITE;
/*!40000 ALTER TABLE `venta_detalles` DISABLE KEYS */;
INSERT INTO `venta_detalles` VALUES (1,2,1,5.000000,2,100000,'GRABADO','2023-10-18 03:30:45','2023-10-18 03:30:45'),(2,2,2,1.000000,4,4,'GRABADO','2023-10-18 03:30:45','2023-10-18 03:30:45'),(3,3,1,5.000000,1,5,'GRABADO','2023-10-18 03:47:32','2023-10-18 03:47:32'),(4,4,2,1.000000,3,3,'GRABADO','2023-10-18 04:09:18','2023-10-18 04:09:18'),(5,5,2,1.000000,5,5,'GRABADO','2023-10-18 04:40:46','2023-10-18 04:40:46'),(6,6,2,1.000000,5,5,'ANULADO','2023-10-18 04:42:00','2023-10-18 04:42:00'),(7,7,1,5.000000,2,10,'GRABADO','2023-10-18 05:00:21','2023-10-18 05:00:21'),(8,8,1,5.000000,2,10,'ANULADO','2023-10-18 05:00:55','2023-10-18 05:00:55');
/*!40000 ALTER TABLE `venta_detalles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cue_autoriza` bigint(20) unsigned NOT NULL,
  `cue_solicita` bigint(20) unsigned NOT NULL,
  `tipo_pago_id` bigint(20) unsigned NOT NULL,
  `bodega_id` bigint(20) unsigned NOT NULL,
  `estado` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ventas_cue_autoriza_foreign` (`cue_autoriza`),
  KEY `ventas_cue_solicita_foreign` (`cue_solicita`),
  KEY `ventas_bodega_id_foreign` (`bodega_id`),
  KEY `ventas_tipo_pago_id_foreign` (`tipo_pago_id`),
  CONSTRAINT `ventas_bodega_id_foreign` FOREIGN KEY (`bodega_id`) REFERENCES `bodegas` (`id`),
  CONSTRAINT `ventas_cue_autoriza_foreign` FOREIGN KEY (`cue_autoriza`) REFERENCES `empleados` (`cue`),
  CONSTRAINT `ventas_cue_solicita_foreign` FOREIGN KEY (`cue_solicita`) REFERENCES `empleados` (`cue`),
  CONSTRAINT `ventas_tipo_pago_id_foreign` FOREIGN KEY (`tipo_pago_id`) REFERENCES `tipo_pagos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (2,14,15,4,2,'GRABADO','2023-10-17'),(3,14,14,2,2,'GRABADO','2023-10-17'),(4,14,15,4,2,'GRABADO','2023-10-17'),(5,14,15,4,2,'GRABADO','2023-10-17'),(6,14,15,4,2,'ANULADO','2023-10-17'),(7,14,14,4,2,'GRABADO','2023-10-17'),(8,14,14,4,2,'ANULADO','2023-10-17');
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'tconsulting'
--
/*!50003 DROP PROCEDURE IF EXISTS `calculo_pago_e_igss` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_spanish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `calculo_pago_e_igss`(IN _cue INT, IN _tipo INT)
BEGIN
                            DECLARE cue INT;
                            DECLARE tipo INT;
                            DECLARE igss DECIMAL(10, 4);
                            DECLARE porcentaje DECIMAL(10, 4);

                            SET cue = _cue;
                            SET tipo = _tipo;
                            SET igss = 0.0483;

                            IF tipo = 1 THEN
                                SET porcentaje = 0.45;
                            ELSEIF tipo = 2 THEN
                                SET porcentaje = 0.55;
                            END IF;

                            select r.cue, r.sueldo, r.pago, sum(r.pago * igss) as cuota_igss
                            from (SELECT e.cue, s.sueldo, SUM(s.sueldo * porcentaje) AS pago
                                FROM tconsulting.empleados e
                                    INNER JOIN tconsulting.sueldos s ON e.sueldo_id = s.id AND e.puesto_id = s.puesto_id
                            WHERE e.cue = cue) as r
                            group by r.cue;
                        END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `comision_ventas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_spanish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `comision_ventas`(in _cue int, in _fecha_inicio date, in _fecha_fin date)
BEGIN
                                declare total_ventas decimal(10,4);

                                set total_ventas = (select sum(vd.total) as venta_total  from tconsulting.ventas v
                                                            inner join tconsulting.venta_detalles vd on v.id = vd.venta_id
                                                    where v.cue_autoriza = _cue and v.fecha between _fecha_inicio and _fecha_fin and v.estado = 'GRABADO');

                                select vc.descripcion, sum(vc.porcentaje * total_ventas) as comision_total  from tconsulting.venta_comisiones vc 
                                where vc.monto_inicio <= total_ventas and vc.monto_fin >= total_ventas
                                group by vc.descripcion;
                            END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `descuentos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_spanish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `descuentos`(in _cue int, in _fecha_inicio date, in _fecha_fin date)
BEGIN
                                select de.cue, sum(de.monto) as descuento_total from tconsulting.descuento_empleados de
                                where de.cue = _cue and de.fecha between _fecha_inicio and _fecha_fin;
                            END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sueldo_por_dia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_spanish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sueldo_por_dia`(in _cue int)
BEGIN
                                set @cue = _cue;
                                select e.cue, s.sueldo, sum(s.sueldo/30) as sueldo_por_dia  from tconsulting.empleados e
                                        inner join tconsulting.sueldos s on e.sueldo_id = s.id and e.puesto_id = s.puesto_id
                                where e.cue = @cue; 
                            END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-21 19:25:02
