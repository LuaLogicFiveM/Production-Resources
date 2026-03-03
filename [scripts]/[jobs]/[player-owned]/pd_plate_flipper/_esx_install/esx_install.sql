
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('pd_licence_plate_flipper', 'Plate Flipper Install Kit', 1, 0, 1);
INSERT INTO items (name, label, weight, rare, can_remove) SELECT 'pd_screwdriver', 'Screwdriver', 1, 0, 1 WHERE NOT EXISTS (SELECT * FROM items WHERE name = 'pd_screwdriver');
