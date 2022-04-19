-- Lab 2
-- cminahan
-- Apr 19, 2022

USE `cminahan`;
-- AIRLINES
-- Create and populate relational tables corresponding to the AIRLINES dataset (schema and data provided on Canvas)
select * from flights;


USE `cminahan`;
-- KATZENJAMMER
-- Create and populate the KATZENJAMMER database
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (1, 1, 'trumpet');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (1, 2, 'keyboard');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (1, 3, 'accordion');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (1, 4, 'bass balalaika');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (2, 1, 'trumpet');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (2, 2, 'drums');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (2, 3, 'guitar');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (2, 4, 'bass balalaika');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (3, 1, 'drums');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (3, 1, 'ukalele');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (3, 2, 'banjo');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (3, 3, 'bass balalaika');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (3, 4, 'keyboards');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (4, 1, 'drums');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (4, 2, 'ukalele');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (4, 3, 'accordion');
INSERT INTO Instruments (SongId, BandmateId, Instrument) VALUES (4, 4, 'bass balalaika');


USE `cminahan`;
-- BAKERY
-- Create and populate the BAKERY database
INSERT INTO customers(CId,LastName,FirstName) VALUES (1,'LOGAN','JULIET');
INSERT INTO customers(CId,LastName,FirstName) VALUES (2,'ARZT','TERRELL');
INSERT INTO customers(CId,LastName,FirstName) VALUES (3,'ESPOSITA','TRAVIS');
INSERT INTO customers(CId,LastName,FirstName) VALUES (4,'ENGLEY','SIXTA');
INSERT INTO customers(CId,LastName,FirstName) VALUES (5,'DUNLOW','OSVALDO');
INSERT INTO customers(CId,LastName,FirstName) VALUES (6,'SLINGLAND','JOSETTE');
INSERT INTO customers(CId,LastName,FirstName) VALUES (7,'TOUSSAND','SHARRON');
INSERT INTO customers(CId,LastName,FirstName) VALUES (8,'HELING','RUPERT');
INSERT INTO customers(CId,LastName,FirstName) VALUES (9,'HAFFERKAMP','CUC');
INSERT INTO customers(CId,LastName,FirstName) VALUES (10,'DUKELOW','CORETTA');
INSERT INTO customers(CId,LastName,FirstName) VALUES (11,'STADICK','MIGDALIA');
INSERT INTO customers(CId,LastName,FirstName) VALUES (12,'MCMAHAN','MELLIE');
INSERT INTO customers(CId,LastName,FirstName) VALUES (13,'ARNN','KIP');
INSERT INTO customers(CId,LastName,FirstName) VALUES (14,'S''OPKO','RAYFORD');
INSERT INTO customers(CId,LastName,FirstName) VALUES (15,'CALLENDAR','DAVID');
INSERT INTO customers(CId,LastName,FirstName) VALUES (16,'CRUZEN','ARIANE');
INSERT INTO customers(CId,LastName,FirstName) VALUES (17,'MESDAQ','CHARLENE');
INSERT INTO customers(CId,LastName,FirstName) VALUES (18,'DOMKOWSKI','ALMETA');
INSERT INTO customers(CId,LastName,FirstName) VALUES (19,'STENZ','NATACHA');
INSERT INTO customers(CId,LastName,FirstName) VALUES (20,'ZEME','STEPHEN');

INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('20-BC-C-10','Chocolate','Cake',8.95);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('20-BC-L-10','Lemon','Cake',8.95);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('20-CA-7.5','Casino','Cake',15.95);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('24-8x10','Opera','Cake',15.95);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('25-STR-9','Strawberry','Cake',11.95);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('26-8x10','Truffle','Cake',15.95);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('45-CH','Chocolate','Eclair',3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('45-CO','Coffee','Eclair',3.5);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('45-VA','Vanilla','Eclair',3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('46-11','Napoleon','Cake',13.49);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('90-ALM-I','Almond','Tart',3.75);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('90-APIE-10','Apple','Pie',5.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('90-APP-11','Apple','Tart',3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('90-APR-PF','Apricot','Tart',3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('90-BER-11','Berry','Tart',3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('90-BLK-PF','Blackberry','Tart',3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('90-BLU-11','Blueberry','Tart',3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('90-CH-PF','Chocolate','Tart',3.75);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('90-CHR-11','Cherry','Tart',3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('90-LEM-11','Lemon','Tart',3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('90-PEC-11','Pecan','Tart',3.75);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('70-GA','Ganache','Cookie',1.15);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('70-GON','Gongolais','Cookie',1.15);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('70-R','Raspberry','Cookie',1.09);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('70-LEM','Lemon','Cookie',0.79);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('70-M-CH-DZ','Chocolate','Meringue',1.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('70-M-VA-SM-DZ','Vanilla','Meringue',1.15);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('70-MAR','Marzipan','Cookie',1.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('70-TU','Tuile','Cookie',1.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('70-W','Walnut','Cookie',0.79);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('50-ALM','Almond','Croissant',1.45);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('50-APP','Apple','Croissant',1.45);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('50-APR','Apricot','Croissant',1.45);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('50-CHS','Cheese','Croissant',1.75);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('50-CH','Chocolate','Croissant',1.75);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('51-APR','Apricot','Danish',1.15);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('51-APP','Apple','Danish',1.15);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('51-ATW','Almond','Twist',1.15);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('51-BC','Almond','Bear Claw',1.95);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES ('51-BLU','Blueberry','Danish',1.15);


INSERT INTO receipts(RNumber,Customer,SaleDate) VALUES (18129,15,'2007-10-28');
INSERT INTO receipts(RNumber,Customer,SaleDate) VALUES (51991,14,'2007-10-17');
INSERT INTO receipts(RNumber,Customer,SaleDate) VALUES (83085,7,'2007-10-12');
INSERT INTO receipts(RNumber,Customer,SaleDate) VALUES (70723,20,'2007-10-28');
INSERT INTO receipts(RNumber,Customer,SaleDate) VALUES (13355,7,'2007-10-12');
INSERT INTO receipts(RNumber,Customer,SaleDate) VALUES (52761,8,'2007-10-27');
INSERT INTO receipts(RNumber,Customer,SaleDate) VALUES (99002,20,'2007-10-13');
INSERT INTO receipts(RNumber,Customer,SaleDate) VALUES (58770,18,'2007-10-22');
INSERT INTO receipts(RNumber,Customer,SaleDate) VALUES (84665,6,'2007-10-10');


INSERT INTO items(Receipt,Ordinal,Item) VALUES (18129,1,'70-TU');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (51991,1,'90-APIE-10');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (51991,2,'90-CH-PF');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (51991,3,'90-APP-11');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (51991,4,'26-8x10');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (83085,1,'25-STR-9');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (83085,2,'24-8x10');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (83085,3,'90-APR-PF');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (83085,4,'51-ATW');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (83085,5,'26-8x10');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (70723,1,'45-CO');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (13355,1,'24-8x10');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (13355,2,'70-LEM');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (13355,3,'46-11');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (52761,1,'90-ALM-I');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (52761,2,'26-8x10');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (52761,3,'50-CHS');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (52761,4,'90-BLK-PF');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (52761,5,'90-ALM-I');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (99002,1,'50-CHS');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (99002,2,'45-VA');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (58770,1,'50-CHS');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (58770,2,'46-11');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (58770,3,'45-CH');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (58770,4,'20-CA-7.5');
INSERT INTO items(Receipt,Ordinal,Item) VALUES (84665,1,'90-BER-11');


USE `cminahan`;
-- CUSTOM
-- Create and populate your custom database
select * from uic;


