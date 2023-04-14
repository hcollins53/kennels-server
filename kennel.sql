CREATE TABLE `Location` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`name`	TEXT NOT NULL,
	`address`	TEXT NOT NULL
);

CREATE TABLE `Customer` (
    `id`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `name`    TEXT NOT NULL,
    `address`    TEXT NOT NULL,
    `email`    TEXT NOT NULL,
    `password`    TEXT NOT NULL
);

CREATE TABLE `Animal` (
	`id`  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`name`  TEXT NOT NULL,
	`status` TEXT NOT NULL,
	`breed` TEXT NOT NULL,
	`customer_id` INTEGER NOT NULL,
	`location_id` INTEGER,
	FOREIGN KEY(`customer_id`) REFERENCES `Customer`(`id`),
	FOREIGN KEY(`location_id`) REFERENCES `Location`(`id`)
);


CREATE TABLE `Employee` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`name`	TEXT NOT NULL,
	`address`	TEXT NOT NULL,
	`location_id` INTEGER NOT NULL,
	FOREIGN KEY(`location_id`) REFERENCES `Location`(`id`)

);

INSERT INTO `Location` VALUES (null, 'Nashville North', "64 Washington Heights");
INSERT INTO `Location` VALUES (null, 'Nashville South', "101 Penn Ave");


INSERT INTO `Employee` VALUES (null, "Madi Peper", "35498 Madison Ave", 1);
INSERT INTO `Employee` VALUES (null, "Kristen Norris", "100 Main St", 1);
INSERT INTO `Employee` VALUES (null, "Meg Ducharme", "404 Unknown Ct", 2);
INSERT INTO `Employee` VALUES (null, "Hannah Hall", "204 Empty Ave", 1);
INSERT INTO `Employee` VALUES (null, "Leah Hoefling", "200 Success Way", 2);


INSERT INTO `Customer` VALUES (null, "Mo Silvera", "201 Created St", "mo@silvera.com", "password");
INSERT INTO `Customer` VALUES (null, "Bryan Nilsen", "500 Internal Error Blvd", "bryan@nilsen.com", "password");
INSERT INTO `Customer` VALUES (null, "Jenna Solis", "301 Redirect Ave", "jenna@solis.com", "password");
INSERT INTO `Customer` VALUES (null, "Emily Lemmon", "454 Mulberry Way", "emily@lemmon.com", "password");



INSERT INTO `Animal` VALUES (null, "Snickers", "Recreation", "Dalmation", 4, 1);
INSERT INTO `Animal` VALUES (null, "Jax", "Treatment", "Beagle", 1, 1);
INSERT INTO `Animal` VALUES (null, "Falafel", "Treatment", "Siamese", 4, 2);
INSERT INTO `Animal` VALUES (null, "Doodles", "Kennel", "Poodle", 3, 1);
INSERT INTO `Animal` VALUES (null, "Daps", "Kennel", "Boxer", 2, 2);
INSERT INTO `Animal` VALUES (null, "Cleo", "Kennel", "Poodle", 2, 2);
INSERT INTO `Animal` VALUES (null, "Popcorn", "Kennel", "Beagle", 3, 2);
INSERT INTO `Animal` VALUES (null, "Curly", "Treatment", "Poodle", 4, 2);


-- Get only the animal rows where the `id` field value is 3
SELECT
    a.id,
    a.name,
    a.breed,
    a.status,
    a.location_id,
    a.customer_id
FROM animal a
WHERE a.id = 3


SELECT
    a.id,
    a.name,
    a.breed,
    a.status,
    a.location_id,
    a.customer_id,
    l.name location_name,
    l.address location_address
FROM Animal a
JOIN Location l
    ON l.id = a.location_id


SELECT * FROM Animal ORDER BY id DESC;

ALTER TABLE Location
ADD Animals INTEGER;


        SELECT
            l.id,
            l.name,
            l.address, 
            COUNT(*) as Animals
        FROM location l
        JOIN Animal a ON a.location_id = l.id 
        GROUP BY a.location_id

CREATE TABLE `AnimalsAssignedtoEmployee` (
    `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `employee_id`  INTEGER NOT NULL,
	`animal_id` INTEGER NOT NULL,
    FOREIGN KEY(`employee_id`) REFERENCES `Employee`(`id`),
	FOREIGN KEY(`animal_id`) REFERENCES `Animal`(`id`)
); 

INSERT INTO `AnimalsAssignedtoEmployee` VALUES (null, 1, 1);
INSERT INTO `AnimalsAssignedtoEmployee` VALUES (null, 1, 2);
INSERT INTO `AnimalsAssignedtoEmployee` VALUES (null, 2, 3);
INSERT INTO `AnimalsAssignedtoEmployee` VALUES (null, 4, 4);
INSERT INTO `AnimalsAssignedtoEmployee` VALUES (null, 4, 5);


        SELECT DISTINCT
            e.id,
            e.name,
            e.address,
            e.location_id,
            l.name location_name,
            l.address location_address,
            (
           SELECT GROUP_CONCAT(a.id)
            FROM AnimalsAssignedtoEmployee t
            JOIN Animal a ON t.animal_id = a.id
            WHERE t.employee_id = e.id) as animals_assigned
            FROM Employee e
            JOIN Location l
                ON l.id = e.location_id
            LEFT OUTER JOIN AnimalsAssignedtoEmployee t
                    ON t.employee_id = e.id
            LEFT OUTER JOIN Animal a
                    ON t.animal_id = a.id
            WHERE e.id = 1

SELECT DISTINCT
            l.id,
            l.name,
            l.address,
            (
        SELECT GROUP_CONCAT(a.name) 
            FROM Animal a 
            WHERE a.location_id = l.id
            ) as assigned_animals,
            (
        SELECT GROUP_CONCAT(e.name)
            FROM Employee e
            WHERE e.location_id = l.id
            ) as assigned_employeese
        FROM location l
        JOIN Animal a 
            ON a.location_id = l.id
        JOIN Employee e 
            ON e.location_id = l.id
        WHERE l.id = 1

        SELECT
            a.id,
            a.name,
            a.breed,
            a.status,
            a.location_id,
            a.customer_id,
            l.name location_name,
            c.name customer_name
        FROM animal a
        JOIN Location l ON a.location_id = l.id
        JOIN Customer c ON a.customer_id = c.id
        WHERE a.id = 1
        