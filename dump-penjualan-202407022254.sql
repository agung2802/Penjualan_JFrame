-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: penjualan
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `log_stok`
--

DROP TABLE IF EXISTS `log_stok`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_stok` (
  `nama_barang` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `stok_out` int NOT NULL,
  `stok_in` int NOT NULL,
  `total_stok` int NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_stok`
--

LOCK TABLES `log_stok` WRITE;
/*!40000 ALTER TABLE `log_stok` DISABLE KEYS */;
INSERT INTO `log_stok` VALUES ('test',3,0,190,'2024-07-02'),('sepatu',0,0,20,'2024-07-02'),('sepatu',5,0,15,'2024-07-02'),('sepatu',5,0,15,'2024-07-02'),('sepatu',0,5,20,'2024-07-02'),('sepatu',5,0,15,'2024-07-02'),('sepatu',2,0,13,'2024-07-02'),('sepatu',2,0,13,'2024-07-02'),('baju',0,0,10,'2024-07-02'),('baju',5,0,5,'2024-07-02'),('baju',0,10,15,'2024-07-02'),('baju',2,0,13,'2024-07-02'),('baju',0,2,15,'2024-07-02'),('baju',3,0,12,'2024-07-02'),('baju',3,0,12,'2024-07-02'),('baju',0,0,0,'2024-07-02');
/*!40000 ALTER TABLE `log_stok` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_barang`
--

DROP TABLE IF EXISTS `tbl_barang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_barang` (
  `kd_barang` varchar(10) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `jumlah_barang` int NOT NULL,
  `harga_beli` int NOT NULL,
  `harga_jual` int NOT NULL,
  `tanggal_masuk` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_barang`
--

LOCK TABLES `tbl_barang` WRITE;
/*!40000 ALTER TABLE `tbl_barang` DISABLE KEYS */;
INSERT INTO `tbl_barang` VALUES ('B0001','test',190,2000,1500,'2024-06-26'),('B0002','sepatu',13,20000,30000,'2024-07-02');
/*!40000 ALTER TABLE `tbl_barang` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_log_insert_barang` AFTER INSERT ON `tbl_barang` FOR EACH ROW BEGIN
INSERT INTO log_stok (nama_barang, stok_out, stok_in, total_stok, tanggal)
values (new.nama_barang, 0, 0, new.jumlah_barang, current_date());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_stok_update` AFTER UPDATE ON `tbl_barang` FOR EACH ROW BEGIN
    DECLARE stock_difference INT;

    -- Calculate the difference in stock
    SET stock_difference = NEW.jumlah_barang - OLD.jumlah_barang;

    -- If the stock increased
    IF stock_difference > 0 THEN
        INSERT INTO log_stok (nama_barang, stok_out, stok_in, total_stok, tanggal)
        VALUES (NEW.nama_barang, 0, stock_difference, NEW.jumlah_barang, CURRENT_DATE());
    -- If the stock decreased
    ELSEIF stock_difference < 0 THEN
        INSERT INTO log_stok (nama_barang, stok_out, stok_in, total_stok, tanggal)
        VALUES (NEW.nama_barang, ABS(stock_difference), 0, NEW.jumlah_barang, CURRENT_DATE());
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_log_delete_barang` AFTER DELETE ON `tbl_barang` FOR EACH ROW BEGIN
INSERT INTO log_stok (nama_barang, stok_out, stok_in, total_stok, tanggal)
values (old.nama_barang, 0, 0, 0, current_date());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbl_hitung_jual`
--

DROP TABLE IF EXISTS `tbl_hitung_jual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_hitung_jual` (
  `id_hitung` int NOT NULL,
  `kd_barang` varchar(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `hsatuan` int NOT NULL,
  `jumlah_jual` int NOT NULL,
  `harga` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_hitung_jual`
--

LOCK TABLES `tbl_hitung_jual` WRITE;
/*!40000 ALTER TABLE `tbl_hitung_jual` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_hitung_jual` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_jual` AFTER INSERT ON `tbl_hitung_jual` FOR EACH ROW BEGIN
UPDATE tbl_barang set jumlah_barang = jumlah_barang - new.jumlah_jual
WHERE kd_barang = new.kd_barang;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_batal` AFTER DELETE ON `tbl_hitung_jual` FOR EACH ROW BEGIN
UPDATE tbl_barang set jumlah_barang = jumlah_barang + old.jumlah_jual
WHERE kd_barang = old.kd_barang;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbl_login`
--

DROP TABLE IF EXISTS `tbl_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_login` (
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `jenis_kelamin` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_telp` int NOT NULL,
  `agama` varchar(30) NOT NULL,
  `alamat` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_login`
--

LOCK TABLES `tbl_login` WRITE;
/*!40000 ALTER TABLE `tbl_login` DISABLE KEYS */;
INSERT INTO `tbl_login` VALUES ('rizki','agung','Perempuan','test',12312,'Islam','test'),('herma','agung','Perempuan','testt',1232122,'Kristen','testt'),('rizki','123','Laki-laki','123',123,'Islam','123	');
/*!40000 ALTER TABLE `tbl_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_penjualan`
--

DROP TABLE IF EXISTS `tbl_penjualan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_penjualan` (
  `nofaktur` varchar(11) NOT NULL,
  `kd_barang` varchar(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `hsatuan` int NOT NULL,
  `jumlah_jual` int NOT NULL,
  `harga` int NOT NULL,
  `bayar` int NOT NULL,
  `kembalian` int NOT NULL,
  `tanggal` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_penjualan`
--

LOCK TABLES `tbl_penjualan` WRITE;
/*!40000 ALTER TABLE `tbl_penjualan` DISABLE KEYS */;
INSERT INTO `tbl_penjualan` VALUES ('F0001','B0001','test',1500,3,4500,5000,500,'2024-07-02'),('F0002','B0002','sepatu',30000,5,150000,200000,50000,'2024-07-02'),('F0003','B0002','sepatu',30000,2,60000,70000,10000,'2024-07-02'),('F0004','B0003','baju',3000,3,9000,10000,1000,'2024-07-02');
/*!40000 ALTER TABLE `tbl_penjualan` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_stok_out` AFTER INSERT ON `tbl_penjualan` FOR EACH ROW BEGIN
    DECLARE total_stock INT;

    -- Select the total stock from tbl_barang where the kd_barang matches the new.kd_barang
    SELECT jumlah_barang INTO total_stock
    FROM tbl_barang 
    WHERE kd_barang = NEW.kd_barang;

    -- Insert the relevant data into the log_stok table
    INSERT INTO log_stok (nama_barang, stok_out, stok_in, total_stok, tanggal)
    VALUES (NEW.nama_barang, NEW.jumlah_jual, 0, total_stock, NEW.tanggal);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'penjualan'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-02 22:54:45
