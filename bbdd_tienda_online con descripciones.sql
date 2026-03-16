-- =====================================================
-- SCRIPT BBDD 15/03/2026 con descripción de productos!!!
-- Hemos eliminado zapatos!!
-- =====================================================

DROP DATABASE IF EXISTS `tienda_online`;
CREATE DATABASE `tienda_online`
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE `tienda_online`;

-- -----------------------------------------------------
-- TABLA: categorias (SIN Zapatos)
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
(6,'Suéter'),
(7,'Bolsos'),
(8,'Vestidos'),
(9,'Chándal');

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
-- TABLA: usuarios
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
  `descripcion_producto` TEXT,
  PRIMARY KEY (`id_producto`),
  KEY `id_cat` (`id_cat`),
  CONSTRAINT `productos_ibfk_1`
    FOREIGN KEY (`id_cat`) REFERENCES `categorias` (`id_cat`)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- INSERTS DE PRODUCTOS ORIGINALES (del 3 al 87)
-- CON DESCRIPCIONES EXTENSAS SOLO PARA LOS QUE ESPECIFICASTE
-- -----------------------------------------------------

-- VESTIDOS MUJER (id_cat=8, id_publico=2) - CON DESCRIPCIÓN EXTENSA
INSERT INTO `productos` VALUES 
(3,'Vestido Woodbine',49.99,20,8,2,'http://localhost:9008/img/mujer_vestido_1.jpg','Descubre el Vestido Woodbine, una pieza imprescindible para tu armario de verano. Confeccionado en algodón de alta calidad, este vestido de tirantes presenta un favorecedor corte de vuelo ancho que se adapta a todas las siluetas. Su estampado floral exclusivo sobre fondo negro aporta un toque romántico y sofisticado, perfecto para ocasiones especiales o para un look diario lleno de frescura. La composición 100% algodón garantiza transpirabilidad y comodidad durante todo el día. Disponible en varias tallas para que encuentres tu ajuste perfecto.'),
(4,'Vestido Coeli',49.99,20,8,2,'http://localhost:9008/img/mujer_vestido_2.jpg','El Vestido Coeli fusiona misterio y elegancia en una prenda única. De manga larga y corte recto sin escote, su color gris se combina con un delicado estampado de símbolos astrológicos que despiertan la curiosidad. Incluye un cinturón negro ajustable para marcar la cintura y crear una silueta femenina. Confeccionado en una suave mezcla de algodón y viscosa, ofrece una caída perfecta y una comodidad excepcional. Ideal para entretiempo, ocasiones semiformales o para aquellas mujeres que buscan expresar su personalidad a través de la moda.'),
(5,'Vestido Tribal Otoño',49.99,20,8,2,'http://localhost:9008/img/mujer_vestido_3.jpg','Inspirado en la estética tribal, el Vestido Tribal Otoño te transporta a paisajes lejanos con su exclusivo estampado de símbolos agrícolas étnicos en cálidos tonos ocres sobre fondo negro. De tirantes y con vuelo completo, este vestido de algodón con licra se adapta con suavidad al cuerpo sin perder la forma, ofreciendo libertad de movimientos y frescura. Perfecto para días calurosos, looks bohemios o festivales de verano. Una prenda con carácter que no pasa desapercibida.'),
(6,'Vestido Flora',64.00,20,8,2,'http://localhost:9008/img/mujer_vestido_4.jpg','El Vestido Flora es una explosión de naturaleza y estilo. Su estampado étnico en tonos tierra evoca la belleza de los campos en flor, creando un efecto visual cálido y acogedor. Diseño de tirantes con falda de vuelo completo que dibuja una silueta femenina y elegante. Confeccionado en algodón de primera calidad con un toque de licra para mayor confort y durabilidad. Ideal para eventos al aire libre, reuniones familiares o para esas ocasiones en las que quieres sentirte especial sin renunciar a la comodidad.'),
(7,'Vestido Sonne',49.00,20,8,2,'http://localhost:9008/img/mujer_vestido_5.jpg','Sonne significa "sol" en alemán, y este vestido irradia luz allá por donde pasa. Con un alegre estampado floral en tonos ocres y tierra sobre fondo negro, este vestido de tirantes con vuelo controlado estiliza la figura de forma natural. Incluye un cinturón a juego para personalizar el ajuste y crear diferentes looks. Confeccionado en algodón 100% natural, transpirable y suave al tacto. Perfecto para combinar con sandalias planas y crear un look fresco y veraniego, o con cuñas para una ocasión más especial.'),
(8,'Vestido Spring',79.99,20,8,2,'http://localhost:9008/img/mujer_vestido_6.jpg','Como su nombre indica, el Vestido Spring captura la esencia de la primavera en una prenda. Su vibrante estampado floral en tonos rojos y verdes contrasta sobre un fondo negro profundo, creando un efecto visual lleno de vida. Diseño de tirantes con vuelo completo y caída fluida que permite total libertad de movimiento. Sin cinturón, corte ancho y relajado. Confeccionado en tejido de algodón de gramaje medio, ideal para días templados. Una prenda versátil que funciona tanto de día como de noche, solo o combinado con una chaqueta vaquera.'),
(9,'Vestido Venetzia',59.99,20,8,2,'http://localhost:9008/img/mujer_vestido_7.jpg','El Vestido Venetzia evoca los tonos de la campiña italiana con su elegante color verde umbría. Confeccionado en viscosa de alta calidad que aporta un brillo sutil y una caída espectacular, este vestido de tirantes con vuelo fluido es pura sofisticación. Incluye un cinturón marrón en tono coñac que realza la cintura y añade un punto de contraste. Fresco, elegante y con un toque distinguido. Ideal para ocasiones especiales, bodas, comuniones o para un look de oficina en los meses de verano.'),
(10,'Vestido Altair',79.99,20,8,2,'http://localhost:9008/img/mujer_vestido_8.jpg','Altair, la estrella más brillante de la constelación de Aquila, da nombre a este vestido diseñado para que brilles con luz propia. Confeccionado en algodón egipcio de primera calidad, ofrece una suavidad y durabilidad excepcionales. Diseño de tirantes con corte de vuelo amplio y estampado exclusivo que combina motivos celestiales. Cada detalle está cuidado para crear una prenda única y especial. Perfecto para eventos importantes, celebraciones o para esos momentos en los que quieres sentirte la protagonista.');

-- FALDAS MUJER (id_cat=4, id_publico=2) - CON DESCRIPCIÓN EXTENSA
INSERT INTO `productos` VALUES 
(11,'Falda Setareh',59.99,20,4,2,'http://localhost:9008/img/mujer_falda_1.jpg','Setareh significa "estrella" en persa, y esta falda es sin duda la estrella de tu armario. Confeccionada en algodón suave de alta calidad, presenta un delicado color blanco roto con patrón étnico geométrico en tonos grises inspirado en los diseños tribales del norte de África. Corte de talle alto que estiliza la figura y alarga visualmente la pierna. Largo hasta la pantorrilla con vuelo ancho y holgado que permite total libertad de movimiento. Ideal para combinar con blusas básicas, tops ajustados o camisetas, creando looks bohemios, étnicos o casuales con mucho estilo.'),
(12,'Falda Roya',45.55,20,4,2,'http://localhost:9008/img/mujer_falda_2.jpg','La Falda Roya es una prenda versátil y elegante que no puede faltar en tu armario. Color gris con patrón étnico geométrico en negro, creando un contraste sutil y sofisticado. Confeccionada en algodón 100% natural, suave al tacto y transpirable. Corte de talle alto que favorece la silueta, con largo hasta la pantorrilla. El vuelo ancho y holgado aporta movimiento y comodidad en cada paso. Los patrones geométricos están inspirados en los tejidos tradicionales bereberes, aportando un toque cultural único. Perfecta para la oficina, para un look casual pero cuidado o para ocasiones semiformales.'),
(13,'Falda Nazrin',29.99,20,4,2,'http://localhost:9008/img/mujer_falda_4.jpg','Nazrin significa "delicada" en persa, y esta falda es la delicadeza personificada. Diseño elegante en color negro con sutil estampado floral en gris que aporta un toque romántico sin ser demasiado llamativo. Corte recto que estiliza la figura, con largo hasta la pantorrilla. Confeccionada en algodón de alta calidad con un ligero elástico que mejora la comodidad y el ajuste. Talle alto que marca la cintura de forma natural. Una prenda versátil que puedes llevar tanto a la oficina como a un evento semiformal, combinada con blusas, jerséis finos o camisetas.'),
(14,'Falda Helka',30.25,20,4,2,'http://localhost:9008/img/mujer_falda_3.jpg','La Falda Helka es pura alegría en color amarillo, perfecta para dar un toque de luz a cualquier outfit. Su estampado geométrico en tonos claros crea un efecto visual dinámico y moderno. Largo hasta la rodilla, ideal para lucir en primavera y verano. Vuelo ancho y holgado que aporta frescura y movimiento con cada paso. Confeccionada en algodón ligero y transpirable. Corte alegre y primaveral que combina perfectamente con camisetas blancas básicas, tops de punto o blusas vaporosas. Una falda que irradia optimismo y buen rollo.'),
(15,'Falda Prisa',29.99,20,4,2,'http://localhost:9008/img/mujer_falda_5.jpg','La Falda Prisa, en elegante color gris con patrón geométrico en tonos claros, es la prenda perfecta para un look moderno y actual. Largo hasta la rodilla con vuelo ancho que aporta movimiento sin ser demasiado voluminosa. Confeccionada en algodón de calidad que garantiza comodidad durante todo el día. Corte holgado que permite libertad de movimientos. Ideal para combinar con blusas ajustadas o tops, creando un equilibrio de volúmenes muy favorecedor. Prenda versátil para el día a día, para la oficina o para un plan informal con amigas.'),
(16,'Falda Carolingia',30.25,20,4,2,'http://localhost:9008/img/mujer_falda_7.jpg','La Falda Carolingia es una pieza con personalidad propia, inspirada en el arte medieval europeo. Su diseño en tonos tierra con estampado geométrico evoca los manuscritos iluminados de la época carolingia. Largo hasta la rodilla con vuelo controlado. Confeccionada en algodón de gramaje medio que mantiene la estructura sin perder suavidad. Corte recto que favorece todo tipo de siluetas. Una prenda única para amantes de la historia, el arte y el diseño con carácter. Perfecta para crear looks originales y diferentes.'),
(17,'Falda Bahar',59.99,20,4,2,'http://localhost:9008/img/mujer_falda_6.jpg','Bahar significa "primavera" en persa, y esta falda larga es la primavera hecha prenda. Su estampado floral en tonos tierra sobre fondo oscuro crea un contraste elegante y sofisticado. Largo hasta la pantorrilla con corte de talle alto que estiliza la figura. Vuelo ancho que aporta movimiento y feminidad. Confeccionada en algodón suave de alta calidad. Ideal para looks bohemios, para eventos especiales o para esas ocasiones en las que quieres sentirte especialmente bella.'),
(18,'Falda Shirin',29.99,20,4,2,'http://localhost:9008/img/mujer_falda_8.jpg','Shirin significa "dulce" en persa, y esta falda corta es una dulzura de prenda. Su estampado exclusivo en tonos suaves combina motivos florales y geométricos creando un efecto visual dinámico y atractivo. Largo hasta la rodilla con vuelo completo. Confeccionada en algodón ligero y fresco, ideal para los días más cálidos. Corte de talle alto que realza la figura. Perfecta para combinar con prendas básicas y dejar que la falda sea la protagonista.');

-- CAMISETAS HOMBRE (id_cat=1, id_publico=1) - CON DESCRIPCIÓN EXTENSA
INSERT INTO `productos` VALUES 
(27,'Camiseta Vlaad Bird',19.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_1.jpg','La Camiseta Vlaad Bird es mucho más que una prenda básica. Con su exclusivo diseño de pájaro estilizado acompañado de rótulos con el nombre de la marca, esta camiseta fusiona la estética natural con la urbana. Color ocre, un tono tierra cálido y versátil que combina a la perfección con vaqueros, chinos o bermudas. Confeccionada en algodón 100% de alta calidad, ofrece una suavidad al tacto excepcional y una transpirabilidad que la hace ideal para los días más calurosos. Corte regular que se adapta cómodamente al cuerpo sin ser demasiado ajustada ni demasiado holgada. Disponible en varias tallas para que encuentres tu ajuste ideal. Una camiseta con personalidad para quienes buscan expresar su estilo único.'),
(29,'Camiseta Symbols',24.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_3.jpg','La Camiseta Symbols es para aquellos que buscan algo más que una prenda convencional. De manga larga, confeccionada en algodón de primera calidad, presenta un intrigante diseño de símbolos esotéricos en tono gris. Cada símbolo ha sido cuidadosamente seleccionado para crear una composición equilibrada y estéticamente atractiva. Perfecta para entretiempo, para esos días en los que necesitas una capa extra sin renunciar al estilo. Corte regular cómodo y favorecedor. Una camiseta que invita a la conversación y que te hará destacar allá por donde vayas.'),
(30,'Camiseta VLDSP',29.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_4.jpg','Atrévete con el color amarillo de la Camiseta VLDSP, una prenda que irradia energía y positivismo. De manga larga y confeccionada en algodón 100% de alta calidad, es extremadamente suave y cómoda. El estampado con el logotipo de la marca VLDSP en diseño tipográfico moderno y minimalista aporta el toque justo de personalidad. Perfecta para looks atrevidos y con carácter, combina a la perfección con prendas neutras como vaqueros negros, grises o blancos. Una camiseta que no pasa desapercibida y que te llenará de buen rollo.'),
(31,'Camiseta Abril',29.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_5.jpg','La Camiseta Abril, en cálido color ocre, combina un estampado de símbolos y patrones geométricos que evocan la llegada de la primavera. De manga corta, confeccionada en algodón 100% transpirable y muy cómodo. El diseño gráfico combina elementos modernos con una estética atemporal, creando una prenda versátil que puedes usar tanto para el día a día como para ocasiones más informales. Corte regular que permite libertad de movimientos. Una camiseta que se convertirá en tu aliada para los looks casuales.'),
(32,'Camiseta Magius',34.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_6.jpg','La Camiseta Magius, en color oscuro, presenta un estampado de símbolos en tono ocre óxido de hierro que crea un contraste sutil pero muy atractivo. Su diseño evoca una estética mágica y ancestral, aportando personalidad y carácter a la prenda. Confeccionada en algodón 100% de gramaje medio, es muy cómoda y duradera. Manga corta con corte regular que favorece todo tipo de siluetas. Una camiseta para quienes buscan expresar su individualidad a través de la ropa, para quienes no quieren pasar desapercibidos.'),
(33,'Camiseta Larache',29.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_7.jpg','Inspirada en los patrones y colores de la ciudad marroquí de Larache, esta camiseta de estampado étnico es una auténtica obra de arte. Sus tonos arena del desierto crean un efecto visual cálido y acogedor, transportándote a los zocos y callejuelas del norte de África. Confeccionada en algodón 100% de alta calidad, suave y transpirable. Manga corta con corte regular cómodo. Una prenda única para amantes de la cultura, los viajes y el diseño con raíces. Perfecta para combinar con prendas lisas y dejar que el estampado sea el protagonista.'),
(34,'Camiseta Romantique',34.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_8.jpg','La Camiseta Romantique fusiona el romanticismo clásico con la estética urbana moderna. En color negro, presenta un diseño de paisaje romántico en blanco y negro, de estilo pictórico, que ocupa la posición central del pecho. El rótulo de la marca, justo encima, completa una composición equilibrada y estéticamente cuidada. Confeccionada en algodón 100% de gramaje medio que garantiza durabilidad y confort. Manga corta con corte regular. Una camiseta para quienes aprecian el arte y la belleza en todas sus formas.'),
(35,'Camiseta Marina',24.99,20,1,1,'http://localhost:9008/img/hombre_camiseta_2.jpg','La Camiseta Marina es un homenaje al estilo náutico más clásico. Con su diseño de rayas horizontales en colores marinos y un pequeño letrero bordado con el logotipo de la marca, esta prenda es pura frescura y estilo. Confeccionada en algodón 100% suave y transpirable, es ideal para los días de verano. Manga corta con corte regular cómodo y favorecedor. Una prenda versátil que combina con todo y nunca pasa de moda. Perfecta para looks informales, para pasear por la playa o para una comida al aire libre.');

-- PANTALONES HOMBRE (id_cat=2, id_publico=1) - CON DESCRIPCIÓN EXTENSA
INSERT INTO `productos` VALUES 
(36,'Pantalón Solera',49.99,20,2,1,'http://localhost:9008/img/hombre_pantalon_1.jpg','El Pantalón Solera es la prenda esencial que todo hombre debe tener en su armario. Estilo chinos de corte recto en un versátil color ocre que combina a la perfección con todo tipo de prendas. Confeccionado en algodón de alta calidad, ofrece una comodidad excepcional durante todo el día. Corte recto que favorece todo tipo de siluetas, ni demasiado ancho ni demasiado ajustado. Detalles clásicos como bolsillos laterales y traseros. Ideal para looks casuales con camisetas o para ocasiones semiformales con camisas. Un pantalón que nunca falla.'),
(37,'Pantalón Vldsp',49.99,20,2,1,'http://localhost:9008/img/hombre_pantalon_2.jpg','Estos vaqueros en elegante color gris son un básico atemporal que no puede faltar en tu colección. Corte slim que se ajusta cómodamente a la pierna sin llegar a ser demasiado ceñido, estilizando la figura de forma natural. Confeccionados en denim de alta calidad con un ligero elástico que mejora la comodidad y permite total libertad de movimientos. Detalles clásicos vaqueros con costuras en contraste. Ideales para looks casuales, tanto con zapatillas deportivas como con zapatos más formales. Versátiles, cómodos y con mucho estilo.'),
(38,'Pantalón Hudson',59.99,20,2,1,'http://localhost:9008/img/hombre_pantalon_3.jpg','Los vaqueros Hudson son los clásicos de toda la vida, pero con un toque moderno. En tono azulado oscuro, presentan un corte slim que estiliza la figura sin sacrificar comodidad. Confeccionados en algodón de alta calidad con el porcentaje justo de elasticidad para adaptarse a tus movimientos. Detalles tradicionales vaqueros con costuras reforzadas y botones metálicos. Un pantalón versátil que puedes usar tanto para ir a trabajar como para un plan informal. A medida que los uses, irán adquiriendo esa personalidad única que solo los vaqueros de calidad ofrecen.'),
(39,'Pantalón Antequera',49.99,20,2,1,'http://localhost:9008/img/hombre_pantalon_4.jpg','El Pantalón Antequera es la opción perfecta para ocasiones que requieren un look más formal pero sin renunciar a la comodidad. Estilo chinos en color oscuro, con corte recto que estiliza la figura. Confeccionado en algodón de gramaje medio que mantiene la estructura sin perder suavidad. Detalles clásicos como bolsillos laterales y traseros con botón. Ideal para la oficina, reuniones de trabajo o eventos semiformales. Combínalo con camisas y zapatos de vestir para un look profesional impecable, o con una camiseta para un look más relajado.'),
(40,'Pantalón Neon',49.99,20,2,1,'http://localhost:9008/img/hombre_pantalon_5.jpg','Pantalón vaquero en tono oscuro con corte recto, un diseño clásico y atemporal que nunca pasa de moda. Confeccionado en denim de alta calidad que garantiza durabilidad y confort. Corte recto que favorece todo tipo de cuerpos, ni demasiado ancho ni demasiado ajustado. Detalles vaqueros tradicionales con costuras en tono a juego. Un pantalón versátil que funciona igual de bien con zapatillas deportivas que con botas. Cómodo, resistente y con ese estilo americano clásico que nunca falla.'),
(41,'Pantalón Skinny Puppy',34.99,20,2,1,'http://localhost:9008/img/hombre_pantalon_6.jpg','Para los amantes de los cortes ajustados, el Pantalón Skinny Puppy es la elección perfecta. Confeccionado en algodón con elasticidad, se adapta como una segunda piel sin perder comodidad. Corte moderno y actual, ideal para looks urbanos y juveniles. Color oscuro que combina con todo. Perfecto para llevar con zapatillas deportivas y camisetas oversize, creando un equilibrio de volúmenes muy actual.'),
(42,'Pantalón Gradas',45.55,20,2,1,'http://localhost:9008/img/hombre_pantalon_7.jpg','El Pantalón Gradas, en color beige, es el chino perfecto para looks casuales y elegantes a la vez. Corte recto y confeccionado en algodón de alta calidad, ofrece comodidad durante todo el día. Ideal para combinar con polos, camisas o camisetas. Perfecto para oficinas con código de vestimenta informal, para reuniones o para un look de fin de semana cuidado.'),
(43,'Pantalón Maestre',79.99,20,2,1,'http://localhost:9008/img/hombre_pantalon_8.jpg','El Pantalón Maestre es la máxima expresión de la elegancia masculina. De vestir, con corte clásico y confección impecable. Color oscuro que estiliza la figura. Ideal para ocasiones muy formales, bodas, celebraciones o eventos de empresa. Combínalo con camisa blanca y chaqueta para un look de impacto. Un pantalón para los momentos importantes.');

-- SUDADERAS HOMBRE (id_cat=3, id_publico=1) - CON DESCRIPCIÓN EXTENSA
INSERT INTO `productos` VALUES 
(44,'Sudadera VladdESP',39.99,20,3,1,'http://localhost:9008/img/hombre_sudadera_1.jpg','La Sudadera VladdESP es pura actitud. Con su diseño de camuflaje militar y el rótulo blanco del logotipo de la marca en el pecho, esta prenda es ideal para looks urbanos y con personalidad. Sin capucha, confeccionada en algodón de gramaje grueso que aporta calidez y durabilidad. Puños y dobladillo acanalados para un mejor ajuste. Perfecta para los días más fríos, para llevar sobre una camiseta o incluso con una camisa asomando por el cuello. Una sudadera que no pasa desapercibida.'),
(45,'Sudadera Bones',45.55,20,3,1,'http://localhost:9008/img/hombre_sudadera_2.jpg','La Sudadera Bones es para los amantes del rock y el estilo rebelde. Con su impactante estampado de calaveras en la parte frontal, esta prenda es pura personalidad. Confeccionada en algodón de alta calidad con tejido de gramaje alto, garantiza calidez y durabilidad. Sin capucha, con cuello redondo y puños acanalados. Ideal para looks informales con vaqueros negros y zapatillas. Una sudadera con mucho rollo.'),
(46,'Sudadera Japan',59.99,20,3,1,'http://localhost:9008/img/hombre_sudadera_3.jpg','La Sudadera Japan es una pieza única para los amantes de la cultura japonesa. En color blanco, presenta un espectacular estampado de tigre acompañado del rótulo "Japán", que evoca los grabados tradicionales nipones. El contraste del estampado sobre el fondo blanco crea un efecto visual limpio y potente. Confeccionada en algodón de alta calidad, suave al tacto pero con el gramaje suficiente para aportar calidez. Corte regular cómodo con cuello redondo y puños acanalados. Una prenda con mucho arte.'),
(47,'Sudadera DAW',39.99,20,3,1,'http://localhost:9008/img/hombre_sudadera_4.jpg','Sudadera con capucha, básica pero con estilo. Confeccionada en algodón de calidad, ofrece comodidad y calidez. Diseño informal con el logotipo de la marca. Perfecta para el día a día, para estar en casa o para un look casual. Una prenda versátil que no puede faltar en tu armario.'),
(48,'Sudadera 80s',45.55,20,3,1,'http://localhost:9008/img/hombre_sudadera_5.jpg','Revive la década de los 80 con esta sudadera de estilo retro. Colores llamativos y diseño inspirado en la estética de la época. Confeccionada en algodón de alta calidad. Perfecta para los amantes de lo vintage y para quienes buscan un look original y diferente.'),
(49,'Sudadera Grid',39.99,20,3,1,'http://localhost:9008/img/hombre_sudadera_6.jpg','Sudadera con patrón geométrico grid, un diseño moderno y actual. Confeccionada en algodón suave y cómodo. Perfecta para looks urbanos y casuales. Combínala con vaqueros y zapatillas para un look diario lleno de estilo.'),
(50,'Sudadera Nirvana',44.99,20,3,1,'http://localhost:9008/img/hombre_sudadera_7.jpg','La Sudadera Nirvana es un homenaje a la banda grunge que marcó a toda una generación. Con el icónico smiley amarillo y el logotipo de la banda sobre un fondo nebuloso en tonos púrpura y gris, esta prenda es puro sentimiento. Confeccionada en algodón 100% de alta calidad, extremadamente cómoda y suave al tacto. Gramaje medio-alto que aporta calidez sin ser demasiado pesada. Corte regular con cuello redondo y puños acanalados. Una pieza de culto para fans de Nirvana y amantes del rock alternativo.'),
(51,'Sudadera Nostromo',59.99,20,3,1,'http://localhost:9008/img/hombre_sudadera_8.jpg','Inspirada en la ciencia ficción, la Sudadera Nostromo presenta un diseño espacial único. Confeccionada en algodón de alta calidad, muy cómoda y abrigada. Perfecta para los amantes del space rock, la ciencia ficción y los looks con personalidad. Una prenda para destacar.');

-- CAMISAS HOMBRE (id_cat=5, id_publico=1) - CON DESCRIPCIÓN EXTENSA
INSERT INTO `productos` VALUES 
(52,'Camisa Nápoles',45.55,20,5,1,'http://localhost:9008/img/hombre_camisa_1.jpg','La Camisa Nápoles es la camisa blanca perfecta para el verano. En color blanco crudo, ligeramente roto, aporta un tono más natural que el blanco puro. De manga corta, confeccionada en algodón 100% transpirable y suave al tacto. Corte informal y relajado, perfecta para looks frescos y casuales. Detalles clásicos como bolsillo en el pecho. Ideal para combinar con bermudas, vaqueros o pantalones chinos. Una prenda versátil que puedes usar tanto en la ciudad como en la playa, y que nunca pasa de moda.'),
(53,'Camisa Velázquez',49.99,20,5,1,'http://localhost:9008/img/hombre_camisa_2.jpg','La Camisa Velázquez, en tonos grises fríos, es un clásico con personalidad. Su estampado a cuadros de tamaño medio crea un efecto visual equilibrado y elegante. Manga larga, perfecta para entretiempo. Confeccionada en algodón 100% suave y transpirable. Corte regular que permite llevarla tanto por dentro como por fuera del pantalón. Ideal para looks casuales pero cuidados. Combínala con vaqueros oscuros para un outfit equilibrado y con estilo. Una camisa versátil que funciona tanto para el día a día como para ocasiones especiales.'),
(54,'Camisa Thomas',47.99,20,5,1,'http://localhost:9008/img/hombre_camisa_3.jpg','La Camisa Thomas es la prenda versátil por excelencia. Gris lisa de manga larga, confeccionada en algodón de alta calidad, extremadamente cómoda y suave. Corte clásico que favorece todo tipo de siluetas. Puedes usarla tanto para looks informales, con vaqueros y zapatillas, como para ocasiones más formales, con pantalones de vestir y zapatos. Una camisa esencial que no puede faltar en ningún armario, tu aliada para cualquier ocasión.'),
(55,'Camisa Bleach Sand',59.99,20,5,1,'http://localhost:9008/img/hombre_camisa_4.jpg','La Camisa Bleach Sand es una obra de arte textil. Su estampado exclusivo simula la arena del desierto con un efecto degradado que evoca las dunas del Sáhara. Diseño moderno e informal, con manga larga y corte regular. Confeccionada en algodón de calidad que garantiza comodidad y transpiración. Los tonos arena se funden en un degradado sutil que crea profundidad y textura visual. Una prenda con personalidad para quienes buscan algo diferente, único y con mucho estilo.'),
(56,'Camisa Martial',39.99,20,5,1,'http://localhost:9008/img/hombre_camisa_5.jpg','La Camisa Martial, en color gris frío, es la camisa informal perfecta para los días más cálidos. De manga corta, confeccionada en algodón 100% de alta calidad, ligero y transpirable. Corte regular cómodo que permite libertad de movimientos. Detalles clásicos como bolsillo en el pecho. Una prenda versátil que puedes usar tanto para pasear por la ciudad como para una comida informal con amigos. Fresca, cómoda y con estilo.'),
(57,'Camisa Tokyo',49.99,20,5,1,'http://localhost:9008/img/hombre_camisa_6.jpg','La Camisa Tokyo es la camisa negra que necesitas. Un básico esencial con un toque elegante. Color negro profundo que estiliza la figura y combina con todo. Confeccionada en algodón de alta calidad, suave y cómoda. Corte clásico que permite usarla tanto en looks informales como en ocasiones más formales. Perfecta para crear outfits monocromáticos o para combinar con prendas de colores más llamativos. Una camisa versátil que no puede faltar en tu armario.'),
(58,'Camisa Alaska',65.55,20,5,1,'http://localhost:9008/img/hombre_camisa_7.jpg','La Camisa Alaska, en color granate con cuadros estilo escocés, es puro carácter. Los cuadros de tamaño medio crean un patrón tradicional con mucha personalidad. Confeccionada en algodón 100% de alta calidad, suave y cálida sin ser demasiado pesada. Manga larga, perfecta para los meses más fríos. Corte regular que permite llevar capas debajo. Ideal para looks casuales con inspiración británica. Combínala con vaqueros oscuros y botas para un outfit lleno de estilo y calidez.'),
(59,'Camisa Sorrentino',59.99,20,5,1,'http://localhost:9008/img/hombre_camisa_8.jpg','La Camisa Sorrentino fusiona la elegancia italiana con la estética retro japonesa. A rayas verticales finas en tonos suaves, crea un efecto visual que alarga la figura. Diseño informal de manga corta, perfecto para looks veraniegos con mucho estilo. Confeccionada en algodón de alta calidad, ligero y transpirable. Corte regular cómodo que permite libertad de movimientos. Una prenda con personalidad para quienes aprecian el diseño y la moda con historia.');

-- CAMISAS MUJER (id_cat=5, id_publico=2) - CON DESCRIPCIÓN EXTENSA
INSERT INTO `productos` VALUES 
(60,'Camisa The Cramps',59.99,20,5,2,'http://localhost:9008/img/mujer_camisa_1.jpg','La Camisa The Cramps es una declaración de intenciones. En rojo vibrante con moteado negro estilo punk, está inspirada en la estética de la banda homónima de garage punk de los años 70. Confeccionada en mezcla de algodón y viscosa que aporta caída y movimiento. Manga larga con corte ligeramente holgado. El moteado negro sobre el fondo rojo crea un efecto visual impactante y rebelde. Ideal para looks alternativos con mucha personalidad. Combínala con vaqueros negros ajustados y botas para un outfit rockero que no pasará desapercibido.'),
(61,'Camisa Jaifa',65.55,20,5,2,'http://localhost:9008/img/mujer_camisa_2.jpg','La Camisa Jaifa es elegancia y sofisticación. De mangas anchas, presenta un delicado patrón floral gris sobre fondo negro que combina romanticismo con un toque oscuro. Las mangas anchas aportan un volumen favorecedor y movimiento a cada paso. Confeccionada en algodón de alta calidad, suave y cómodo. Corte ligeramente holgado que permite libertad de movimientos. Ideal para looks semiformales o para ocasiones especiales. El contraste del gris sobre negro crea profundidad y elegancia. Una camisa para mujeres con estilo propio.'),
(62,'Camisa Katya',59.45,20,5,2,'http://localhost:9008/img/mujer_camisa_3.jpg','La Camisa Katya es única y especial. Con patrón de símbolos en tonos ocres sobre fondo negro, de inspiración esotérica y ancestral. Manga corta, perfecta para los días cálidos. Confeccionada en algodón 100% de alta calidad, extremadamente cómoda y transpirable. Corte regular que favorece todo tipo de siluetas. Ideal para looks informales pero con carácter. Una prenda versátil que puedes combinar tanto con vaqueros como con faldas, y que siempre aportará un toque diferente a tu outfit.'),
(63,'Camisa Harlem',39.99,20,5,2,'http://localhost:9008/img/mujer_camisa_4.jpg','Camisa informal de algodón con diseño moderno y actual. Perfecta para el día a día, para la oficina o para un look casual. Corte cómodo y versátil. Una prenda básica pero con estilo.'),
(64,'Camisa Vesna',46.25,20,5,2,'http://localhost:9008/img/mujer_camisa_5.jpg','Camisa estampada de manga larga. Diseño exclusivo con motivos florales. Confeccionada en algodón de calidad. Ideal para looks femeninos y románticos.'),
(65,'Camisa Vlaad Les',38.55,20,5,2,'http://localhost:9008/img/mujer_camisa_6.jpg','La Camisa Vlaad Les es comodidad y estilo en una sola prenda. Con estampado de flores pequeñas sobre fondo oscuro, de manga larga. Corte cómodo y tejido suave. Perfecta para el día a día, para llevar a la oficina o para un plan informal. Una camisa versátil que no puede faltar en tu armario.'),
(66,'Camisa Boletus',59.99,20,5,2,'http://localhost:9008/img/mujer_camisa_7.jpg','La Camisa Boletus es pura delicadeza. De manga larga y corte ancho, presenta un patrón tenue floral monocromo sobre fondo negro que crea un efecto visual sutil y elegante. El nombre evoca la seta, y el diseño tiene una inspiración natural y orgánica. Confeccionada en algodón de alta calidad con caída perfecta. El corte ancho permite libertad de movimientos y crea una silueta relajada pero sofisticada. Ideal para looks semiformales o para ocasiones en las que buscas comodidad sin renunciar al estilo.'),
(67,'Camisa Dakota',63.25,20,5,2,'http://localhost:9008/img/mujer_camisa_8.jpg','Camisa de diseño exclusivo. Estampado único y corte moderno. Confeccionada en algodón de alta calidad. Perfecta para looks con personalidad.');

-- PANTALONES MUJER (id_cat=2, id_publico=2) - CON DESCRIPCIÓN EXTENSA
INSERT INTO `productos` VALUES 
(68,'Pantalón Vlaadcrin 70s',65.25,20,2,2,'http://localhost:9008/img/mujer_pantalon_1.jpg','El Pantalón Vlaadcrin 70s es puro estilo retro. De corte ancho y talle alto, con inspiración en los años 70. Color vaquero oscuro que aporta un toque clásico y versátil. Las perneras anchas crean una silueta fluida y elegante, con mucho movimiento. Confeccionado en denim de calidad con el punto justo de rigidez. Ideal para looks retro, bohemios o para quienes buscan comodidad sin renunciar al estilo. Combínalo con tops ajustados para equilibrar el volumen y crear un outfit espectacular.'),
(69,'Pantalón Oblast',45.55,20,2,2,'http://localhost:9008/img/mujer_pantalon_2.jpg','El Pantalón Oblast es pura actitud. Vaquero oscuro de corte recto con rodillas desgastadas, un diseño con personalidad y estilo urbano. El desgaste en las rodillas aporta un toque rockero y juvenil. Corte recto que estiliza la figura sin ser demasiado ajustado. Confeccionado en denim de calidad con ligera elasticidad para mayor comodidad. Ideal para looks casuales con mucho rollo. Combínalo con camisetas básicas y zapatillas para un outfit diario lleno de estilo.'),
(70,'Pantalón Peggy',68.25,20,2,2,'http://localhost:9008/img/mujer_pantalon_3.jpg','El Pantalón Peggy es delicadeza y elegancia. De corte recto con talle alto en color rosa asalmonado, un tono suave y femenino que aporta luz a cualquier outfit. Confeccionado en algodón de alta calidad, suave y cómodo. El corte recto favorece todo tipo de siluetas, mientras que el talle alto estiliza la figura. Ideal para looks primaverales o para ocasiones en las que buscas un toque de color suave y elegante. Combínalo con tonos neutros para un look equilibrado y sofisticado.'),
(71,'Pantalón Boreal',59.99,20,2,2,'http://localhost:9008/img/mujer_pantalon_4.jpg','El Pantalón Boreal es comodidad y estilo. Ajustado de corte recto con estampado floral en tonos tierra. Confeccionado en algodón cómodo y elástico que se adapta al cuerpo sin perder la forma. El estampado floral, en tonos ocres y marrones, aporta un toque natural y romántico. Corte recto que estiliza la figura. Ideal para looks informales pero cuidados. Combínalo con prendas lisas en tonos neutros para dejar que el estampado sea el protagonista.'),
(72,'Pantalón Chicago',63.25,20,2,2,'http://localhost:9008/img/mujer_pantalon_5.jpg','Pantalón de diseño moderno. Corte actual y tejido de calidad. Ideal para looks urbanos y casuales.'),
(73,'Pantalón Shoreline Gold',79.99,20,2,2,'http://localhost:9008/img/mujer_pantalon_7.jpg','Pantalón elegante en tono dorado. Perfecto para ocasiones especiales. Corte favorecedor y tejido de alta calidad.'),
(74,'Pantalón Pompeya',68.55,20,2,2,'http://localhost:9008/img/mujer_pantalon_8.jpg','El Pantalón Pompeya es una pieza única. Corte elegante y tejido de calidad. Ideal para looks sofisticados.'),
(75,'Pantalón Mahnaz',75.55,20,2,2,'http://localhost:9008/img/mujer_pantalon_6.jpg','Pantalón de diseño exclusivo. Acampanado de talle alto con estampado geométrico sobre fondo blanco. Inspirado en la estética de los años 70 pero con un toque moderno. Confeccionado en mezcla de lino y algodón, fresca y transpirable, ideal para los días más cálidos. La campana suave crea una silueta femenina y con movimiento. El estampado geométrico en tonos tierra aporta personalidad y estilo. Una prenda única para amantes de la moda con carácter.');

-- SUÉTERES MUJER (id_cat=6, id_publico=2) - CON DESCRIPCIÓN EXTENSA
INSERT INTO `productos` VALUES 
(76,'Suéter Polar Vlaad',75.55,20,6,2,'http://localhost:9008/img/mujer_sueter_1.jpg','El Suéter Polar Vlaad es pura calidez con estilo. De punto largo y ancho, con patrón floral gris horizontal sobre fondo negro. Diseño oversize que aporta comodidad y un look relajado y moderno. Confeccionado en fibras naturales de alta calidad que garantizan calidez y suavidad. El patrón floral horizontal crea un efecto visual dinámico y atractivo. Ideal para los días más fríos, puedes combinarlo con leggings o vaqueros ajustados. Una prenda versátil que funciona tanto para looks casuales como para ocasiones más arregladas.'),
(78,'Suéter Oliv',65.55,20,6,2,'http://localhost:9008/img/mujer_sueter_3.jpg','El Suéter Oliv, en color caqui, es el básico elegante que necesitas. Liso, de punto de alta calidad, suave y cálido. Corte regular que favorece todo tipo de siluetas. Un básico esencial para el armario de invierno. Puedes usarlo solo o como capa intermedia. Ideal para looks monocromáticos o para combinar con prendas de colores más llamativos. La sencillez de este diseño lo convierte en una prenda extremadamente versátil que te acompañará durante muchos inviernos.'),
(79,'Suéter Carmen',59.99,20,6,2,'http://localhost:9008/img/mujer_sueter_4.jpg','El Suéter Carmen es elegancia y personalidad. Negro con patrón geométrico en granate, inspirado en el arte popular del este de Europa. Los motivos geométricos crean un contraste llamativo sobre el fondo negro. Manga larga, perfecta para el invierno. Confeccionado en fibras naturales de alta calidad que garantizan calidez y comodidad. Corte regular que favorece la silueta. Ideal para looks informales pero cuidados, para ir a trabajar o para un plan de fin de semana.'),
(81,'Suéter Crystal',68.45,20,6,2,'http://localhost:9008/img/mujer_sueter_6.jpg','Suéter de punto fino con detalles de cristal. Elegante y sofisticado. Perfecto para ocasiones especiales.'),
(82,'Suéter Aachen',49.99,20,6,2,'http://localhost:9008/img/mujer_sueter_7.jpg','Suéter de diseño clásico. Cómodo y cálido. Ideal para el día a día.'),
(83,'Suéter Wintertalk',74.45,20,6,2,'http://localhost:9008/img/mujer_sueter_8.jpg','Suéter grueso para los días más fríos. Diseño exclusivo. Muy cálido y cómodo.'),
(86,'Suéter Sunny Day',39.99,20,6,2,'http://localhost:9008/img/mujer_sueter_12.jpg','Suéter ligero y alegre. Perfecto para días soleados de invierno. Diseño fresco y juvenil.'),
(87,'Suéter Primavera',65.55,20,6,2,'http://localhost:9008/img/mujer_sueter_5.jpg','El Suéter Primavera es calidez y romanticismo. En marrón oscuro con delicado patrón floral en tonos ocres. Un diseño cálido y acogedor, perfecto para los meses más fríos. Los motivos florales aportan un toque romántico y femenino. Manga larga con corte regular cómodo. Confeccionado en fibras naturales de alta calidad, suave al tacto y muy cálido. Ideal para looks casuales de invierno. Combínalo con vaqueros o faldas largas para crear outfits llenos de estilo y calidez.');

-- JUNIOR - CHÁNDAL Y SUDADERAS (id_cat=3, id_publico=3) - CON DESCRIPCIÓN
INSERT INTO `productos` VALUES 
(88,'Vlaad Grey',45.00,27,9,3,'http://localhost:9008/img/junior_chandal_1.jpg','Chándal completo en color gris, confeccionado en algodón de alta calidad extremadamente cómodo. La sudadera incluye capucha forrada interior y bolsillo canguro. El pantalón tiene cintura elástica con cordón y bolsillos laterales. Perfecto para el día a día, para ir al instituto o para estar en casa. Tejido suave y transpirable que garantiza comodidad durante todo el día. Disponible en varias tallas para jóvenes.'),
(89,'Vlaad Black',45.00,14,9,3,'http://localhost:9008/img/junior_chandal_2.jpg','Chándal completo en color negro, un básico esencial para cualquier armario juvenil. Sudadera con capucha forrada y bolsillo canguro. Pantalón con cintura elástica y bolsillos. Confeccionado en algodón 100% de alta calidad, suave y cómodo. El color negro combina con todo y siempre queda bien. Ideal para looks casuales, para ir al instituto o para actividades al aire libre.'),
(90,'Retro 80s',49.99,20,9,3,'http://localhost:9008/img/junior_chandal_3.jpg','Chándal con inspiración años 80, con colores llamativos y diseño retro. Sudadera con capucha y estampados que evocan la estética de la década. Confeccionado en algodón de alta calidad, cómodo y transpirable. Pantalón con cintura elástica y detalles de color en las perneras. Perfecto para quienes buscan un look original y con personalidad. Ideal para el instituto o para quedar con amigos.'),
(91,'Quinqui total',65.75,22,9,3,'http://localhost:9008/img/junior_chandal_4.jpg','Chándal retro de licra. Todo sea dicho, un tanto inapropiado para su hijo.'),
(92,'Serbia 90s',49.99,20,9,3,'http://localhost:9008/img/junior_chandal_5.jpg','Chándal estilo años 80 con combinación de colores llamativos. La sudadera con capucha incluye detalles de líneas de color en las mangas y el bajo. El pantalón tiene cintura elástica y líneas de color en los laterales. Confeccionado en algodón y elastano de alta calidad, muy cómodo y transpirable. Un diseño con personalidad para los amantes de la estética retro. Perfecto para looks casuales llenos de estilo.'),
(93,'Chándal Vintage 80s',49.99,20,9,3,'http://localhost:9008/img/junior_chandal_6.jpg','Chándal estilo años 80 con combinación de colores llamativos. La sudadera con capucha incluye detalles de líneas de color en las mangas y el bajo. El pantalón tiene cintura elástica y líneas de color en los laterales. Confeccionado en algodón de alta calidad, muy cómodo y transpirable. Un diseño con personalidad para los amantes de la estética retro. Perfecto para looks casuales llenos de estilo.'),
(94,'Just Like Heaven',49.99,20,9,3,'http://localhost:9008/img/junior_chandal_7.jpg','Chándal blanco, muy cómodo.'),
(95,'Power Ranger',99.99,18,9,3,'http://localhost:9008/img/junior_chandal_8.jpg','Otro chándal tremendamente inapropiado para su hijo. Piénselo dos veces.'),
-- sudaderas
(96,'Rubik',74.50,10,3,3,'http://localhost:9008/img/junior_sudadera_1.jpg','Sudadera verde con estampado del rompecabezas Rubik'),
(97,'DOOM',65.75,9,3,3,'http://localhost:9008/img/junior_sudadera_2.jpg','Sudadera negra con el icónico logotipo del videojuego DOOM. Un diseño para auténticos fans de los videojuegos clásicos. Confeccionada en 100% algodón de alta calidad, extremadamente cómoda y suave. Gramaje medio-alto que aporta calidez sin ser demasiado pesada. Sin capucha, con cuello redondo y puños acanalados. El estampado del logotipo de DOOM en la parte frontal es de alta calidad y durabilidad. Ideal para jugadores y amantes de la cultura gamer.'),
(98,'VlaadESP',65.75,11,3,3,'http://localhost:9008/img/junior_sudadera_3.jpg','Sudadera con logo VlaadESP. Super molón.'),
(99,'Chess',65.75,28,3,3,'http://localhost:9008/img/junior_sudadera_4.jpg','Sudadera blanca con la silueta del caballo, la figura de ajedrez.'),
(100,'Tiger',65.75,11,3,3,'http://localhost:9008/img/junior_sudadera_5.jpg','Sudadera negra con estampado de tigre.'),
(101,'Skull',65.75,20,3,3,'http://localhost:9008/img/junior_sudadera_6.jpg','Sudadera roja con calavera.'),
(102,'Nirvana',39.99,38,3,3,'http://localhost:9008/img/junior_sudadera_7.jpg','Sudadera negra con el smiley amarillo y el logotipo de Nirvana, el icono grunge por excelencia. Confeccionada en 100% algodón de alta calidad, muy suave y cómoda. Sin capucha, con cuello redondo y puños acanalados. El estampado reproduce fielmente el diseño original de la banda. Una prenda de culto para fans de Nirvana y amantes del rock alternativo. Perfecta para el día a día y para llevar tu pasión musical a todas partes.'),
(103,'Large Ship',65.75,15,3,3,'http://localhost:9008/img/junior_sudadera_8.jpg','Sudadera gris con barco.');

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
  `id_favorito` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  PRIMARY KEY (`id_favorito`),
  UNIQUE KEY `unique_usuario_producto` (`id_usuario`, `id_producto`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `favoritos_ibfk_1`
    FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `favoritos_ibfk_2`
    FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB;

