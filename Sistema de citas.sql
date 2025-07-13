CREATE TABLE `cita` (
  `id_cita` int NOT NULL AUTO_INCREMENT,
  `id_paciente` int DEFAULT NULL,
  `id_medico` int DEFAULT NULL,
  `id_servicio` int DEFAULT NULL,
  `fecha_cita` date DEFAULT NULL,
  `hora_cita` time DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  `costo_calculado` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_cita`),
  KEY `id_paciente` (`id_paciente`),
  KEY `id_medico` (`id_medico`),
  KEY `id_servicio` (`id_servicio`),
  CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `paciente` (`id_paciente`),
  CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`id_medico`) REFERENCES `medico` (`id_medico`),
  CONSTRAINT `cita_ibfk_3` FOREIGN KEY (`id_servicio`) REFERENCES `servicio` (`id_servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cita`
--

LOCK TABLES `cita` WRITE;
/*!40000 ALTER TABLE `cita` DISABLE KEYS */;
INSERT INTO `cita` VALUES (1,1,1,2,'2025-07-15','09:00:00','Agendada',80000.00),(2,2,2,1,'2025-07-16','10:30:00','Confirmada',50000.00),(3,3,3,3,'2025-07-17','14:00:00','Agendada',70000.00);
/*!40000 ALTER TABLE `cita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especialidad`
--

DROP TABLE IF EXISTS `especialidad`;
CREATE TABLE `especialidad` (
  `id_especialidad` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_especialidad`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `especialidad`
--

LOCK TABLES `especialidad` WRITE;
INSERT INTO `especialidad` VALUES (1,'Cardiología','Especialidad médica que se encarga del diagnóstico y tratamiento de las enfermedades del corazón.'),(2,'Pediatría','Atención médica de niños y adolescentes.'),(3,'Dermatología','Tratamiento de enfermedades de la piel.');

UNLOCK TABLES;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
CREATE TABLE `factura` (
  `id_factura` int NOT NULL AUTO_INCREMENT,
  `id_cita` int DEFAULT NULL,
  `fecha_emision` date DEFAULT NULL,
  `total_factura` decimal(10,2) DEFAULT NULL,
  `estado_pago` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_factura`),
  KEY `id_cita` (`id_cita`),
  CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`id_cita`) REFERENCES `cita` (`id_cita`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
INSERT INTO `factura` VALUES (1,1,'2025-07-15',80000.00,'Pendiente'),(2,2,'2025-07-16',50000.00,'Pagada'),(3,3,'2025-07-17',70000.00,'Anulada');
UNLOCK TABLES;

--
-- Table structure for table `medico`
--

DROP TABLE IF EXISTS `medico`;
CREATE TABLE `medico` (
  `id_medico` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(50) DEFAULT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `id_especialidad` int DEFAULT NULL,
  `consultorio` varchar(10) DEFAULT NULL,
  `horario` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_medico`),
  KEY `id_especialidad` (`id_especialidad`),
  CONSTRAINT `medico_ibfk_1` FOREIGN KEY (`id_especialidad`) REFERENCES `especialidad` (`id_especialidad`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `medico`
--

LOCK TABLES `medico` WRITE;
INSERT INTO `medico` VALUES (1,'Juan','Pérez',1,'C101','Lunes a Viernes 08:00-12:00'),(2,'María','González',2,'C102','Lunes a Viernes 13:00-17:00'),(3,'Carlos','Ramírez',3,'C103','Martes y Jueves 09:00-15:00');

UNLOCK TABLES;

--
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
CREATE TABLE `paciente` (
  `id_paciente` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(50) DEFAULT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  PRIMARY KEY (`id_paciente`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `paciente`
--

LOCK TABLES `paciente` WRITE;
INSERT INTO `paciente` VALUES (1,'Luis','Martínez','3123456789','luis.martinez@mail.com','1990-05-20'),(2,'Ana','Rodríguez','3112345678','ana.rodriguez@mail.com','1985-08-15'),(3,'Pedro','Sánchez','3109876543','pedro.sanchez@mail.com','2000-02-10');
UNLOCK TABLES;

--
-- Table structure for table `servicio`
--

DROP TABLE IF EXISTS `servicio`;
CREATE TABLE `servicio` (
  `id_servicio` int NOT NULL AUTO_INCREMENT,
  `nombre_servicio` varchar(100) DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_servicio`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `servicio`
--

LOCK TABLES `servicio` WRITE;
INSERT INTO `servicio` VALUES (1,'Consulta General',50000.00),(2,'Electrocardiograma',80000.00),(3,'Evaluación Dermatológica',70000.00);
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_detalle_citas`
--

DROP TABLE IF EXISTS `vista_detalle_citas`;
SET @saved_cs_client     = @@character_set_client;
/*
 1 AS `id_cita`,
 1 AS `nombre_paciente`,
 1 AS `nombre_medico`,
 1 AS `especialidad`,
 1 AS `nombre_servicio`,
 1 AS `fecha_cita`,
 1 AS `hora_cita`,
 1 AS `estado`,
 1 AS `costo_calculado`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vista_detalle_citas`
--

