﻿--
-- Script was generated by Devart dbForge Studio 2020 for MySQL, Version 9.0.470.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 7/02/2021 8:08:29 p. m.
-- Server version: 10.4.14
-- Client version: 4.1
--

-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

--
-- Set default database
--
USE vpn;

--
-- Drop procedure `spAsistenciaCelebracion_BuscarFechas`
--
DROP PROCEDURE IF EXISTS spAsistenciaCelebracion_BuscarFechas;

--
-- Drop procedure `spAsistenciaCelebracion_ConsultarListado`
--
DROP PROCEDURE IF EXISTS spAsistenciaCelebracion_ConsultarListado;

--
-- Drop procedure `spMiembros_Buscar`
--
DROP PROCEDURE IF EXISTS spMiembros_Buscar;

--
-- Drop procedure `spMiembros_Guardar`
--
DROP PROCEDURE IF EXISTS spMiembros_Guardar;

--
-- Drop table `tbl_miembros`
--
DROP TABLE IF EXISTS tbl_miembros;

--
-- Drop procedure `spAsistenciaCelebracion_Guardar`
--
DROP PROCEDURE IF EXISTS spAsistenciaCelebracion_Guardar;

--
-- Drop procedure `spAsistenciaxCelebracion_Actualizar`
--
DROP PROCEDURE IF EXISTS spAsistenciaxCelebracion_Actualizar;

--
-- Drop procedure `spAsistenciaxcelebracion_VerificarDuplicados`
--
DROP PROCEDURE IF EXISTS spAsistenciaxcelebracion_VerificarDuplicados;

--
-- Drop table `tblasistenciaxcelebracion`
--
DROP TABLE IF EXISTS tblasistenciaxcelebracion;

--
-- Drop procedure `spCelebraciones_ActualizarAsientos`
--
DROP PROCEDURE IF EXISTS spCelebraciones_ActualizarAsientos;

--
-- Drop procedure `spCelebraciones_ConsultarDisponibilidad`
--
DROP PROCEDURE IF EXISTS spCelebraciones_ConsultarDisponibilidad;

--
-- Drop procedure `spCelebraciones_LlenarMaestro`
--
DROP PROCEDURE IF EXISTS spCelebraciones_LlenarMaestro;

--
-- Drop table `tblcelebraciones`
--
DROP TABLE IF EXISTS tblcelebraciones;

--
-- Set default database
--
USE vpn;

--
-- Create table `tblcelebraciones`
--
CREATE TABLE tblcelebraciones (
  CelebracionID int(11) NOT NULL AUTO_INCREMENT,
  Fecha date DEFAULT NULL,
  Hora time DEFAULT NULL,
  Estado bit(1) DEFAULT NULL,
  Usuario varchar(255) DEFAULT NULL,
  Personas int(11) NOT NULL,
  FechaActualizacion date DEFAULT NULL,
  Vigencia bit(1) DEFAULT NULL,
  Tipo varchar(255) DEFAULT NULL,
  PRIMARY KEY (CelebracionID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 8,
AVG_ROW_LENGTH = 16384,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

DELIMITER $$

--
-- Create procedure `spCelebraciones_LlenarMaestro`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE spCelebraciones_LlenarMaestro ()
BEGIN
  SET lc_time_names = 'es_ES';

  SELECT
    CelebracionID,
    CONCAT(Tipo, ' - ', DAYNAME(Fecha), ' ', Fecha, ' - ', TIME_FORMAT(Hora, '%h:%i %p')) AS Celebracion
  FROM tblcelebraciones
  WHERE Estado = 1;

END
$$

--
-- Create procedure `spCelebraciones_ConsultarDisponibilidad`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE spCelebraciones_ConsultarDisponibilidad (IN pCelebracionId int)
BEGIN


  SELECT
    Personas AS Disponible
  FROM tblcelebraciones
  WHERE CelebracionID = pCelebracionId;
END
$$

--
-- Create procedure `spCelebraciones_ActualizarAsientos`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE spCelebraciones_ActualizarAsientos (IN pCelebracionID int, IN pPersonas int)
BEGIN

  IF pPersonas > 0 THEN
    UPDATE tblcelebraciones
    SET Personas = Personas - 1
    WHERE CelebracionID = pCelebracionID;
  END IF;
END
$$

DELIMITER ;

--
-- Create table `tblasistenciaxcelebracion`
--
CREATE TABLE tblasistenciaxcelebracion (
  AsistenciaxcelebracionID int(11) NOT NULL AUTO_INCREMENT,
  MiembroID int(11) DEFAULT NULL,
  CelebracionID int(11) DEFAULT NULL,
  TipoMiembro bit(1) NOT NULL,
  SintomasCovid bit(1) DEFAULT NULL,
  Temperatura int(11) DEFAULT NULL,
  Consentimiento bit(1) DEFAULT NULL,
  Estado bit(1) NOT NULL,
  FechaUltimaActualizacion date DEFAULT NULL,
  PRIMARY KEY (AsistenciaxcelebracionID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 37,
AVG_ROW_LENGTH = 2730,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

DELIMITER $$

--
-- Create procedure `spAsistenciaxcelebracion_VerificarDuplicados`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE spAsistenciaxcelebracion_VerificarDuplicados (IN pMiembroID varchar(255), IN pCelebracionID varchar(255))
BEGIN

  DECLARE cantidad int;

  IF (SELECT
        COUNT(CelebracionID)
      FROM tblasistenciaxcelebracion
      WHERE MiembroID = pMiembroID
      AND CelebracionID = pCelebracionID) > 0 THEN

    SET cantidad = 1;

  ELSE
    SET cantidad = 0;

  END IF;
  SELECT
    cantidad;

END
$$

--
-- Create procedure `spAsistenciaxCelebracion_Actualizar`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE spAsistenciaxCelebracion_Actualizar (IN pAsistenciaxcelebracionID varchar(255), IN pTemperatura varchar(255), IN pFechaUltimaActualizacion date)
BEGIN

  /*SELECT MAX(tblasistenciaxcelebracion.AsistenciaxcelebracionID) WHERE pMiembroID=pMiembroID;*/
  UPDATE tblasistenciaxcelebracion
  SET Temperatura = pTemperatura,
      FechaUltimaActualizacion = pFechaUltimaActualizacion
  WHERE AsistenciaxcelebracionID = pAsistenciaxcelebracionID;

END
$$

--
-- Create procedure `spAsistenciaCelebracion_Guardar`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE spAsistenciaCelebracion_Guardar (IN pMiembroID int, IN pCelebracionID int, IN pTipoMiembro int, IN pSintomasCovid bit, IN pConsentimiento bit)
BEGIN
  INSERT tblasistenciaxcelebracion (MiembroID, CelebracionID, TipoMiembro, SintomasCovid, Consentimiento)
    VALUES (pMiembroID, pCelebracionID, pTipoMiembro, pSintomasCovid, pConsentimiento);
END
$$

DELIMITER ;

--
-- Create table `tbl_miembros`
--
CREATE TABLE tbl_miembros (
  MiembroID int(11) NOT NULL AUTO_INCREMENT,
  Cedula int(11) NOT NULL,
  Nombre varchar(255) DEFAULT NULL,
  Edad int(11) DEFAULT NULL,
  Celular bigint(20) NOT NULL,
  Correo varchar(255) NOT NULL,
  Fecha date DEFAULT NULL,
  Estado bit(1) DEFAULT NULL,
  PRIMARY KEY (MiembroID)
)
ENGINE = INNODB,
AUTO_INCREMENT = 23,
AVG_ROW_LENGTH = 1820,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

DELIMITER $$

--
-- Create procedure `spMiembros_Guardar`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE spMiembros_Guardar (IN pMiembroID int, IN pCedula int, IN pNombre varchar(255), IN pEdad int, IN pCelular bigint, IN pCorreo varchar(255), IN pFecha date)
BEGIN
  DECLARE pID int;

  IF pMiembroID = 0 THEN


    INSERT INTO tbl_miembros (Cedula, Nombre, Edad, Celular, Correo, Fecha)
      VALUES (pCedula, pNombre, pEdad, pCelular, pCorreo, pFecha);

    SET pID = LAST_INSERT_ID();


  ELSE
    UPDATE tbl_miembros
    SET Cedula = pCedula,
        Nombre = pNombre,
        Edad = pEdad,
        Celular = pCelular,
        Correo = pCorreo,
        Fecha = pFecha
    WHERE MiembroID = pMiembroID;

    SET pID = pMiembroID;

  END IF;

  SELECT
    pID;

END
$$

--
-- Create procedure `spMiembros_Buscar`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE spMiembros_Buscar (IN pCedula varchar(255))
BEGIN
  SELECT
    tbl_miembros.MiembroID,
    tbl_miembros.Cedula,
    tbl_miembros.Nombre,
    tbl_miembros.Edad,
    tbl_miembros.Celular,
    tbl_miembros.Correo

  FROM tbl_miembros
  WHERE pCedula = Cedula;
END
$$

--
-- Create procedure `spAsistenciaCelebracion_ConsultarListado`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE spAsistenciaCelebracion_ConsultarListado (IN pNombre varchar(255), IN pCedula varchar(255))
BEGIN
  SET lc_time_names = 'es_ES';
  IF pCedula != '' THEN
    SELECT
      tbl_miembros.MiembroID,
      tbl_miembros.Nombre,
      tbl_miembros.Cedula,
      CONCAT(tblcelebraciones.Tipo, ' ', DAYNAME(tblcelebraciones.Fecha), ' ', tblcelebraciones.Fecha, ' - ', TIME_FORMAT(tblcelebraciones.Hora, '%h:%i %p')) AS Celebracion,
      tbl_miembros.Fecha,
      tbl_miembros.Edad,
      tblasistenciaxcelebracion.AsistenciaxcelebracionID,
      tblasistenciaxcelebracion.Temperatura
    FROM tbl_miembros

      INNER JOIN tblasistenciaxcelebracion
        ON tbl_miembros.MiembroID = tblasistenciaxcelebracion.MiembroID

      INNER JOIN tblcelebraciones
        ON tblcelebraciones.CelebracionID = tblasistenciaxcelebracion.CelebracionID

    WHERE Cedula LIKE CONCAT('%', pCedula, '%')
    ORDER BY Fecha DESC LIMIT 10;
  ELSE
    SELECT
      tbl_miembros.MiembroID,
      tbl_miembros.Nombre,
      tbl_miembros.Cedula,
      CONCAT(tblcelebraciones.Tipo, ' ', DAYNAME(tblcelebraciones.Fecha), ' ', tblcelebraciones.Fecha, ' - ', TIME_FORMAT(tblcelebraciones.Hora, '%h:%i %p')) AS Celebracion,
      tbl_miembros.Fecha,
      tbl_miembros.Edad,
      tblasistenciaxcelebracion.AsistenciaxcelebracionID,
      tblasistenciaxcelebracion.Temperatura
    FROM tbl_miembros
      INNER JOIN tblasistenciaxcelebracion
        ON tbl_miembros.MiembroID = tblasistenciaxcelebracion.MiembroID

      INNER JOIN tblcelebraciones
        ON tblcelebraciones.CelebracionID = tblasistenciaxcelebracion.CelebracionID
    WHERE Nombre LIKE CONCAT('%', pNombre, '%')
    ORDER BY Fecha DESC LIMIT 10;
  END IF;
END
$$

--
-- Create procedure `spAsistenciaCelebracion_BuscarFechas`
--
CREATE DEFINER = 'root'@'localhost'
PROCEDURE spAsistenciaCelebracion_BuscarFechas (IN pFecha1 date, IN pFecha2 date)
BEGIN
  SET lc_time_names = 'es_ES';
  SELECT
    tbl_miembros.Nombre,
    tbl_miembros.Cedula,
    tbl_miembros.Edad,
    CONCAT(tblcelebraciones.Tipo, ' ', DAYNAME(tblcelebraciones.Fecha), ' ', tblcelebraciones.Fecha, ' - ', TIME_FORMAT(tblcelebraciones.Hora, '%h:%i %p')) AS Celebracion,
    tblasistenciaxcelebracion.Temperatura
  FROM tbl_miembros

    INNER JOIN tblasistenciaxcelebracion
      ON tbl_miembros.MiembroID = tblasistenciaxcelebracion.MiembroID

    INNER JOIN tblcelebraciones
      ON tblcelebraciones.CelebracionID = tblasistenciaxcelebracion.CelebracionID

  WHERE tblcelebraciones.Fecha BETWEEN pFecha1 AND pFecha2
  ORDER BY tblcelebraciones.Fecha DESC;

END
$$

DELIMITER ;

-- 
-- Dumping data for table tbl_miembros
--
INSERT INTO tbl_miembros VALUES
(21, 98712884, 'Wilmar Alexander Galvis Arango', 35, 3186892181, 'wilmargalvis@gmail.com', '2021-02-07', NULL),
(22, 1148697622, 'María Jiménez Sánchez', 26, 3057325295, 'mariajimenez.sas@gmail.com', '2021-02-07', NULL);

-- 
-- Dumping data for table tblcelebraciones
--
INSERT INTO tblcelebraciones VALUES
(4, '2021-02-12', '07:00:00', True, NULL, 2, NULL, NULL, 'Servicio'),
(5, '2021-02-13', '07:00:00', True, NULL, 14, NULL, NULL, 'Servicio'),
(6, '2021-02-14', '10:00:00', True, NULL, 13, NULL, NULL, 'Servicio'),
(7, '2021-02-15', '10:00:00', True, NULL, 19, NULL, NULL, 'Kids');

-- 
-- Dumping data for table tblasistenciaxcelebracion
--
INSERT INTO tblasistenciaxcelebracion VALUES
(31, 21, 4, False, True, 37, True, False, '2021-02-07'),
(32, 22, 4, False, True, 38, True, False, '2021-02-07'),
(33, 21, 5, False, True, 35, True, False, '2021-02-07'),
(34, 21, 6, True, True, 15, True, False, '2021-02-06'),
(35, 21, 7, False, True, NULL, True, False, NULL),
(36, 22, 6, True, True, NULL, True, False, NULL);

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;