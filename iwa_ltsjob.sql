INSERT INTO `addon_account` (name, label, shared) VALUES
    ('society_ltds', 'LTD LS', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
    ('society_ltds', 'LTD LS', 1)
;

INSERT INTO `jobs` (name, label) VALUES
    ('ltds', 'LTD LS')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
    ('ltds', 0, 'employe', 'Employé', 100, '{}', '{}'),
    ('ltds', 1, 'boss', 'Patron', 200, '{}', '{}')
;

INSERT INTO `items` (name, label, `limit`) VALUES
	('water', 'Bouteille d eau', -1),
    ('sandwich', 'Sandwich', -1),
    ('kebab', 'Kebab', -1),
    ('jusdecarottes', 'Jus de carottes', -1),
    ('huitre', 'Huitre', -1),
    ('soda', 'Soda', -1)
;
