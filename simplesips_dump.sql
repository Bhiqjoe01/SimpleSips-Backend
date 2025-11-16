-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: new
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
-- Table structure for table `api_cart`
--

DROP TABLE IF EXISTS `api_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_cart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quantity` int(10) unsigned NOT NULL CHECK (`quantity` >= 0),
  `added_at` datetime(6) NOT NULL,
  `cartItem_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `api_cart_cartItem_id_3f91b99e_fk_api_item_id` (`cartItem_id`),
  KEY `api_cart_user_id_79972181_fk_auth_user_id` (`user_id`),
  CONSTRAINT `api_cart_cartItem_id_3f91b99e_fk_api_item_id` FOREIGN KEY (`cartItem_id`) REFERENCES `api_item` (`id`),
  CONSTRAINT `api_cart_user_id_79972181_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_cart`
--

LOCK TABLES `api_cart` WRITE;
/*!40000 ALTER TABLE `api_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_category`
--

DROP TABLE IF EXISTS `api_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_category`
--

LOCK TABLES `api_category` WRITE;
/*!40000 ALTER TABLE `api_category` DISABLE KEYS */;
INSERT INTO `api_category` VALUES (1,'Beer'),(2,'Milkshake'),(3,'Vodka'),(4,'Whiskey'),(5,'Coffee'),(6,'Smothies'),(7,'Water'),(8,'Cocktails');
/*!40000 ALTER TABLE `api_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_item`
--

DROP TABLE IF EXISTS `api_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(10) unsigned NOT NULL CHECK (`stock` >= 0),
  `count` int(10) unsigned NOT NULL CHECK (`count` >= 0),
  `ctreated_at` datetime(6) NOT NULL,
  `isavailable` tinyint(1) NOT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `slug` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `api_item_category_id_77533105_fk_api_category_id` (`category_id`),
  CONSTRAINT `api_item_category_id_77533105_fk_api_category_id` FOREIGN KEY (`category_id`) REFERENCES `api_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_item`
--

LOCK TABLES `api_item` WRITE;
/*!40000 ALTER TABLE `api_item` DISABLE KEYS */;
INSERT INTO `api_item` VALUES (1,'Tequilla','item/A_bottle_of_tequila_next_to_a_glass_of_whiskey_ZjXO6zE.jpeg','Tequila is a distilled spirit made primarily from the blue Weber agave plant grown in specific regions of Mexico, mainly around the city of Tequila in Jalisco. It’s known for its earthy, slightly sweet, and peppery flavor with herbal and citrus notes.',34.99,50,6,'2025-10-10 00:58:47.954257',1,4,'tequilla'),(2,'Absolut Citron Recipies','item/Absolut_Citron_Recipes_kpBhycL.jpeg','Absolut Citron is a smooth, premium vodka infused with natural lemon and lime flavors. It delivers a bright, zesty aroma with a clean citrus taste and a soft, refreshing finish. Known for its purity and balanced character, it’s perfect for cocktails like the Cosmopolitan or Lemon Drop Martini, or simply served chilled over ice.',32.43,50,0,'2025-10-10 01:00:31.751465',1,3,'absolut-citron-recipies'),(3,'Apleton Estsate','item/Apleton_estate_n9pFCw7.jpeg','Appleton Estate is a rich, full-bodied rum crafted from carefully selected sugarcane and aged in oak barrels under Jamaica’s tropical climate. Known for its deep amber color and smooth texture, it offers layered aromas of molasses, toasted oak, vanilla, and dried fruit. The taste is warm, slightly sweet, and complex, with hints of spice, caramel, and orange peel.\r\nEvery sip reflects centuries of Jamaican rum-making tradition — bold, aromatic, and perfectly balanced.',19.44,50,0,'2025-10-10 01:02:09.724670',1,4,'apleton-estsate'),(4,'Baileys','item/Baileys_JlICpyZ.jpeg','Baileys is a world-famous Irish cream liqueur made from rich dairy cream, Irish whiskey, and hints of cocoa and vanilla. It’s smooth, velvety, and indulgent — offering a perfect balance of sweetness and warmth. The aroma is creamy and chocolatey, with a light whiskey finish that makes it ideal for sipping neat, over ice, or mixing into coffee and desserts.',32.40,50,0,'2025-10-10 01:03:28.347981',1,4,'baileys'),(5,'Balvenie Whiskey','item/Balvenie_whiskey_xPDtVZ7.jpeg','The Balvenie is a handcrafted single malt Scotch whisky known for its smooth, honeyed flavor and traditional production methods. Distilled using home-grown barley and aged in oak casks, it delivers a warm bouquet of honey, vanilla, and oak, with notes of dried fruit and spice. Each expression — from the DoubleWood 12 to the Caribbean Cask 14 — showcases Balvenie’s signature depth, balance, and craftsmanship. It’s refined yet approachable, perfect for slow sipping or special occasions.',78.50,50,0,'2025-10-10 01:04:42.330085',1,4,'balvenie-whiskey'),(6,'Black Label Whiskey','item/black_label_4LTR9KG.jpeg','Johnnie Walker Black Label is a world-renowned blended Scotch crafted from whiskies aged for at least 12 years. It offers a deep, smooth flavor with layers of smoky malt, rich vanilla, dried fruit, and hints of spice. The aroma carries notes of sweet wood smoke and caramel, leading to a long, warming finish. Balanced and versatile, it’s perfect for sipping neat, on the rocks, or in premium cocktails like a Whisky Sour or Old Fashioned.',45.95,50,0,'2025-10-10 01:06:07.898509',1,4,'black-label-whiskey'),(7,'Blanton\'s','item/blantines_X7PAqpZ.jpeg','Blanton’s is the original single barrel bourbon, hand-bottled from carefully selected casks at Buffalo Trace Distillery. It’s rich, smooth, and complex — delivering bold aromas of vanilla, caramel, and honey, layered with warm oak, orange peel, and spice. The taste is full-bodied with a silky mouthfeel and a long, slightly sweet finish. Each bottle comes from one unique barrel, making every pour a distinct experience.',194.30,50,0,'2025-10-10 01:07:37.085239',1,4,'blantons'),(9,'Bourbon Whiskey','item/Bourbon_whiskey_0NrK8V7.jpeg','Bourbon is a rich, full-bodied whiskey made primarily from corn (at least 51%) and aged in charred new oak barrels. It delivers sweet vanilla, caramel, and oak flavors, balanced with notes of spice, toffee, and sometimes hints of fruit or smoke. Known for its smooth, warm finish, bourbon can be enjoyed neat, on the rocks, or as the base for classic cocktails like the Old Fashioned, Manhattan, or Mint Julep.',49.00,50,0,'2025-10-10 01:09:57.679791',1,4,'bourbon-whiskey'),(10,'Blue Label Whiskey','item/bule_label.jpeg','Johnnie Walker Blue Label is the ultimate expression of the brand, blending some of Scotland’s rarest and most exceptional whiskies. It is luxuriously smooth and complex, with layers of honey, vanilla, dark chocolate, dried fruit, and subtle smoke. The aroma is rich and inviting, leading to a long, velvety finish. Each bottle is individually numbered, representing craftsmanship, rarity, and sophistication.',230.00,50,0,'2025-10-10 01:19:57.680502',1,4,'blue-label-whiskey'),(11,'Captain Morgan','item/CAptain_morgan_wjFh54s.jpeg','Captain Morgan is a smooth, flavorful spiced rum crafted with a blend of Caribbean rums and natural spices. It offers warm notes of vanilla, caramel, and cinnamon, balanced with a hint of oak and tropical fruit. Its slightly sweet and aromatic profile makes it perfect for sipping neat, over ice, or in cocktails like the Rum & Cola, Mai Tai, or Mojito.',28.98,50,0,'2025-10-10 01:20:57.426007',1,4,'captain-morgan'),(12,'Chivas Regal','item/chivas_regal_LsM0ald.jpeg','Chivas Regal is a smooth, rich blended Scotch whisky, crafted from a selection of mature malt and grain whiskies. It offers a creamy, honeyed aroma with hints of vanilla, orchard fruits, and toasted oak, leading to a balanced and mellow flavor with a gentle, lingering finish. Known for its elegance and approachable character, Chivas Regal is ideal for sipping neat, on the rocks, or in refined cocktails.',47.60,50,0,'2025-10-10 01:22:19.032833',1,4,'chivas-regal'),(13,'GlenDronach','item/Glendronach_0VBw9pv.jpeg','GlenDronach is a richly sherried single malt whisky renowned for its full-bodied, robust flavor profile. Aged in a combination of Oloroso and Pedro Ximénez sherry casks, it delivers layers of dark fruits, raisins, toffee, chocolate, and subtle spice. The aroma is deep and warming, and the finish is long, smooth, and complex — perfect for sipping neat or savoring slowly by the fire.',89.22,50,0,'2025-10-10 01:24:32.208264',1,4,'glendronach'),(14,'Glenlivet XXV','item/Glenliivet_xxvi_2mZf7zL.jpeg','The Glenlivet 25 Year Old is a rare and exquisite single malt, aged a quarter-century to achieve unparalleled depth and elegance. It features a rich bouquet of dried fruits, honey, toasted oak, and subtle spices, complemented by notes of vanilla, citrus, and a whisper of smoke. The palate is exceptionally smooth and complex, with a long, luxurious finish that embodies the mastery of Speyside whisky-making.',1344.66,50,0,'2025-10-10 01:25:53.848437',1,4,'glenlivet-xxv'),(15,'Glenlivet  Whiskey','item/Glenlivet_whiskey_EK3Ndoa.jpeg','The Glenlivet is a classic Speyside single malt known for its smooth, elegant character. It offers a delicate balance of fruit, floral, and honeyed notes with hints of vanilla, citrus, and light oak. The aroma is inviting and gentle, while the palate is soft, slightly sweet, and easy-drinking, making it perfect for both new whisky drinkers and seasoned connoisseurs. Ideal neat, on the rocks, or in refined whisky cocktails.',56.39,50,0,'2025-10-10 01:26:55.640920',1,4,'glenlivet-whiskey'),(16,'Habiki','item/habiki_TjW2MRL.jpeg','Hibiki is a harmonious and refined Japanese blended whisky, crafted from a mix of malt and grain whiskies from Suntory’s distilleries. It’s renowned for its elegant balance, floral aromas, and smooth, sweet character, featuring notes of honey, orange peel, white chocolate, and delicate oak. The finish is long, silky, and exceptionally soft, reflecting Japanese craftsmanship and attention to detail. Perfect neat or with a splash of water to enjoy its full complexity.',167.90,60,0,'2025-10-10 01:28:12.890371',1,4,'habiki'),(17,'Imperial Blue','item/Imperial_blue-whiskey_LzrL7Lv.jpeg','Imperial Blue is a popular Indian blended whisky known for its smooth, approachable flavor and light, sweet aroma. It combines a mix of Indian grain spirits and imported malt whiskies, offering notes of caramel, vanilla, and mild oak, with a subtle warmth. Its easy-drinking character makes it suitable for neat consumption, over ice, or in simple mixed drinks.',15.00,50,0,'2025-10-10 01:29:12.766347',1,4,'imperial-blue'),(18,'Jack Daweltis','item/Jack_daweltis_ASl5IaY.jpeg','Jack Daniel’s Old No. 7 is a classic Tennessee whiskey known for its smooth, mellow character achieved through the Lincoln County Process — charcoal mellowing before aging. It features notes of caramel, vanilla, toasted oak, and subtle spice, with a clean, slightly sweet finish. Versatile and approachable, it’s ideal neat, on the rocks, or as the base for cocktails like the Whiskey Sour, Old Fashioned, or Jack & Coke.',30.00,50,0,'2025-10-10 01:30:52.767019',1,4,'jack-daweltis'),(19,'JD Single Bareel','item/jd_single_bareel_x9z8RsL.jpeg','Jack Daniel’s Single Barrel Select is a premium expression of Tennessee whiskey, hand-selected from individual barrels for their unique character. Rich and full-bodied, it delivers bold notes of caramel, vanilla, toasted oak, and spice, with a warm, lingering finish. Each barrel offers subtle differences in flavor, making every bottle distinct and a true collector’s delight. Ideal neat or on the rocks to fully appreciate its depth.',70.00,50,0,'2025-10-10 01:32:39.909324',1,4,'jd-single-bareel'),(20,'OX Hennesy','item/ox_hennesy_dbSWCc9.jpeg','Hennessy XO is a luxurious, richly complex cognac, crafted from a blend of over 100 eaux-de-vie aged between 10 and 30 years. It offers deep aromas of dried fruits, candied spices, oak, and subtle floral notes, with a full-bodied, velvety palate and a long, elegant finish. Renowned for its sophistication, it’s perfect for sipping neat, celebrating special occasions, or enjoying with a fine cigar.',245.22,50,0,'2025-10-10 01:34:07.717513',1,4,'ox-hennesy'),(21,'Licor 43','item/Licor_43_part_2_llz83su.jpeg','Licor 43 is a smooth, sweet Spanish liqueur crafted from 43 natural ingredients, including citrus fruits, herbs, and spices. It delivers a warm vanilla and caramel flavor with subtle hints of citrus and Mediterranean herbs. Its versatile profile makes it ideal for sipping neat, over ice, or mixing in cocktails like the Carajillo, Milk & Licor 43, or Vanilla Espresso Martini.',28.59,50,0,'2025-10-10 01:35:31.864592',1,4,'licor-43'),(22,'Lux Row Whiskey','item/Lux_row_whiskey_kMCJ5zM.jpeg','Aged for 12 years, this bourbon delivers a rich and smooth profile with notes of cherry, caramel, oak, and subtle spices. Full-bodied yet balanced, it’s perfect for sipping neat, on the rocks, or in classic bourbon cocktails.',112.89,50,0,'2025-10-10 01:37:06.035330',1,4,'lux-row-whiskey'),(23,'Old Smuggler','item/Old_smuggler_C6j9EGG.jpeg','Old Smuggler is a classic blended Scotch whisky with a history dating back to 1835. Crafted from a blend of over 40 malt whiskies, it offers a smooth and approachable profile. Tasting notes include hints of honey, vanilla, toffee, and light oak, making it a versatile choice for both sipping and mixing in cocktails.',23.90,50,0,'2025-10-10 01:38:52.199063',1,4,'old-smuggler'),(24,'OX Premium','dafault.png.jpeg','The OX Andalusian Spring is a refined German single malt whisky, matured in selected Spanish sherry casks. It offers a harmonious blend of toffee, dried fruit, nutmeg, oak, and herbal spice, resulting in a full-bodied and fruity profile. The whisky is crafted with a commitment to quality and tradition, reflecting the distillery\'s dedication to exceptional craftsmanship.',80.00,50,0,'2025-10-10 01:40:51.906323',1,4,'ox-premium'),(25,'Baku','item/Baku_vodka_DUb8ZMN.jpeg','Baku Vodka is a high-quality spirit produced by Kamill Rauf AG in Austria. Crafted with meticulous attention to detail, it offers a creamy and subtle palate, with hints of copper and fruity tones, leading to a finish reminiscent of green apple and cream. This exceptional vodka has garnered recognition, earning a silver medal at the International Wine & Spirit Competition (IWSC).',40.00,50,0,'2025-10-10 01:43:09.979339',1,3,'baku'),(26,'Belvedere','item/Belvedere_5EFkPJr.jpeg','Belvedere Vodka is a luxury spirit crafted from 100% organic Polska rye and purified water, distilled by fire in Poland\'s longest-operating vodka distillery. It offers a structured and elegant profile with hints of almond, vanilla, and white pepper, followed by a smooth, velvety finish. Belvedere is known for its commitment to quality, containing zero additives, sugars, or artificial ingredients, and is certified kosher by the Orthodox Union.',24.00,50,0,'2025-10-10 01:48:13.155944',1,3,'belvedere'),(27,'Billionaire Vodka','item/Billionaer_Vodka__Billionær_Vodka__Art_zaOYawx.jpeg','Billionaire Vodka is not just a spirit — it’s the ultimate status symbol. The vodka inside is said to be distilled from high-quality wheat and crystal-clear water, filtered multiple times (including supposedly through diamonds/gems) to achieve extraordinary smoothness and purity. But what really sets it apart is the bottle: It’s encrusted with thousands of real diamonds, clad in gold/platinum/rhodium elements, wrapped in faux fur, with an ornate crown-like cap. It’s more piece of art than mere liquor decanter.',4800000.00,50,0,'2025-10-10 01:54:32.759269',1,3,'billionaire-vodka'),(28,'Bombay Sapphirie','item/Bombay_sapphirie_J0d6lR7.jpeg','Bombay Sapphire is known for its bright, balanced profile thanks to a vapour-infusion process using 10 hand-selected botanicals such as juniper, lemon peel, coriander, angelica root, orris root, cubeb berries, grains of paradise, cassia bark, almonds, and liquorice. \r\nBombay Sapphire\r\n The aroma is fresh citrus and juniper, followed by a crisp and slightly spicy finish. It’s clean and versatile — great neat, in a gin & tonic, or sophisticated cocktails.',34.00,50,0,'2025-10-10 01:56:05.749074',1,3,'bombay-sapphirie'),(29,'Gran Patron Tequila','item/GRAN_PATRÓN_Platinum_Tequila_RJNTmSA.jpeg','Gran Patrón Platinum is an exceptionally smooth, triple-distilled tequila made from hand-selected Blue Weber agave grown in the highlands of Jalisco. Each batch is crafted in small quantities to achieve a flawless balance of fresh agave, citrus zest, and a soft peppery finish. It’s bottled in an elegant crystal decanter, symbolizing luxury and purity.',240.00,0,0,'2025-10-10 01:57:46.734568',1,3,'gran-patron-tequila'),(30,'Grey Goose','item/Grey_goose_yC7PZqM.jpeg','Grey Goose is made from soft winter wheat grown in Picardy, France, and blended with pure spring water from Gensac in the Cognac region. \r\n It has a delicate floral and grainy nose, subtle citrus and almond hints, with a smooth, slightly sweet palate and a clean, crisp finish.',40.00,50,0,'2025-10-10 01:59:21.469549',1,3,'grey-goose'),(31,'Kurant Vodka','item/kurant_vodka_61ZpJmU.jpeg','Absolut Kurant is a smooth, fruit-forward vodka infused with the flavour of natural blackcurrants—a berry deeply rooted in Swedish tradition. It was first released in 1992 as a tribute to Sweden’s native blackcurrant (in Swedish, “vinbär”) and its long berry harvest culture.',20.67,50,0,'2025-10-10 02:00:36.036072',1,3,'kurant-vodka'),(32,'Merican Harvest','item/merican_hervest_vodka_EtlJmVH.jpeg','American Harvest Organic Vodka is a premium spirit crafted in small batches from 100% organic Rocky Mountain red winter wheat and pure water sourced from the protected aquifers beneath the Snake River Plain. The addition of organic agave imparts a subtle sweetness and smooth finish. This vodka is USDA certified organic, gluten-free, and non-GMO, reflecting a commitment to quality and sustainability.',24.99,50,0,'2025-10-10 02:01:49.447251',1,3,'merican-harvest'),(33,'Pravda Coconut Vodka','item/Pravda_vodka_-_Coconut_tjNFGMu.jpeg','American Harvest is a premium organic vodka distilled in small batches from 100% organic Idaho winter wheat. The water used is sourced from deep beneath the Snake River Plain aquifers, ensuring purity and quality. This vodka is USDA certified organic, gluten-free, and non-GMO, reflecting a commitment to sustainable agriculture and environmental responsibility. The distillation process results in a smooth, clean spirit with subtle notes of vanilla and a soft mouthfeel, making it suitable for sipping neat or in cocktails.',25.78,50,0,'2025-10-10 02:04:01.240280',1,3,'pravda-coconut-vodka'),(34,'Roca Patron','item/Roca_patron_tequilla_WnTaJXW.jpeg','Roca Patrón is a luxury tequila line from Patrón, distinguished by its traditional production methods. The agave is baked in small brick ovens for 79 hours and then pressed using a two-ton volcanic stone tahona wheel. This artisanal process imparts a rich, complex flavor profile to the tequila.',76.99,50,0,'2025-10-10 02:05:46.778178',1,3,'roca-patron'),(35,'Smirnoff Crandberry','item/Smirnoff_grandberry_vodka_a2Mkpmi.jpeg','Smirnoff Cranberry Vodka is a flavored vodka infused with the natural taste of cranberries, offering a balanced blend of tart and sweet flavors. Triple distilled for smoothness, it is gluten-free and certified kosher. This vodka is versatile, suitable for sipping over ice, mixing with club soda and lime, or incorporating into various cocktails.',10.66,50,0,'2025-10-10 02:07:17.278571',1,3,'smirnoff-crandberry'),(36,'Avocado kiwi Smoothie','item/Avocado_Kiwi_Citrus_Smoothie_RKpPPkH.jpeg','The Avocado Kiwi Smoothie is a creamy, refreshing blend packed with vitamins and antioxidants. Smooth avocado provides a rich, velvety texture, while fresh kiwi adds a bright, tangy twist. Balanced with a touch of honey or lime juice, it’s both energizing and nourishing — perfect for a healthy breakfast or post-workout drink.',5.00,50,0,'2025-10-10 11:45:14.100908',1,6,'avocado-kiwi-smoothie'),(37,'Berry Coffee Smoothie','item/Berry_Coffee_Smoothie_PJCXWsz.jpeg','Description:\r\nThe Berry Coffee Smoothie is a bold fusion of fresh mixed berries and rich brewed coffee, designed to give a refreshing caffeine boost with a fruity twist. The sweetness of berries blends beautifully with the bitterness of coffee, creating a creamy, energizing drink perfect for mornings or pre-workout fuel.',6.20,50,0,'2025-10-10 11:46:55.678303',1,6,'berry-coffee-smoothie'),(38,'Banana Vanilla Smoothie','item/Banana_Vanilla_Smoothie_etZ8gvn.jpeg','The Berry Coffee Smoothie is a bold fusion of fresh mixed berries and rich brewed coffee, designed to give a refreshing caffeine boost with a fruity twist. The sweetness of berries blends beautifully with the bitterness of coffee, creating a creamy, energizing drink perfect for mornings or pre-workout fuel.',7.90,59,0,'2025-10-10 11:47:54.964255',1,6,'banana-vanilla-smoothie'),(39,'Blueberry Greek Yogurt Smoothie','item/Blueberry_Greek_Yogurt_Smoothie.jpeg','The Blueberry Greek Yogurt Smoothie is a thick, creamy blend of fresh blueberries, Greek yogurt, and a touch of honey for natural sweetness. It’s packed with antioxidants, probiotics, and protein, making it a perfect choice for a healthy breakfast or midday energy boost. Every sip offers a balance of sweet, tart, and creamy flavors with a refreshing fruity aroma.',6.00,50,0,'2025-10-10 11:56:12.713415',1,6,'blueberry-greek-yogurt-smoothie'),(40,'Blueberry Milkshake','item/Blueberry_Milkshake_Recipe___Fresh_Creamy_Berry_Drink.jpeg','A rich, creamy blend of fresh blueberries, milk, and smooth vanilla ice cream. The Blueberry Milkshake delivers a perfect balance of sweetness and tart berry flavor with a velvety texture. It’s refreshing, indulgent, and packed with natural antioxidants from the blueberries — a perfect treat for any time of day.',6.99,50,0,'2025-10-10 12:01:31.294804',1,2,'blueberry-milkshake'),(41,'Agave cooler','item/Agave_Cooler.jpeg','A light and refreshing cocktail crafted with premium agave spirit, fresh lime juice, and a hint of soda. The Agave Cooler delivers a crisp, citrusy taste with smooth agave undertones — perfect for warm days and easy sipping.',2.40,59,0,'2025-10-10 12:03:30.658321',1,8,'agave-cooler'),(42,'Banana Milkshake','item/Banana_Shake.jpeg','A creamy and satisfying blend of ripe bananas, milk, and smooth vanilla ice cream. The Banana Milkshake is naturally sweet with a velvety texture, making it a perfect treat for breakfast, dessert, or anytime you crave a fruity indulgence.',6.98,59,0,'2025-10-10 12:05:41.989597',1,2,'banana-milkshake'),(43,'Batida','item/Batida.jpeg','A tropical Brazilian cocktail made with cachaça, fresh fruit juices, and a touch of sugar. Batida is smooth, fruity, and refreshing, offering a perfect balance of sweet and tangy flavors for a vibrant, exotic experience.',5.90,70,0,'2025-10-10 12:11:03.090638',1,8,'batida'),(44,'Heineken','item/Beer_Heineken.jpeg','A classic pale lager with a crisp, clean taste and a subtle fruity aroma. Heineken is smooth, refreshing, and perfectly balanced, making it one of the most recognizable and enjoyed beers worldwide.',3.90,80,0,'2025-10-10 12:11:54.272191',1,1,'heineken'),(45,'Beer Mojito','item/beer_mojito.jpeg','A refreshing twist on the classic mojito, combining crisp beer with fresh mint, lime juice, and a hint of sweetness. The Beer Mojito is light, bubbly, and perfect for cooling down on a warm day.',6.90,50,0,'2025-10-10 12:13:34.944452',1,8,'beer-mojito'),(46,'Berries & Cream Summer Milkshake','item/Berries__Cream_Summer_Freakshake.jpeg','A luscious blend of mixed summer berries, creamy vanilla ice cream, and milk. This milkshake is rich, fruity, and indulgent, offering a perfect balance of sweet and tangy flavors for a refreshing treat.',6.00,60,0,'2025-10-10 12:14:54.850239',1,2,'berries-cream-summer-milkshake'),(47,'Bitang Beer','item/bintang_beer.jpeg','A smooth and crisp lager with a light, refreshing taste. Bitang Beer offers subtle malt sweetness and a clean finish, making it an ideal choice for casual drinking and social gatherings.',5.00,60,0,'2025-10-10 12:15:41.701589',1,1,'bitang-beer'),(48,'Bitter Southside','item/Bitter_Southside.jpeg','A sophisticated cocktail combining premium gin, freshly squeezed citrus, aromatic mint, and a touch of bitters. The Bitter Southside delivers a crisp, refreshing taste with layered complexity, balancing herbal, tangy, and slightly bitter notes. Perfect for enjoying on a warm evening or as a stylish accompaniment to social gatherings.',4.90,89,0,'2025-10-10 12:17:14.578688',1,8,'bitter-southside'),(49,'Blue Cocktail','item/blue_cocktail.jpeg','A vibrant and visually stunning cocktail made with premium vodka, blue curaçao, and fresh citrus juices. The Blue Cocktail offers a perfectly balanced taste that is both sweet and tangy, with a smooth finish that lingers on the palate. Ideal for parties, celebrations, or simply enjoying a refreshing, tropical-inspired drink.',4.00,50,0,'2025-10-10 12:18:44.626178',1,8,'blue-cocktail'),(50,'Budweiser','item/budweiser.jpeg','A classic American lager known for its smooth, crisp taste and balanced malt sweetness. Budweiser delivers a clean, refreshing finish with subtle hop bitterness, making it a versatile beer perfect for any occasion — from casual gatherings to lively celebrations.',4.00,89,0,'2025-10-10 12:19:50.463105',1,1,'budweiser'),(51,'Castle','item/castle_beer.jpeg','A full-bodied lager with a rich golden hue and a smooth, satisfying taste. Castle Beer offers a balanced malt sweetness with a hint of bitterness, delivering a crisp and refreshing finish. Perfect for social occasions or enjoying a cold, relaxing drink after a long day.',8.00,90,0,'2025-10-10 12:21:41.670106',1,1,'castle'),(52,'Castle101','item/CASTLE101_.jpeg','A bold and flavorful cocktail crafted with premium spirits, fresh citrus, and a blend of secret mixers for a unique taste experience. Castle101 Cocktail delivers a smooth yet invigorating flavor profile with hints of sweetness and a subtle kick, making it perfect for evening gatherings, celebrations, or a stylish night out.',4.90,67,0,'2025-10-10 12:22:34.774506',1,8,'castle101'),(53,'Chartreuse Swizzle','item/Chartreuse_Swizzle.jpeg','A vibrant and refreshing cocktail featuring herbal Chartreuse liqueur, fresh lime juice, and a touch of sweetness, shaken and served over crushed ice. The Chartreuse Swizzle delivers a complex yet balanced flavor with aromatic herbal notes, citrusy brightness, and a crisp, invigorating finish — perfect for a summer afternoon or a sophisticated evening gathering.',7.00,67,0,'2025-10-10 12:23:44.056848',1,8,'chartreuse-swizzle'),(54,'Chocolate Brownie Milkshake','item/Chocolate_Brownie_Milkshake.jpeg','A rich and indulgent milkshake blending creamy vanilla ice cream, fresh milk, and chunks of decadent chocolate brownies. This Chocolate Brownie Milkshake offers a perfectly balanced sweet and chocolaty flavor with a smooth, velvety texture, making it an irresistible treat for dessert lovers or anyone craving a delicious, indulgent drink.',4.77,67,0,'2025-10-10 12:24:49.643787',1,2,'chocolate-brownie-milkshake'),(55,'Coconut Milkshake','item/coconut_milk_shake.jpeg','A creamy and tropical milkshake made with fresh coconut milk, smooth vanilla ice cream, and a hint of natural sweetness. The Coconut Milkshake delivers a rich, velvety texture with a refreshing coconut flavor, making it a perfect treat for cooling down on warm days or simply enjoying a delicious, indulgent beverage.',4.90,88,0,'2025-10-10 12:26:22.803418',1,2,'coconut-milkshake'),(56,'Corona Extra','item/corona_extra.jpeg','A crisp and light Mexican lager with a clean, refreshing taste. Corona Extra offers subtle malt sweetness, a delicate hop bitterness, and a smooth finish. Perfect served ice-cold with a wedge of lime, it’s ideal for relaxing on a sunny day, at parties, or casual social gatherings.',5.98,89,0,'2025-10-10 12:27:12.894534',1,1,'corona-extra'),(57,'Cuba Kola','item/Cuba_Kola.jpeg','A vibrant and fizzy cola with a unique, bold flavor. Cuba Kola delivers a perfect balance of sweetness and carbonation, making it a refreshing beverage choice for any occasion. Ideal for pairing with meals, enjoying on its own, or serving at gatherings.',2.90,77,0,'2025-10-10 12:28:21.718651',1,8,'cuba-kola'),(58,'Desperados','item/Desperados_beer.jpeg','A unique tequila-flavored lager that combines the crisp, refreshing taste of beer with a hint of smooth, aromatic tequila. Desperados offers a bold and adventurous flavor profile, making it a perfect choice for parties, social gatherings, or anyone looking for a distinctive twist on traditional beer.',5.00,59,0,'2025-10-10 12:29:28.365723',1,1,'desperados'),(59,'Chocolate Milkshake','item/download_48.jpeg','A classic and indulgent milkshake made with rich chocolate syrup, creamy vanilla ice cream, and fresh milk. The Chocolate Milkshake offers a smooth, velvety texture and a perfectly balanced sweet chocolate flavor, making it a delightful treat for dessert lovers or anyone craving a refreshing and satisfying beverage.',3.00,67,0,'2025-10-10 12:31:00.975242',1,2,'chocolate-milkshake'),(60,'Easy Nutella Milkshake','item/Easy_Nutella_Milkshake_Recipe___Creamy_Chocolate_Dessert_Drink.jpeg','A creamy and indulgent milkshake blending smooth Nutella spread, fresh milk, and rich vanilla ice cream. The Easy Nutella Milkshake offers a perfectly balanced chocolate-hazelnut flavor with a velvety texture, making it an irresistible treat for Nutella lovers and anyone craving a decadent, refreshing beverage.',5.00,4,3,'2025-10-10 12:32:05.481715',1,2,'easy-nutella-milkshake'),(61,'Flying Fish','item/Flying_fish.jpeg','A premium lager known for its smooth, crisp taste and light, refreshing finish. Flying Fish offers subtle malt sweetness balanced with mild hop bitterness, making it an easy-drinking beer perfect for social gatherings, casual evenings, or relaxing on a warm day.',4.00,78,0,'2025-10-10 12:34:04.030226',1,1,'flying-fish'),(62,'Gulder','item/Gulder.jpeg','A bold and full-bodied lager with a rich golden color and robust flavor. Gulder delivers a smooth malt sweetness with a satisfying, crisp finish, making it a popular choice for beer enthusiasts. Perfect for casual drinking, social gatherings, or enjoying a cold beverage after a long day.',4.89,99,0,'2025-10-10 12:35:03.404487',1,1,'gulder'),(63,'Hovels','item/Hövels_Original_Bier_aus_Dortmund.jpeg','A smooth and refreshing lager with a light golden hue and subtle malt flavor. Hovels offers a crisp, clean finish with a balanced bitterness, making it an ideal beer for casual sipping, social gatherings, or enjoying a cold drink on a warm day.',5.00,50,0,'2025-10-10 12:38:27.395123',1,1,'hovels'),(64,'Long Island Tea','item/Long_Island_Iced_Tea_Rum_as_one_of_the_spirits.jpeg','A powerful and refreshing cocktail combining vodka, rum, gin, tequila, triple sec, fresh lemon juice, and a splash of cola. Long Island Tea offers a perfectly balanced mix of sweet, citrusy, and slightly bitter flavors with a smooth finish. Ideal for parties, celebrations, or anyone seeking a bold and flavorful drink experience.',5.90,98,0,'2025-10-10 12:39:42.577481',1,8,'long-island-tea'),(65,'Mango Smoothie','item/mango_smoothie.jpeg','A creamy and refreshing blend of ripe mangoes, yogurt, and a touch of honey. The Mango Smoothie delivers a naturally sweet and tropical flavor with a smooth, velvety texture, making it a perfect healthy treat for breakfast, a snack, or a refreshing pick-me-up any time of day.',4.00,60,0,'2025-10-10 12:40:46.401391',1,6,'mango-smoothie'),(66,'Margarita','item/Margarita.jpeg','A classic cocktail made with premium tequila, fresh lime juice, and orange liqueur, served with a salted rim. The Margarita offers a perfect balance of tangy, sweet, and slightly bitter flavors with a refreshing and crisp finish. Ideal for parties, celebrations, or enjoying a tropical-inspired drink any time.',6.00,90,0,'2025-10-10 12:41:46.157359',1,6,'margarita'),(67,'Michelob','item/Michelob_Ultra_lanza_Superior_Acces.jpeg','A smooth and light lager with a crisp, clean taste. Michelob delivers subtle malt sweetness and mild hop bitterness, offering a refreshing and easy-to-drink beer. Perfect for casual gatherings, social events, or enjoying a cold beverage on a warm day.',3.90,99,0,'2025-10-10 12:44:26.229553',1,1,'michelob'),(68,'Minty Blueberry Mojito','item/Minty_Blueberry_Mojito_Magic__Alcohol-Free_Party_Recipe.jpeg','A refreshing twist on the classic mojito, blending fresh blueberries, muddled mint leaves, lime juice, and a splash of rum. The Minty Blueberry Mojito delivers a crisp, fruity, and aromatic flavor with a perfect balance of sweetness and tang, making it ideal for summer afternoons, parties, or relaxing evenings.',8.90,67,0,'2025-10-10 12:45:47.258648',1,8,'minty-blueberry-mojito'),(69,'Strawberry Mojito','item/Mojito.jpeg','A refreshing and fruity cocktail combining fresh strawberries, muddled mint leaves, lime juice, and a splash of rum. The Strawberry Mojito offers a perfect balance of sweetness, tartness, and aromatic freshness, making it ideal for warm afternoons, social gatherings, or any occasion that calls for a vibrant, delicious drink.',3.90,89,0,'2025-10-10 12:47:38.584874',1,8,'strawberry-mojito'),(70,'Oreo Milkshake','item/Oreo_Milkshake__The_Ultimate_Creamy_Treat_.jpeg','A rich and indulgent milkshake made with creamy vanilla ice cream, fresh milk, and chunks of crunchy Oreo cookies. The Oreo Milkshake delivers a perfectly balanced chocolatey and creamy flavor with a smooth, velvety texture, making it an irresistible treat for dessert lovers or anyone craving a sweet, satisfying beverage.',6.90,98,0,'2025-10-10 12:55:32.185027',1,2,'oreo-milkshake'),(71,'Orual','item/orual_beer.jpeg','A smooth and refreshing lager with a light golden color and crisp finish. Orual Beer offers subtle malt sweetness balanced with mild hop bitterness, making it a perfect choice for casual drinking, social gatherings, or enjoying a cold beverage on a warm day.',4.00,99,0,'2025-10-10 12:59:25.025422',1,1,'orual'),(72,'Papaya & Pineapple Smoothie','item/Papaya_Pineapple_Batido_Recipe___Cuban_Tropical_Smoothie.jpeg','A tropical and refreshing blend of ripe papaya, juicy pineapple, and creamy yogurt. The Papaya & Pineapple Smoothie delivers a naturally sweet and tangy flavor with a smooth, velvety texture, making it a perfect healthy treat for breakfast, a snack, or a refreshing pick-me-up any time of day.',4.00,50,0,'2025-10-10 13:01:04.965911',1,6,'papaya-pineapple-smoothie'),(73,'Pineapple Smoothie','item/Pineapple_smoothie.jpeg','A refreshing and tropical smoothie made with fresh pineapple, creamy yogurt, and a touch of honey. The Pineapple Smoothie offers a naturally sweet and tangy flavor with a smooth, velvety texture, making it an ideal healthy treat for breakfast, a snack, or a cooling beverage any time of day.',6.09,70,0,'2025-10-10 13:02:08.105411',1,6,'pineapple-smoothie'),(74,'Pomegranate Smoothie','item/Pomegranate_Smoothie___Refreshing__Nutritious___Weight_loss_Smoothies.jpeg','A vibrant and refreshing smoothie made with fresh pomegranate seeds, creamy yogurt, and a touch of honey. The Pomegranate Smoothie delivers a naturally sweet and slightly tart flavor with a smooth, velvety texture, packed with antioxidants for a healthy and delicious treat any time of day.',7.65,50,0,'2025-10-10 13:03:28.265493',1,6,'pomegranate-smoothie'),(75,'Smirnoff Ice','item/sminorff_ice.jpeg','A crisp and refreshing malt beverage with a light, citrusy flavor and subtle sweetness. Smirnoff Ice delivers a smooth and effervescent taste, making it perfect for parties, casual gatherings, or enjoying a chilled drink on a warm day.',9.00,60,0,'2025-10-10 13:04:41.026424',1,1,'smirnoff-ice'),(76,'Strawberry Blueberry Smoothie','item/strawberry_blueberry_smothie.jpeg','A vibrant and refreshing blend of fresh strawberries, juicy blueberries, and creamy yogurt. The Strawberry Blueberry Smoothie offers a naturally sweet and slightly tangy flavor with a smooth, velvety texture, making it a perfect healthy treat for breakfast, a snack, or a revitalizing pick-me-up any time of day.',4.90,50,0,'2025-10-10 13:14:54.674475',1,6,'strawberry-blueberry-smoothie'),(77,'Virgin Mojito','item/Virgin_Mojito_10_Minutes_-_Chasety.jpeg','A refreshing and zesty non-alcoholic cocktail made with muddled fresh mint leaves, lime juice, a touch of sugar, and sparkling soda water. The Virgin Mojito delivers a crisp, cool, and aromatic flavor, making it a perfect drink for warm afternoons, social gatherings, or simply enjoying a revitalizing, alcohol-free treat.',3.99,50,2,'2025-10-10 13:33:49.645334',1,8,'virgin-mojito'),(78,'Vodka Cucumber Basil','item/Vodka_Cucumber_Basil.jpeg','A crisp and refreshing cocktail combining premium vodka, fresh cucumber, and aromatic basil leaves. Vodka Cucumber Basil offers a clean, light flavor with herbal and vegetal notes, balanced by a subtle sweetness and smooth finish. Perfect for warm days, sophisticated gatherings, or anyone seeking a cool, invigorating drink.',6.30,99,0,'2025-10-10 13:34:56.696634',1,8,'vodka-cucumber-basil'),(79,'Water Melon Smoothie','item/water_melon_smoothie.jpeg','A refreshing and hydrating smoothie made with fresh watermelon, creamy yogurt, and a hint of honey. The Watermelon Smoothie delivers a naturally sweet, juicy flavor with a smooth, velvety texture, making it an ideal healthy treat for hot days, a snack, or a revitalizing drink anytime.',7.00,89,0,'2025-10-10 13:36:45.125855',1,6,'water-melon-smoothie'),(80,'Yuengling','item/yuengling.jpeg','America’s oldest brewery beer, Yuengling is a smooth and balanced lager with a rich amber color. It offers a mild malt sweetness, subtle hop bitterness, and a clean, refreshing finish, making it perfect for casual drinking, social gatherings, or enjoying a classic American lager experience.',6.90,40,0,'2025-10-10 13:37:42.229592',1,1,'yuengling'),(81,'Orange Mojito','item/_Orange_Mojito.jpeg','A refreshing twist on the classic mojito, combining fresh orange juice, muddled mint leaves, lime, and a splash of rum. The Orange Mojito delivers a vibrant, citrusy flavor with a balanced sweetness and aromatic freshness, perfect for summer afternoons, parties, or any occasion that calls for a bright and invigorating drink.',6.90,60,0,'2025-10-10 13:38:44.984384',1,8,'orange-mojito'),(82,'Strawberry Smoothie','item/_Rosy_Frozen_Strawberry_Smoothie__Creamy__Refreshing_.jpeg','A sweet and refreshing smoothie made with fresh strawberries, creamy yogurt, and a touch of honey. The Strawberry Smoothie delivers a naturally fruity flavor with a smooth, velvety texture, making it a perfect healthy treat for breakfast, a snack, or a revitalizing drink any time of day.',7.00,70,0,'2025-10-10 13:40:34.145422',1,6,'strawberry-smoothie'),(83,'Avocado Blueberry Smoothie','item/_Creamy_Avocado_Blueberry_Smoothie.jpeg','A creamy and nutrient-packed smoothie blending ripe avocado, fresh blueberries, and smooth yogurt. The Avocado Blueberry Smoothie offers a rich, velvety texture with a naturally sweet and slightly tangy flavor, making it a perfect healthy treat for breakfast, a snack, or a revitalizing pick-me-up any time of day.',7.99,60,0,'2025-10-10 13:41:42.878910',1,6,'avocado-blueberry-smoothie'),(84,'Bellinee\'s Table Water','item/bellinees.jpeg','Crystal-clear and refreshing, Bellinee\'s Table Water offers pure hydration with a smooth, clean taste. Perfect for everyday drinking, meals, or staying refreshed during workouts and outdoor activities.',1.22,400,0,'2025-10-10 13:44:15.886740',1,7,'bellinees-table-water'),(85,'Empire Table Water','item/empire_water.jpeg','Pure and refreshing, Empire Table Water delivers crisp, clean hydration for any occasion. Ideal for daily consumption, meals, or staying hydrated on the go, it’s a reliable choice for freshness and quality.',1.40,45,0,'2025-10-10 13:45:26.482339',1,7,'empire-table-water'),(86,'Essentia Ionized Alkali Water','item/Essentia_Ionized_Alkaline_Water.jpeg','A premium alkaline water carefully ionized for optimal hydration and balance. Essentia Ionized Alkali Water offers a smooth, clean taste with a pH of 9.5, helping to replenish and revitalize your body. Perfect for athletes, fitness enthusiasts, or anyone seeking superior hydration throughout the day.',2.00,889,0,'2025-10-11 13:30:52.025879',1,7,'essentia-ionized-alkali-water'),(87,'Forever Water','item/forever_water.jpeg','Forever Water is ultra-pure and naturally refreshing, filtered through advanced purification processes to ensure exceptional clarity and taste. Designed to keep you hydrated and energized all day, it’s the perfect companion for work, fitness, or relaxation',1.10,78,0,'2025-10-11 13:31:57.510337',1,7,'forever-water'),(88,'Glacid Water','item/glacid_water.jpeg','Glacid Water offers pure, crystal-clear hydration sourced from natural springs and refined through advanced filtration. With its crisp, clean taste and refreshing smoothness, it’s ideal for daily hydration, outdoor activities, or simply enjoying a moment of cool refreshment.',1.65,799,0,'2025-10-11 13:33:43.549197',1,7,'glacid-water'),(89,'Life Water','item/life_water.jpeg','Life Water is purified and enriched to deliver exceptional freshness and hydration. With its clean, crisp taste and balanced minerals, it revitalizes your body and mind, making it the perfect choice for everyday drinking, fitness, and wellness.',2.00,900,0,'2025-10-11 13:34:56.099467',1,7,'life-water'),(90,'Marcs Water','item/marcs.jpeg','Marcs Water provides pure, refreshing hydration sourced from carefully filtered natural water. Its smooth, clean taste makes it perfect for everyday use, whether at home, in the office, or on the go. Stay fresh, healthy, and hydrated with every sip.',1.55,500,0,'2025-10-11 13:36:17.135072',1,7,'marcs-water'),(91,'Nice Water','item/nice_water.jpeg','Nice Water delivers crisp, refreshing hydration with a clean and balanced taste. Purified through advanced filtration, it’s ideal for daily consumption, workouts, or pairing with meals — a simple, pure choice for a healthy lifestyle.',1.35,899,0,'2025-10-11 13:46:11.747267',1,7,'nice-water'),(92,'Vanam Water','item/vanam_water.jpeg','Vanam Water is naturally pure and refreshingly smooth, filtered to perfection for exceptional clarity and taste. Designed to keep you hydrated and rejuvenated, it’s an ideal choice for everyday use, outdoor activities, or a refreshing companion during meals.',1.78,800,0,'2025-10-11 13:47:18.967630',1,7,'vanam-water'),(93,'Victory Water','item/victory_water.jpeg','Vanam Water is naturally pure and refreshingly smooth, filtered to perfection for exceptional clarity and taste. Designed to keep you hydrated and rejuvenated, it’s an ideal choice for everyday use, outdoor activities, or a refreshing companion during meals.',1.90,700,0,'2025-10-11 13:48:26.264576',1,7,'victory-water'),(94,'Vittel Water','item/vittel_water.jpeg','Vittel Water is a premium natural mineral water sourced from the Vosges region of France, known for its crisp, balanced taste and rich mineral content. It’s perfect for active hydration and complements meals with its refreshing, clean finish.',1.60,800,0,'2025-10-11 13:49:28.731795',1,7,'vittel-water'),(95,'Zineland Water','item/zineland_water.jpeg','Zineland Water offers pure, crystal-clear hydration sourced from deep underground springs. Naturally filtered through layers of rock, it delivers a smooth, crisp taste that revitalizes the body and refreshes the mind. Ideal for both daily use and premium dining experiences.',2.00,600,0,'2025-10-11 13:51:19.554332',1,7,'zineland-water'),(96,'Affogato','item/affogato.jpeg','Affogato is a rich Italian treat that blends the bold intensity of hot espresso with the smooth sweetness of vanilla ice cream. Each sip delivers a balance of warmth and creaminess, making it a perfect indulgence for coffee lovers who crave both comfort and luxury.',4.70,90,0,'2025-10-11 13:54:00.121178',1,5,'affogato'),(97,'Americano','item/americano.jpeg','Americano is a smooth, full-bodied coffee made by diluting rich espresso with hot water, creating a balanced brew that’s bold yet easy to drink. It offers a clean taste with subtle espresso notes, perfect for those who enjoy a classic and uncomplicated coffee experience.',3.90,400,0,'2025-10-11 13:55:24.831008',1,5,'americano'),(98,'Cappuccino','item/cappuccino.jpeg','Cappuccino is a classic Italian coffee made with equal parts rich espresso, steamed milk, and frothy milk foam. Its creamy texture and balanced flavor deliver a smooth, indulgent coffee experience, perfect for mornings, afternoons, or any time you need a comforting boost.',3.85,800,0,'2025-10-11 13:56:20.993331',1,5,'cappuccino'),(99,'Cortado','item/cortado.jpeg','Cortado is a perfectly balanced espresso drink made with equal parts rich espresso and steamed milk. Its smooth, bold flavor and creamy texture create a harmonious coffee experience, ideal for those who enjoy a strong yet mellow cup.',3.20,300,0,'2025-10-11 13:57:29.792968',1,5,'cortado'),(100,'Espresso','item/espresso.jpeg','Espresso is a concentrated, full-bodied coffee brewed by forcing hot water through finely ground coffee beans. Known for its bold flavor, rich aroma, and velvety crema, it’s perfect for a quick, energizing shot or as the base for other coffee beverages.',3.90,899,0,'2025-10-11 13:58:32.963210',1,5,'espresso'),(101,'Frappuccino','item/frappuccino.jpeg','Frappuccino is a blended iced coffee drink combining rich espresso, milk, ice, and sweet flavorings, topped with whipped cream. Its creamy texture and refreshing taste make it a perfect indulgence for warm days or anyone craving a sweet, energizing coffee treat.',4.85,700,0,'2025-10-11 13:59:43.338273',1,5,'frappuccino'),(102,'Macchiato','item/macchiato.jpeg','Macchiato is a classic espresso-based coffee topped with a small amount of steamed milk or foam. This bold yet slightly creamy drink highlights the rich flavor of espresso while offering a subtle smoothness, making it perfect for a quick, satisfying coffee experience.',4.50,800,0,'2025-10-11 14:01:24.141922',1,5,'macchiato'),(103,'Irish Coffee','item/irish-coffee.jpeg','Irish Coffee is a warming blend of hot coffee, smooth Irish whiskey, and sugar, topped with a layer of lightly whipped cream. Its rich, velvety flavor combines the boldness of coffee with the warmth of whiskey, creating a perfect indulgence for cozy evenings or special occasions.',4.60,800,0,'2025-10-11 14:02:23.212392',1,5,'irish-coffee'),(104,'Mocha','item/mocha.jpeg','Mocha is a decadent coffee drink combining rich espresso, steamed milk, and smooth chocolate syrup, often topped with whipped cream. It delivers a perfect balance of bold coffee flavor and sweet chocolate, making it an indulgent treat for mornings, afternoons, or any time you crave a comforting coffee experience.',4.66,400,0,'2025-10-11 14:03:31.569101',1,5,'mocha'),(105,'Nitro Cold Brew','item/nitro-cold_brew.jpeg','Nitro Cold Brew is a smooth and creamy cold coffee infused with nitrogen for a velvety texture and cascading frothy head. Its naturally sweet and bold flavor makes it a refreshing and invigorating choice for coffee enthusiasts looking for a unique, chilled coffee experience.',4.56,900,1,'2025-10-11 14:04:48.416274',1,5,'nitro-cold-brew'),(106,'Signature Espresso','item/signature-espresso.jpeg','Signature Espresso is a rich and full-bodied coffee crafted from carefully selected premium beans. Its bold flavor, aromatic profile, and velvety crema deliver a refined and satisfying espresso experience, perfect for coffee purists or as the foundation for specialty coffee drinks.',4.89,900,0,'2025-10-11 14:06:15.875767',1,7,'signature-espresso');
/*!40000 ALTER TABLE `api_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add category',7,'add_category'),(26,'Can change category',7,'change_category'),(27,'Can delete category',7,'delete_category'),(28,'Can view category',7,'view_category'),(29,'Can add item',8,'add_item'),(30,'Can change item',8,'change_item'),(31,'Can delete item',8,'delete_item'),(32,'Can view item',8,'view_item'),(33,'Can add cart',9,'add_cart'),(34,'Can change cart',9,'change_cart'),(35,'Can delete cart',9,'delete_cart'),(36,'Can view cart',9,'view_cart');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$eZ75tRRCTcj5voFoKuDIni$d9dh0kW/qkjLcj8Z+dUJ/N7Mjnp6FSJ4o6UTexdJ3og=','2025-10-10 00:40:00.190746',1,'bigjoe','','','',1,1,'2025-10-10 00:38:32.222449'),(2,'pbkdf2_sha256$600000$M0QlXuCjkBTaQZUhQr8xVq$p+m1muwrv7XBumWr6LG7tR1CKzM9NT8YSPi92SnT8vY=',NULL,0,'zomo','panama','joe','pj@example.com',0,1,'2025-10-10 01:16:10.458490'),(3,'pbkdf2_sha256$600000$2OjNDu6N07D3KPsZSRsIGB$QRjqrmsi2Aa3w4H6XQ2Y+EGjjewvrRcKSQTWIM9Cuz4=',NULL,0,'Alabi','Mr','Alabi','alabian@example.com',0,1,'2025-10-13 13:53:46.887723'),(4,'pbkdf2_sha256$600000$wTU8JPwccMfEZT01Kfpuq1$WGK90vWEGT3ge7BYf8WiSEyWjtqssYaBbl/ffHGEwYU=',NULL,0,'bella','Bella','Fomnya','bella@example.com',0,1,'2025-11-02 23:08:41.314610');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-10-10 00:46:13.366874','1','Beer',1,'[{\"added\": {}}]',7,1),(2,'2025-10-10 00:48:45.294681','2','Milkshake',1,'[{\"added\": {}}]',7,1),(3,'2025-10-10 00:49:04.337998','3','Vodka',1,'[{\"added\": {}}]',7,1),(4,'2025-10-10 00:49:28.398058','4','Whiskey',1,'[{\"added\": {}}]',7,1),(5,'2025-10-10 00:51:52.926841','5','Coffee',1,'[{\"added\": {}}]',7,1),(6,'2025-10-10 00:52:14.338381','6','Smothies',1,'[{\"added\": {}}]',7,1),(7,'2025-10-10 00:53:31.882188','7','Water',1,'[{\"added\": {}}]',7,1),(8,'2025-10-10 00:54:02.026430','8','Cocktails',1,'[{\"added\": {}}]',7,1),(9,'2025-10-10 00:58:47.956170','1','Tequilla',1,'[{\"added\": {}}]',8,1),(10,'2025-10-10 01:00:31.756812','2','Absolut Citron Recipies',1,'[{\"added\": {}}]',8,1),(11,'2025-10-10 01:02:09.725785','3','Apleton Estsate',1,'[{\"added\": {}}]',8,1),(12,'2025-10-10 01:03:28.350618','4','Baileys',1,'[{\"added\": {}}]',8,1),(13,'2025-10-10 01:04:42.331518','5','Balvenie Whiskey',1,'[{\"added\": {}}]',8,1),(14,'2025-10-10 01:06:07.901028','6','Black Label Whiskey',1,'[{\"added\": {}}]',8,1),(15,'2025-10-10 01:07:37.087768','7','Blanton\'s',1,'[{\"added\": {}}]',8,1),(16,'2025-10-10 01:08:47.865663','8','Blue Label Whiskey',1,'[{\"added\": {}}]',8,1),(17,'2025-10-10 01:09:57.681208','9','Bourbon Whiskey',1,'[{\"added\": {}}]',8,1),(18,'2025-10-10 01:19:57.682404','10','Blue Label Whiskey',1,'[{\"added\": {}}]',8,1),(19,'2025-10-10 01:20:57.427990','11','Captain Morgan',1,'[{\"added\": {}}]',8,1),(20,'2025-10-10 01:22:19.035745','12','Chivas Regal',1,'[{\"added\": {}}]',8,1),(21,'2025-10-10 01:24:32.212656','13','GlenDronach',1,'[{\"added\": {}}]',8,1),(22,'2025-10-10 01:25:53.853097','14','Glenlivet XXV',1,'[{\"added\": {}}]',8,1),(23,'2025-10-10 01:26:55.642863','15','Glenlivet  Whiskey',1,'[{\"added\": {}}]',8,1),(24,'2025-10-10 01:28:12.891887','16','Habiki',1,'[{\"added\": {}}]',8,1),(25,'2025-10-10 01:29:12.768226','17','Imperial Blue',1,'[{\"added\": {}}]',8,1),(26,'2025-10-10 01:30:52.769734','18','Jack Daweltis',1,'[{\"added\": {}}]',8,1),(27,'2025-10-10 01:32:39.911026','19','JD Single Bareel',1,'[{\"added\": {}}]',8,1),(28,'2025-10-10 01:34:07.719061','20','OX Hennesy',1,'[{\"added\": {}}]',8,1),(29,'2025-10-10 01:35:31.866510','21','Licor 43',1,'[{\"added\": {}}]',8,1),(30,'2025-10-10 01:37:06.037525','22','Lux Row Whiskey',1,'[{\"added\": {}}]',8,1),(31,'2025-10-10 01:38:52.201776','23','Old Smuggler',1,'[{\"added\": {}}]',8,1),(32,'2025-10-10 01:40:51.911050','24','OX Premium',1,'[{\"added\": {}}]',8,1),(33,'2025-10-10 01:43:09.982454','25','Baku',1,'[{\"added\": {}}]',8,1),(34,'2025-10-10 01:48:13.157913','26','Belvedere',1,'[{\"added\": {}}]',8,1),(35,'2025-10-10 01:54:32.762690','27','Billionaire Vodka',1,'[{\"added\": {}}]',8,1),(36,'2025-10-10 01:56:05.751236','28','Bombay Sapphirie',1,'[{\"added\": {}}]',8,1),(37,'2025-10-10 01:57:46.739878','29','Gran Patron Tequila',1,'[{\"added\": {}}]',8,1),(38,'2025-10-10 01:59:21.472707','30','Grey Goose',1,'[{\"added\": {}}]',8,1),(39,'2025-10-10 02:00:36.040207','31','Kurant Vodka',1,'[{\"added\": {}}]',8,1),(40,'2025-10-10 02:01:49.451471','32','Merican Harvest',1,'[{\"added\": {}}]',8,1),(41,'2025-10-10 02:04:01.242316','33','Pravda Coconut Vodka',1,'[{\"added\": {}}]',8,1),(42,'2025-10-10 02:05:46.779937','34','Roca Patron',1,'[{\"added\": {}}]',8,1),(43,'2025-10-10 02:07:17.280146','35','Smirnoff Crandberry',1,'[{\"added\": {}}]',8,1),(44,'2025-10-10 11:45:14.104328','36','Avocado kiwi Smoothie',1,'[{\"added\": {}}]',8,1),(45,'2025-10-10 11:46:55.680628','37','Berry Coffee Smoothie',1,'[{\"added\": {}}]',8,1),(46,'2025-10-10 11:47:54.966445','38','Banana Vanilla Smoothie',1,'[{\"added\": {}}]',8,1),(47,'2025-10-10 11:56:12.717838','39','Blueberry Greek Yogurt Smoothie',1,'[{\"added\": {}}]',8,1),(48,'2025-10-10 12:01:31.314195','40','Blueberry Milkshake',1,'[{\"added\": {}}]',8,1),(49,'2025-10-10 12:01:49.727401','36','Avocado kiwi Smoothie',2,'[{\"changed\": {\"fields\": [\"Stock\"]}}]',8,1),(50,'2025-10-10 12:02:00.162962','37','Berry Coffee Smoothie',2,'[{\"changed\": {\"fields\": [\"Stock\"]}}]',8,1),(51,'2025-10-10 12:03:30.660214','41','Agave cooler',1,'[{\"added\": {}}]',8,1),(52,'2025-10-10 12:03:41.154473','38','Banana Vanilla Smoothie',2,'[{\"changed\": {\"fields\": [\"Stock\"]}}]',8,1),(53,'2025-10-10 12:05:41.993974','42','Banana Milkshake',1,'[{\"added\": {}}]',8,1),(54,'2025-10-10 12:11:03.093839','43','Batida',1,'[{\"added\": {}}]',8,1),(55,'2025-10-10 12:11:54.276442','44','Heineken',1,'[{\"added\": {}}]',8,1),(56,'2025-10-10 12:13:34.947322','45','Beer Mojito',1,'[{\"added\": {}}]',8,1),(57,'2025-10-10 12:14:54.853052','46','Berries & Cream Summer Milkshake',1,'[{\"added\": {}}]',8,1),(58,'2025-10-10 12:15:41.704403','47','Bitang Beer',1,'[{\"added\": {}}]',8,1),(59,'2025-10-10 12:17:14.580923','48','Bitter Southside',1,'[{\"added\": {}}]',8,1),(60,'2025-10-10 12:18:44.629710','49','Blue Cocktail',1,'[{\"added\": {}}]',8,1),(61,'2025-10-10 12:19:50.468728','50','Budweiser',1,'[{\"added\": {}}]',8,1),(62,'2025-10-10 12:21:41.671647','51','Castle',1,'[{\"added\": {}}]',8,1),(63,'2025-10-10 12:22:34.778032','52','Castle101',1,'[{\"added\": {}}]',8,1),(64,'2025-10-10 12:23:44.058860','53','Chartreuse Swizzle',1,'[{\"added\": {}}]',8,1),(65,'2025-10-10 12:24:49.647813','54','Chocolate Brownie Milkshake',1,'[{\"added\": {}}]',8,1),(66,'2025-10-10 12:26:22.806500','55','Coconut Milkshake',1,'[{\"added\": {}}]',8,1),(67,'2025-10-10 12:27:12.897410','56','Corona Extra',1,'[{\"added\": {}}]',8,1),(68,'2025-10-10 12:28:21.721008','57','Cuba Kola',1,'[{\"added\": {}}]',8,1),(69,'2025-10-10 12:29:28.368639','58','Desperados',1,'[{\"added\": {}}]',8,1),(70,'2025-10-10 12:31:00.978493','59','Chocolate Milkshake',1,'[{\"added\": {}}]',8,1),(71,'2025-10-10 12:32:05.483271','60','Easy Nutella Milkshake',1,'[{\"added\": {}}]',8,1),(72,'2025-10-10 12:34:04.032246','61','Flying Fish',1,'[{\"added\": {}}]',8,1),(73,'2025-10-10 12:35:03.406179','62','Gulder',1,'[{\"added\": {}}]',8,1),(74,'2025-10-10 12:38:27.397348','63','Hovels',1,'[{\"added\": {}}]',8,1),(75,'2025-10-10 12:39:42.578989','64','Long Island Tea',1,'[{\"added\": {}}]',8,1),(76,'2025-10-10 12:40:46.402703','65','Mango Smoothie',1,'[{\"added\": {}}]',8,1),(77,'2025-10-10 12:41:46.159611','66','Margarita',1,'[{\"added\": {}}]',8,1),(78,'2025-10-10 12:44:26.231383','67','Michelob',1,'[{\"added\": {}}]',8,1),(79,'2025-10-10 12:45:47.262955','68','Minty Blueberry Mojito',1,'[{\"added\": {}}]',8,1),(80,'2025-10-10 12:47:38.586729','69','Strawberry Mojito',1,'[{\"added\": {}}]',8,1),(81,'2025-10-10 12:55:32.186818','70','Oreo Milkshake',1,'[{\"added\": {}}]',8,1),(82,'2025-10-10 12:59:25.027002','71','Orual',1,'[{\"added\": {}}]',8,1),(83,'2025-10-10 13:01:04.967617','72','Papaya & Pineapple Smoothie',1,'[{\"added\": {}}]',8,1),(84,'2025-10-10 13:02:08.110502','73','Pineapple Smoothie',1,'[{\"added\": {}}]',8,1),(85,'2025-10-10 13:03:28.267297','74','Pomegranate Smoothie',1,'[{\"added\": {}}]',8,1),(86,'2025-10-10 13:04:41.027926','75','Smirnoff Ice',1,'[{\"added\": {}}]',8,1),(87,'2025-10-10 13:14:54.676879','76','Strawberry Blueberry Smoothie',1,'[{\"added\": {}}]',8,1),(88,'2025-10-10 13:33:49.646999','77','Virgin Mojito',1,'[{\"added\": {}}]',8,1),(89,'2025-10-10 13:34:56.698731','78','Vodka Cucumber Basil',1,'[{\"added\": {}}]',8,1),(90,'2025-10-10 13:36:45.129804','79','Water Melon Smoothie',1,'[{\"added\": {}}]',8,1),(91,'2025-10-10 13:37:42.234024','80','Yuengling',1,'[{\"added\": {}}]',8,1),(92,'2025-10-10 13:38:44.988199','81','Orange Mojito',1,'[{\"added\": {}}]',8,1),(93,'2025-10-10 13:40:34.147779','82','Strawberry Smoothie',1,'[{\"added\": {}}]',8,1),(94,'2025-10-10 13:41:42.883061','83','Avocado Blueberry Smoothie',1,'[{\"added\": {}}]',8,1),(95,'2025-10-10 13:44:15.891279','84','Bellinee\'s Table Water',1,'[{\"added\": {}}]',8,1),(96,'2025-10-10 13:45:26.484619','85','Empire Table Water',1,'[{\"added\": {}}]',8,1),(97,'2025-10-11 13:30:52.027508','86','Essentia Ionized Alkali Water',1,'[{\"added\": {}}]',8,1),(98,'2025-10-11 13:31:57.514245','87','Forever Water',1,'[{\"added\": {}}]',8,1),(99,'2025-10-11 13:33:43.550651','88','Glacid Water',1,'[{\"added\": {}}]',8,1),(100,'2025-10-11 13:34:56.101134','89','Life Water',1,'[{\"added\": {}}]',8,1),(101,'2025-10-11 13:36:17.136817','90','Marcs Water',1,'[{\"added\": {}}]',8,1),(102,'2025-10-11 13:46:11.750044','91','Nice Water',1,'[{\"added\": {}}]',8,1),(103,'2025-10-11 13:47:18.969497','92','Vanam Water',1,'[{\"added\": {}}]',8,1),(104,'2025-10-11 13:48:26.266316','93','Victory Water',1,'[{\"added\": {}}]',8,1),(105,'2025-10-11 13:49:28.735492','94','Vittel Water',1,'[{\"added\": {}}]',8,1),(106,'2025-10-11 13:51:19.557831','95','Zineland Water',1,'[{\"added\": {}}]',8,1),(107,'2025-10-11 13:54:00.124599','96','Affogato',1,'[{\"added\": {}}]',8,1),(108,'2025-10-11 13:55:24.832739','97','Americano',1,'[{\"added\": {}}]',8,1),(109,'2025-10-11 13:56:20.994820','98','Cappuccino',1,'[{\"added\": {}}]',8,1),(110,'2025-10-11 13:57:29.795343','99','Cortado',1,'[{\"added\": {}}]',8,1),(111,'2025-10-11 13:58:32.964705','100','Espresso',1,'[{\"added\": {}}]',8,1),(112,'2025-10-11 13:59:43.343519','101','Frappuccino',1,'[{\"added\": {}}]',8,1),(113,'2025-10-11 14:01:24.143315','102','Macchiato',1,'[{\"added\": {}}]',8,1),(114,'2025-10-11 14:02:23.214607','103','Irish Coffee',1,'[{\"added\": {}}]',8,1),(115,'2025-10-11 14:03:31.570536','104','Mocha',1,'[{\"added\": {}}]',8,1),(116,'2025-10-11 14:04:48.418072','105','Nitro Cold Brew',1,'[{\"added\": {}}]',8,1),(117,'2025-10-11 14:06:15.879277','106','Signature Espresso',1,'[{\"added\": {}}]',8,1),(118,'2025-10-13 10:48:34.560675','8','Blue Label Whiskey',3,'',8,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(9,'api','cart'),(7,'api','category'),(8,'api','item'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-10-10 00:37:01.907230'),(2,'auth','0001_initial','2025-10-10 00:37:02.594725'),(3,'admin','0001_initial','2025-10-10 00:37:02.773596'),(4,'admin','0002_logentry_remove_auto_add','2025-10-10 00:37:02.792877'),(5,'admin','0003_logentry_add_action_flag_choices','2025-10-10 00:37:02.809700'),(6,'api','0001_initial','2025-10-10 00:37:02.913230'),(7,'contenttypes','0002_remove_content_type_name','2025-10-10 00:37:03.019295'),(8,'auth','0002_alter_permission_name_max_length','2025-10-10 00:37:03.113512'),(9,'auth','0003_alter_user_email_max_length','2025-10-10 00:37:03.138256'),(10,'auth','0004_alter_user_username_opts','2025-10-10 00:37:03.157963'),(11,'auth','0005_alter_user_last_login_null','2025-10-10 00:37:03.278221'),(12,'auth','0006_require_contenttypes_0002','2025-10-10 00:37:03.283832'),(13,'auth','0007_alter_validators_add_error_messages','2025-10-10 00:37:03.302514'),(14,'auth','0008_alter_user_username_max_length','2025-10-10 00:37:03.329288'),(15,'auth','0009_alter_user_last_name_max_length','2025-10-10 00:37:03.358686'),(16,'auth','0010_alter_group_name_max_length','2025-10-10 00:37:03.386070'),(17,'auth','0011_update_proxy_permissions','2025-10-10 00:37:03.409917'),(18,'auth','0012_alter_user_first_name_max_length','2025-10-10 00:37:03.436148'),(19,'sessions','0001_initial','2025-10-10 00:37:03.497000'),(20,'api','0002_item_slug','2025-10-12 23:13:50.713120'),(21,'api','0003_cart','2025-11-02 15:29:26.179910');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('ir998w6fo4kh2tk8rccupjbh1eo0k5b7','.eJxVjDsOwjAQBe_iGlnJOruOKek5g7UfhwRQIuVTIe4OkVJA-2bmvVzmbe3ztpQ5D-bOrnan301YH2Xcgd15vE1ep3GdB_G74g-6-Otk5Xk53L-Dnpf-W7O1CKEhi8iBKqJEhDVYMhG0AAVjkSgKCq10nQRompQAtVIkBXbvD8_QN6Q:1v71Au:sj0wwutn9m-9_YnJw_DlHsg5CQq9vani6AibKrIYG-0','2025-10-24 00:40:00.194812');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-12 21:18:46
