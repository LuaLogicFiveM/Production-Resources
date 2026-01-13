INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_leafnlatte', 'Leaf & Latte', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('leafnlatte', 'Leaf & Latte')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('leafnlatte',0,'farmer','Farmer',20,'{}','{}'),
	('leafnlatte',1,'bartender','Bartender',40,'{}','{}'),
	('leafnlatte',2,'shopkeeper','Shopkeeper',40,'{}','{}'),
	('leafnlatte',3,'manager','Manager',60,'{}','{}'),
	('leafnlatte',4,'boss','Owner',100,'{}','{}')
;
