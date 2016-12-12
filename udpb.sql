-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: udpb
-- ------------------------------------------------------
-- Server version	5.5.43-0+deb7u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `password` varchar(512) NOT NULL,
  `group` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'student','32ade5e7c36fa329ea39dbc352743db40da5aa7460ec55f95b999d6371ad20170094d88d9296643f192e9d5433b8d6d817d6777632e556e96e58f741dc5b3550',9),(2,'lama','32ade5e7c36fa329ea39dbc352743db40da5aa7460ec55f95b999d6371ad20170094d88d9296643f192e9d5433b8d6d817d6777632e556e96e58f741dc5b3550',8);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(512) NOT NULL,
  `content` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `author` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES (2,'Second article','<br>\r\nA1 - Injection: Technika napadnutia databázové servery vsunutím kódu cez neošetrený\r\nvstup a vloženie pozmeneného SQL odkazu. V Search forme a tak isto aj v prihlasovacom forme je pritomná zranitelnosť typu SQLi. Ak zadáte nasledujúci payload do Search formulára dostanete sa k hashu jedného z používateľov - %\" UNION SELECT ALL 1,concat(password,char(58)),3,4,5,6 from admins where name=\'student\'--  (posledný znak, musí byť whitespace). Existuje niekoľko spôsobov ako zabrániť tomuto útoku. Medzi najlepšie patrí takzvané PDO. Implementujte ochranu voči SQLi na prihlasovací formulár a id parameter v URL. Vhodný tutoriál nájdete na: http://php.net/manual/en/mysqli.prepare.php\r\n<br>\r\n<br>\r\nA2 - Broken Authentication and Session Management: Táto zranitelnosť umožňuje útok na\r\nprihlasovacie časti aplikácie. Je nutné zamerať sa na predávanie autentifikačných údajov a bezpečné\r\núložisko identifikátora relácie. V linke, ktorá je vyvolaná po stlačení odhlasovacieho tlačidla je zverejnená sessionid, ktorá by mala byť uchovaná v tajnosti, jej prítomnosť v GET parametri otvára útočníkom možnosť nájsť platné sessionID na proxy serveroch cez, ktoré putuje použiadavka alebo aj v lokálnych logoch. Príklad: GET /?page=logout.php&session_id=5tk8tsccght7gvt9jgh6nj9336&go_page=index.php \r\n<br>\r\n<br>\r\nA3 - XSS: metóda narušenia WWW stránok, ktorá využíva chyby v skriptoch.\r\nÚtočník vďaka chybám podstrčí do stránok vlastný kód, čo vyvoláva poškodenie vzhľadu stránok, ich\r\nznefunkčnenie, získavanie citlových údajov návstevníkov stránok, obídenie bezpečnostných prvkov\r\naplikácie a phishing. V prípade, že do Search formulára zadáte nasledujúci payload, vyvoláte útok typu Reflected XSS. Pomocou tohto útoku (s prispením sociálneho inžinierstva ) - <script>alert(document.cookie)</script>\r\nNa odstránenie tejto zraniteľnosti odporúčame nahradiť nebezpečné znaky escape sekvenciami. V PHP je možné escapovať nebezpečné znaky pomocou funkcie htmlspecialchars. <br> Bližšie informácie nájdete na: http://www.w3schools.com/php/func_string_htmlspecialchars.asp\r\n<br>\r\n<br>\r\nA4 - Insecure Direct Object References - V prípade, že sa pokúsite načítať nasledujúcu linku poradrí sa Vám získať prístup k súboru, kam by ste sa za normálnych okolností nemali nikdy dostať. Táto zraniteľnosť typu LFI (local file inclusion) spočíva v nesprávnom includovaní (vyžadovaní) súborov. \r\nhttp://192.168.56.102/udpb/www-vulnerable/?page=../../../../../etc/passwd\r\n<br>\r\nZabrániť tomuto útoku je možné vhodným ošetrením vstupov, ktoré idú do funkcie include() alebo require().\r\n<br>\r\n<br>\r\nA5 - Security Misconfiguration: Dobré zabezpečenie musí mať zabezpečené konfigurácie\r\nnasadené pre aplikácie, frameworky, aplikačné, webové a databázové servery a platformy, Tiež je\r\nnevyhnutné aktualizovanie softwearu.Keď zadáte nasledujúcu linku do prehliadača, zistíte, že je zapnutý dir listing. http://192.168.56.102/udpb/www-vulnerable/images/\r\nNa zabránenie tohto typu útoku odporúčame vytvoriť .htaccess, ktorý bráni dir listingu.\r\n<br>\r\n<br>\r\nA6 - Sensitive Data Exposure: Niektoré aplikácie nesprávne chránia citlivé dáta, preto\r\nmôžu mať k nim útočníci ľahký prístup. Tieto dáta si vyžadujú osobitnú ochranu. Prihlasovacie údaje sa prenášajú cez nezabezpečený HTTP protokol cez GET /udpb/www-vulnerable/index.php?name=student&pass=student&logIN=1.Odporúčame prerobiť prihlasovací formulár na POST a použiť SSL na vytvorenie zabezpečeného spojenia tzv. HTTPS.\r\n<br>\r\nhttps://www.digitalocean.com/community/tutorials/how-to-create-a-ssl-certificate-on-apache-for-ubuntu-14-04\r\n<br>\r\n<br>\r\nA7 - Missing Function Level Access Control: ak aplikácia umožňuje neautentifikovaný\r\nprístup k stránkam, ku ktorým by mal byť povolený prístup iba po autetintifikácii, existuje\r\nzranitelnosť, keď odkazovaná zobrazí informácie, ktoré majú byť prístupné iba autentifikovaným\r\nužívateľom. Zraniteľnosť tohto webu spočíva v tom, že útočník je schopný načítať obsah stránok aj bez toho aby bol prihlásený. <br> \r\nNapríklad:\r\nhttp://192.168.56.102/udpb/www-vulnerable/content/home.php?id=2 <br>\r\nZabrániť tomuto typu útoku je možné vhodnou implementáciou autentifikácie. \r\n<br> \r\n<br>\r\nA8 - Cross-Site Request Forgery (CSRF): Technika umožňujúca útočníkovi podvrhnúť formulár na\r\ninej stránke alebo pomocou HTTP metódy presmerovať prehliadač obete na script spracujúci legitímny\r\nformulár dátovej aplikácie, ktorá poškodzuje obeť. Na kontaktnom a prihlasovacom formuláre nie sú implementované CSRF tokeny. Proof of concept tohto útoku je dostupný na http://192.168.56.102/udpb/www-vulnerable/poc.html. Medzi vhodné nástroje na odstránenie tohto útočného vektora patrí implementácia CSRF tokenov na kontaktný formulár a prihlasovanie. Vhodný tutoriál je možné nájsť na  http://www.wikihow.com/Prevent-Cross-Site-Request-Forgery-(CSRF)-Attacks-in-PHP\r\n<br>\r\n<br>\r\nA9 - Using Components with Known Vulnerabilities:  Komponenty softwérových modulov bývaju často\r\nspustené s úplnými oprávneniami. Pri využití chybných komponentov môže uľahčiť stratu dát alebo\r\npoškodenie serverov. Ďalším problémom býva použitie komponentov, ktoré sú nezaplátané a trpia rôznymi zraniteľnosťami. Preto sa vždy uistite, že používate aktuálne komponenty a frameworky na vývoj.\r\n<br>\r\nRef: https://www.owasp.org/index.php/Top_10_2013-A9-Using_Components_with_Known_Vulnerabilities\r\n<br>\r\n<br>\r\nA10 - Unvalidated Redirects and Forwards: Webové aplikácie často presmerujú užívateľa na\r\niné stránky a použijú nedoveryhodné údaje na určenie cieľovej stránky. Bez správneho overenia može\r\nútočník presmerovať obeť na phishing alebo malware stránky. <br>\r\nPríklad zraniteľnosti tohto webu: \r\nGET /?page=logout.php&session_id=5tk8tsccght7gvt9jgh6nj9336&go_page=http//citadelo.com ','2015-06-15 13:12:39',1,1),(3,'Ooooo this is number three','Donec sodales nibh metus, sit amet fermentum dui aliquet vitae. Cras at tempus nibh, tempor vestibulum sem. Vestibulum auctor, dui eget euismod tincidunt, dolor elit venenatis ante, condimentum scelerisque orci mauris ac ex. Maecenas vel massa erat. Nulla ac quam ut ex vulputate ultricies. Aenean rhoncus ex vitae augue commodo, quis dignissim massa accumsan. Pellentesque mattis tincidunt sem vitae pulvinar. Sed tincidunt sollicitudin tellus, sit amet imperdiet ipsum semper ut. Nullam nec nunc sit amet felis pulvinar consectetur eget non odio. Aenean vitae justo nec lacus varius placerat eu in tortor. Suspendisse tellus mi, fringilla ut molestie quis, ornare dignissim diam.\r\n\r\nProin eget condimentum nibh. Cras ultricies, nisl at eleifend tincidunt, felis quam efficitur mi, vitae lobortis nulla ipsum ut nulla. Nulla facilisi. Aliquam dictum urna eget dolor malesuada suscipit. Mauris id lacus id urna commodo pulvinar. Vivamus eget arcu nulla. Mauris aliquet mollis nisl vitae viverra. Cras maximus eleifend magna, non maximus orci hendrerit eu. Fusce eget luctus mi, id porttitor quam.\r\n\r\nMaecenas sollicitudin, nunc id faucibus bibendum, quam eros congue purus, quis varius massa ligula in felis. Morbi in fermentum quam. Aliquam erat volutpat. Aenean et lacus et nunc condimentum ultricies. Sed vel cursus enim, non tristique nunc. Phasellus vel tortor ut sem porta sollicitudin nec et leo. Suspendisse iaculis tortor lectus, eget commodo ligula tincidunt a.','2015-02-28 23:29:37',1,0),(4,'Confidential (For admin purposes)','Donec sodales nibh metus, sit amet fermentum dui aliquet vitae. Cras at tempus nibh, tempor vestibulum sem. Vestibulum auctor, dui eget euismod tincidunt, dolor elit venenatis ante, condimentum scelerisque orci mauris ac ex. Maecenas vel massa erat. Nulla ac quam ut ex vulputate ultricies. Aenean rhoncus ex vitae augue commodo, quis dignissim massa accumsan. Pellentesque mattis tincidunt sem vitae pulvinar. Sed tincidunt sollicitudin tellus, sit amet imperdiet ipsum semper ut. Nullam nec nunc sit amet felis pulvinar consectetur eget non odio. Aenean vitae justo nec lacus varius placerat eu in tortor. Suspendisse tellus mi, fringilla ut molestie quis, ornare dignissim diam.\r\n\r\nProin eget condimentum nibh. Cras ultricies, nisl at eleifend tincidunt, felis quam efficitur mi, vitae lobortis nulla ipsum ut nulla. Nulla facilisi. Aliquam dictum urna eget dolor malesuada suscipit. Mauris id lacus id urna commodo pulvinar. Vivamus eget arcu nulla. Mauris aliquet mollis nisl vitae viverra. Cras maximus eleifend magna, non maximus orci hendrerit eu. Fusce eget luctus mi, id porttitor quam.\r\n\r\nMaecenas sollicitudin, nunc id faucibus bibendum, quam eros congue purus, quis varius massa ligula in felis. Morbi in fermentum quam. Aliquam erat volutpat. Aenean et lacus et nunc condimentum ultricies. Sed vel cursus enim, non tristique nunc. Phasellus vel tortor ut sem porta sollicitudin nec et leo. Suspendisse iaculis tortor lectus, eget commodo ligula tincidunt a.','2015-06-07 17:12:56',1,0),(5,'Welcome ','Vitaj na cvičení. Pokiaľ si sa dostal až po tento článok, úspešne sa ti podarilo spustiť virtualku k čomu ti gratulujem. Pred sebou vidíš zraniteľný web. Web, ktorý naprogramoval nešikovný kolega pred tebou a teba bohužiaľ poverili aby si čo najrýchlejšie zaplátal všetky zraniteľnosti, na ktoré narazíš.\r\n<br>\r\n<br>\r\nZdrojové kódy nájdeš keď sa pripojíš cez terminál pomocou ssh\r\n<br>\r\nssh student@192.168.56.102\r\n<br>\r\npassword je student\r\n<br>\r\nCesta k zdrojákom: /var/www/\r\n<br>\r\nPayloady k jednotlivým zraniteľnostiam nájdeš v nasledujúcom článku.\r\n','2015-06-15 11:50:28',1,1);
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-12 11:26:36
