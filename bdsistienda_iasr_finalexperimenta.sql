-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.32-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para bdsistienda_iasr
CREATE DATABASE IF NOT EXISTS `bdsistienda_iasr` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `bdsistienda_iasr`;

-- Volcando estructura para tabla bdsistienda_iasr.tbcargo
CREATE TABLE IF NOT EXISTS `tbcargo` (
  `idcargo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  `estado` int(11) NOT NULL,
  PRIMARY KEY (`idcargo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla bdsistienda_iasr.tbcargo: ~4 rows (aproximadamente)
INSERT INTO `tbcargo` (`idcargo`, `nombre`, `estado`) VALUES
	(1, 'ADMINISTRADOR', 1),
	(2, 'EMPLEADO', 1),
	(3, 'ALMACENERO', 1),
	(4, 'VENDEDOR', 1);

-- Volcando estructura para tabla bdsistienda_iasr.tbcategoria
CREATE TABLE IF NOT EXISTS `tbcategoria` (
  `idcategoria` int(11) NOT NULL AUTO_INCREMENT,
  `Categoria` varchar(20) NOT NULL DEFAULT '',
  `Estado` int(11) NOT NULL,
  PRIMARY KEY (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla bdsistienda_iasr.tbcategoria: ~5 rows (aproximadamente)
INSERT INTO `tbcategoria` (`idcategoria`, `Categoria`, `Estado`) VALUES
	(1, 'Lateos', 1),
	(2, 'Embutidos', 0),
	(3, 'Cereales', 0),
	(5, 'Carne', 1),
	(6, 'Postres', 1);

-- Volcando estructura para tabla bdsistienda_iasr.tbcliente
CREATE TABLE IF NOT EXISTS `tbcliente` (
  `idcliente` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `idTipoDocumento` int(11) NOT NULL,
  `NumeroDocumento` varchar(50) NOT NULL,
  `Telefono` varchar(50) DEFAULT NULL,
  `Direccion` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Clave` varchar(50) DEFAULT NULL,
  `Estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcliente`),
  KEY `FKTipoDocumento` (`idTipoDocumento`),
  CONSTRAINT `FKTipoDocumento` FOREIGN KEY (`idTipoDocumento`) REFERENCES `tbtipodocumento` (`idtipodocumento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla bdsistienda_iasr.tbcliente: ~4 rows (aproximadamente)
INSERT INTO `tbcliente` (`idcliente`, `Nombre`, `Apellido`, `idTipoDocumento`, `NumeroDocumento`, `Telefono`, `Direccion`, `Email`, `Clave`, `Estado`) VALUES
	(1, 'Rosa', 'Aguilar', 1, '00457898', '979739002', 'Asoc.SanFrancisco', 'stevie_Dave_mks@hotmail.com', '1234', 1),
	(2, 'IGNACIO', 'MARCA', 1, '00457899', '979739002', 'Asoc.SanFrancisco', 'razself@gmail.com', '1234', 0),
	(3, 'Masiel', 'Hurtado', 1, '12345678', '979739002', 'Asoc.SanFrancisco', 'Stemarcaa@upt.pe', '1234', 1),
	(5, 'IKER', 'SIERRA RUIZ', 1, '726642626', '934393796', 'Urb. Bacigalupo', 'is2023077090@virtual.utp.pe', '1243', 1);

-- Volcando estructura para tabla bdsistienda_iasr.tbempleado
CREATE TABLE IF NOT EXISTS `tbempleado` (
  `idEmpleado` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Apellido` varchar(200) NOT NULL,
  `idcargo` int(11) NOT NULL DEFAULT 0,
  `Usuario` varchar(12) NOT NULL DEFAULT '0',
  `Clave` varchar(15) NOT NULL DEFAULT '0',
  `idTipoDocumento` int(11) NOT NULL DEFAULT 0,
  `NumeroDocumento` varchar(10) NOT NULL DEFAULT '0',
  `Telefono` varchar(9) NOT NULL,
  `Estado` int(11) NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  KEY `FKCARGO` (`idcargo`),
  KEY `FKTIPDOCUEMNTO` (`idTipoDocumento`),
  CONSTRAINT `FKCARGO` FOREIGN KEY (`idcargo`) REFERENCES `tbcargo` (`idcargo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FKTIPDOCUEMNTO` FOREIGN KEY (`idTipoDocumento`) REFERENCES `tbtipodocumento` (`idtipodocumento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla bdsistienda_iasr.tbempleado: ~4 rows (aproximadamente)
INSERT INTO `tbempleado` (`idEmpleado`, `Nombre`, `Apellido`, `idcargo`, `Usuario`, `Clave`, `idTipoDocumento`, `NumeroDocumento`, `Telefono`, `Estado`) VALUES
	(1, 'Stevie', 'Marca', 1, 'stevie', '123456', 1, '72405382', '979739029', 1),
	(2, 'Jose', 'Tarqui', 2, 'Jose', '123456', 2, '11', '11', 1),
	(5, 'IKER', 'SIERRA RUIZ', 1, 'piker', '1234', 1, '12344567', '934393796', 1),
	(6, 'jerry', 'rivera', 2, 'jeri', '1234', 1, '12341234', '12342134', 1);

-- Volcando estructura para tabla bdsistienda_iasr.tbproducto
CREATE TABLE IF NOT EXISTS `tbproducto` (
  `idProducto` int(11) NOT NULL AUTO_INCREMENT,
  `idcategoria` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL DEFAULT '',
  `Cantidad` int(11) NOT NULL,
  `PrecioUnitario` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `Estado` int(11) NOT NULL,
  PRIMARY KEY (`idProducto`),
  KEY `FKCategoria` (`idcategoria`),
  CONSTRAINT `FKCategoria` FOREIGN KEY (`idcategoria`) REFERENCES `tbcategoria` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla bdsistienda_iasr.tbproducto: ~2 rows (aproximadamente)
INSERT INTO `tbproducto` (`idProducto`, `idcategoria`, `Nombre`, `Cantidad`, `PrecioUnitario`, `Estado`) VALUES
	(1, 5, 'Carnerica', 20, 5.000000, 1),
	(7, 1, 'Gloria', 119, 23.300000, 1);

-- Volcando estructura para tabla bdsistienda_iasr.tbtipodocumento
CREATE TABLE IF NOT EXISTS `tbtipodocumento` (
  `idtipodocumento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`idtipodocumento`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla bdsistienda_iasr.tbtipodocumento: ~2 rows (aproximadamente)
INSERT INTO `tbtipodocumento` (`idtipodocumento`, `nombre`) VALUES
	(1, 'DNI'),
	(2, 'PASAPORTE');

-- Volcando estructura para tabla bdsistienda_iasr.tbusuarios
CREATE TABLE IF NOT EXISTS `tbusuarios` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  `Clave` varchar(50) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Volcando datos para la tabla bdsistienda_iasr.tbusuarios: ~2 rows (aproximadamente)
INSERT INTO `tbusuarios` (`idUsuario`, `Nombre`, `Clave`, `tipo`) VALUES
	(1, 'jeri', '1234', 'empleado'),
	(2, 'iker', '1234', 'cliente');

-- Volcando estructura para disparador bdsistienda_iasr.after_delete_cliente
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `after_delete_cliente` AFTER DELETE ON `tbcliente` FOR EACH ROW BEGIN
    DELETE FROM tbusuarios 
    WHERE Nombre = OLD.Email AND tipo = 'cliente';
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador bdsistienda_iasr.after_delete_empleado
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `after_delete_empleado` AFTER DELETE ON `tbempleado` FOR EACH ROW BEGIN
    DELETE FROM tbusuarios 
    WHERE Nombre = OLD.Usuario AND tipo = 'empleado';
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador bdsistienda_iasr.after_insert_cliente
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `after_insert_cliente` AFTER INSERT ON `tbcliente` FOR EACH ROW BEGIN
    IF NEW.Estado = 1 AND NEW.Email IS NOT NULL AND NEW.Clave IS NOT NULL THEN
        INSERT INTO tbusuarios (Nombre, Clave, tipo)
        VALUES (NEW.Email, NEW.Clave, 'cliente')
        ON DUPLICATE KEY UPDATE 
            Clave = NEW.Clave,
            tipo = 'cliente';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador bdsistienda_iasr.after_insert_empleado
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `after_insert_empleado` AFTER INSERT ON `tbempleado` FOR EACH ROW BEGIN
IF NEW.Estado = 1 AND NEW.Usuario IS NOT NULL AND NEW.Clave IS NOT NULL THEN
        INSERT INTO tbusuarios (Nombre, Clave, tipo)
        VALUES (NEW.Usuario, NEW.Clave, 'empleado')
        ON DUPLICATE KEY UPDATE 
            Clave = NEW.Clave,
            tipo = 'empleado';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador bdsistienda_iasr.after_update_cliente
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `after_update_cliente` AFTER UPDATE ON `tbcliente` FOR EACH ROW BEGIN
    IF OLD.Estado = 1 AND NEW.Estado = 0 THEN
        DELETE FROM tbusuarios 
        WHERE Nombre = OLD.Email AND tipo = 'cliente';
    ELSEIF OLD.Estado = 0 AND NEW.Estado = 1 THEN
        IF NEW.Email IS NOT NULL AND NEW.Clave IS NOT NULL THEN
            INSERT INTO tbusuarios (Nombre, Clave, tipo)
            VALUES (NEW.Email, NEW.Clave, 'cliente')
            ON DUPLICATE KEY UPDATE 
                Clave = NEW.Clave,
                tipo = 'cliente';
        END IF;
    ELSEIF NEW.Estado = 1 THEN
        IF OLD.Email != NEW.Email THEN
            DELETE FROM tbusuarios 
            WHERE Nombre = OLD.Email AND tipo = 'cliente';
            
            IF NEW.Email IS NOT NULL AND NEW.Clave IS NOT NULL THEN
                INSERT INTO tbusuarios (Nombre, Clave, tipo)
                VALUES (NEW.Email, NEW.Clave, 'cliente');
            END IF;
        ELSE
            UPDATE tbusuarios 
            SET Clave = NEW.Clave
            WHERE Nombre = NEW.Email AND tipo = 'cliente';
        END IF;
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador bdsistienda_iasr.after_update_empleado
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `after_update_empleado` AFTER UPDATE ON `tbempleado` FOR EACH ROW BEGIN
    IF OLD.Estado = 1 AND NEW.Estado = 0 THEN
        DELETE FROM tbusuarios 
        WHERE Nombre = OLD.Usuario AND tipo = 'empleado';
    ELSEIF OLD.Estado = 0 AND NEW.Estado = 1 THEN
        IF NEW.Usuario IS NOT NULL AND NEW.Clave IS NOT NULL THEN
            INSERT INTO tbusuarios (Nombre, Clave, tipo)
            VALUES (NEW.Usuario, NEW.Clave, 'empleado')
            ON DUPLICATE KEY UPDATE 
                Clave = NEW.Clave,
                tipo = 'empleado';
        END IF;
    ELSEIF NEW.Estado = 1 THEN
        IF OLD.Usuario != NEW.Usuario THEN
            DELETE FROM tbusuarios 
            WHERE Nombre = OLD.Usuario AND tipo = 'empleado';
            
            IF NEW.Usuario IS NOT NULL AND NEW.Clave IS NOT NULL THEN
                INSERT INTO tbusuarios (Nombre, Clave, tipo)
                VALUES (NEW.Usuario, NEW.Clave, 'empleado');
            END IF;
        ELSE
            UPDATE tbusuarios 
            SET Clave = NEW.Clave
            WHERE Nombre = NEW.Usuario AND tipo = 'empleado';
        END IF;
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
