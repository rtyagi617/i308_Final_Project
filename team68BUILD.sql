Drop table if exists joe_rent_transaction CASCADE;
Drop table if exists joe_purchase_transaction CASCADE;
Drop table if exists joe_employee CASCADE;
Drop table if exists joe_customer CASCADE;
Drop table if exists joe_item CASCADE;
Drop table if exists joe_supplier CASCADE;


CREATE TABLE joe_supplier (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(50) NOT NULL,
    point_of_contact VARCHAR(50) NOT NULL,
    poc_phone VARCHAR(20) NOT NULL,
    street VARCHAR(50) NOT NULL,
    state CHAR(2) NOT NULL,
    city VARCHAR(50) NOT NULL,
    zip VARCHAR(10) NOT NULL
) ENGINE = INNODB;

CREATE TABLE joe_item (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	purchase_price DECIMAL(10, 2) NOT NULL,
	rental_price DECIMAL(10, 2) NOT NULL,
	max_rental_days INT NOT NULL,
	item_condition VARCHAR(50) NOT NULL
) ENGINE = INNODB;

CREATE TABLE joe_customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name_f VARCHAR(50) NOT NULL,
    name_m VARCHAR(50) NULL,
    name_l VARCHAR(50) NOT NULL,
    street VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    zipcode CHAR(10) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    loyalty_program CHAR(1) NOT NULL
) ENGINE = INNODB;

CREATE TABLE joe_employee (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    ssn INT NOT NULL,
    name_f VARCHAR(20) NOT NULL,
    name_m VARCHAR(20) NULL,
    name_l VARCHAR(20) NOT NULL,
    street VARCHAR(50) NOT NULL,
    state CHAR(2) NOT NULL,
    city VARCHAR(50) NOT NULL,
    zip CHAR(5) NOT NULL,
    phone CHAR(10) NOT NULL,
    email VARCHAR(30) NOT NULL,
    emp_role VARCHAR(255) NOT NULL
) ENGINE = INNODB;

CREATE TABLE joe_rent_transaction (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sup_id INT NOT NULL, 
    item_id INT NOT NULL,
    emp_id INT NOT NULL,
    cust_id INT NOT NULL,
    sum_total DECIMAL(10, 2) NOT NULL,
    item VARCHAR(40) NOT NULL,
    date_rented DATE NOT NULL,
    date_returned DATE NOT NULL,
    condition_returned VARCHAR(255) NOT NULL,
    damage_fees DECIMAL(10, 2) NULL,
    late_fees DECIMAL(10, 2) NULL,
    FOREIGN KEY (sup_id) REFERENCES joe_supplier(id),
    FOREIGN KEY (item_id) REFERENCES joe_item(id),
    FOREIGN KEY (emp_id) REFERENCES joe_employee(id),
    FOREIGN KEY (cust_id) REFERENCES joe_customer(id)
) ENGINE = INNODB;

CREATE TABLE joe_purchase_transaction (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sup_id INT NOT NULL, 
    item_id INT NOT NULL,
    emp_id INT NOT NULL,
    cust_id INT NOT NULL,
    sum_total DECIMAL(10, 2) NOT NULL,
    item VARCHAR(40) NOT NULL,
    discount DECIMAL(10, 2) NULL,
    FOREIGN KEY (sup_id) REFERENCES joe_supplier(id),
    FOREIGN KEY (item_id) REFERENCES joe_item(id),
    FOREIGN KEY (emp_id) REFERENCES joe_employee(id),
    FOREIGN KEY (cust_id) REFERENCES joe_customer(id)
) ENGINE = INNODB;



INSERT INTO joe_supplier(id, company_name, point_of_contact, poc_phone, street, state, city, zip) VALUES
    (1, 'Stark Industries', 'tony@starkindustries.com', '615-555-0110', '100 Industrial Way', 'TN', 'Nashville', '37210'),
    (2, 'Wayne Enterprises', 'bruce@wayneenterprises.com', '615-555-0220', '200 Gotham Blvd', 'TN', 'Memphis', '38104'),
    (3, 'Dunder Mifflin', 'michael@dundermifflin.com', '615-555-0330', '300 Paper Street', 'TN', 'Knoxville', '37919'),
    (4, 'SPECTRE', 'blofeld@spectre.org', '615-555-0440', '400 Shadow Lane', 'TN', 'Chattanooga', '37402'),
    (5, 'Acme Corp', 'wile@acmecorp.com', '615-555-0550', '500 Anvil Rd', 'TN', 'Clarksville', '37040'),
    (6, 'Oscorp Industries', 'norman@oscorp.com', '615-555-0660', '600 Spider Web Way', 'TN', 'Murfreesboro', '37128'),
    (7, 'Bluth Company', 'george@bluthcompany.com', '615-555-0770', '700 Banana Stand St', 'TN', 'Franklin', '37064'),
    (8, 'InGen', 'john@ingen.com', '615-555-0880', '800 Dino Park Rd', 'TN', 'Jackson', '38301'),
    (9, 'Pawnee City Hall', 'leslie@pawnee.gov', '615-555-0990', '900 Government Plaza', 'TN', 'Johnson City', '37604'),
    (10, 'Planet Express', 'fry@planetexpress.com', '615-555-1010', '1000 Future St', 'TN', 'Cookeville', '38501'),
    (11, 'Sterling Cooper', 'don@sterlingcooper.com', '615-555-1110', '1100 Madison Ave', 'TN', 'Cleveland', '37311'),
    (12, 'Massive Dynamic', 'nina@massivedynamic.com', '615-555-1212', '1200 SciTech Blvd', 'TN', 'Collierville', '38017'),
    (13, 'Vandelay Industries', 'art@vandelay.com', '615-555-1313', '1300 Importer Ln', 'TN', 'Brentwood', '37027'),
    (14, 'Cyberdyne Systems', 'miles@cyberdyne.com', '615-555-1414', '1400 Skynet Way', 'TN', 'Germantown', '38138'),
    (15, 'Wonka Industries', 'willy@wonka.com', '615-555-1515', '1500 Chocolate Rd', 'TN', 'Bartlett', '38133');

ALTER TABLE joe_item
ADD COLUMN supplier_id INT;

ALTER TABLE joe_item
ADD CONSTRAINT fk_supplier_id
FOREIGN KEY (supplier_id) REFERENCES joe_supplier(id);

INSERT INTO joe_item (id, name, purchase_price, rental_price, max_rental_days, item_condition, supplier_id) VALUES
    (1, 'Hammer', 10.99, 5.99, 30, 'New', 1),
    (2, 'Drill', 49.99, 19.99, 45, 'Used', 1),
    (3, 'Saw', 29.99, 12.99, 60, 'Refurbished', 2),
    (4, 'Screwdriver Set', 15.99, 7.99, 30, 'New', 2),
    (5, 'Wrench', 8.99, 4.99, 30, 'Used', 3),
    (6, 'Power Sander', 79.99, 29.99, 60, 'New', 3),
    (7, 'Paint Roller', 7.99, 3.99, 45, 'Used', 4),
    (8, 'Measuring Tape', 5.99, 2.99, 30, 'New', 4),
    (9, 'Pliers', 6.99, 3.49, 30, 'Used', 5),
    (10, 'Ladder', 89.99, 39.99, 90, 'Used', 5),
    (11, 'Extension Cord', 12.99, 6.99, 30, 'New', 6),
    (12, 'Nail Gun', 59.99, 24.99, 45, 'Refurbished', 6),
    (13, 'Toolbox', 19.99, 9.99, 60, 'Used', 7),
    (14, 'Circular Saw', 99.99, 39.99, 60, 'New', 7),
    (15, 'C-clamp', 3.99, 1.99, 30, 'Used', 8),
    (16, 'Chainsaw', 149.99, 69.99, 60, 'Refurbished', 8),
    (17, 'Hacksaw', 8.99, 3.99, 30, 'New', 9),
    (18, 'Sledgehammer', 24.99, 11.99, 60, 'Used', 9),
    (19, 'Angle Grinder', 69.99, 29.99, 45, 'New', 10),
    (20, 'Step Ladder', 34.99, 14.99, 90, 'Used', 10),
    (21, 'Jigsaw', 35.99, 14.99, 30, 'New', 11),
    (22, 'Electric Screwdriver', 29.99, 12.99, 30, 'Used', 11),
    (23, 'Router', 69.99, 29.99, 45, 'New', 12),
    (24, 'Chisel Set', 19.99, 8.99, 60, 'Refurbished', 12),
    (25, 'Wire Stripper', 11.99, 5.99, 30, 'Used', 13),
    (26, 'Voltage Tester', 15.99, 6.99, 30, 'New', 13),
    (27, 'Saw Horse', 22.99, 10.99, 30, 'Used', 14),
    (28, 'Allen Key Set', 7.99, 3.49, 30, 'New', 14),
    (29, 'Pipe Wrench', 17.99, 7.99, 45, 'Used', 15),
    (30, 'Heat Gun', 45.99, 18.99, 60, 'New', 15);

ALTER TABLE joe_customer
ADD COLUMN loyalty_member_since DATE;

INSERT INTO joe_customer (id, name_f, name_m, name_l, street, state, city, zipcode, phone, email, loyalty_program, loyalty_member_since) VALUES
    (1, 'Bruce', NULL, 'Wayne', '1007 Mountain Drive', 'NY', 'Gotham', '10001', '555-1939', 'bwayne@wayneenterprises.com', 'Y', '2004-05-15'),
    (2, 'Peter', NULL, 'Parker', '20 Ingram Street', 'NY', 'New York', '10010', '555-1962', 'pparker@dailybugle.com', 'Y', '2005-08-12'),
    (3, 'Spike', NULL, 'Spiegel', '99 Mars Blvd', 'CA', 'Redlands', '92373', '555-2077', 'spike@bebop.net', 'N', NULL),
    (4, 'Edward', NULL, 'Elric', '5 Alchemy Rd', 'CA', 'Central City', '90012', '555-1910', 'eelric@state.gov', 'Y', '2006-11-02'),
    (5, 'Matt', NULL, 'Murdock', '104 Hell\'s Kitchen', 'NY', 'New York', '10014', '555-1964', 'mmurdock@nelsonandmurdock.com', 'Y', '2004-09-18'),
    (6, 'Harry', 'James', 'Potter', '4 Privet Drive', 'TX', 'Little Whinging', '75001', '555-1997', 'hpotter@hogwarts.ac.uk', 'Y', '2007-06-26'),
    (7, 'Lara', NULL, 'Croft', '1 Croft Manor', 'FL', 'Miami', '33018', '555-2021', 'lcroft@croftarchives.co.uk', 'N', NULL),
    (8, 'John', NULL, 'Snow', '1 Castle Black', 'TX', 'Houston', '77002', '555-2069', 'jsnow@nightswatch.org', 'N', NULL),
    (9, 'Tony', NULL, 'Stark', '10880 Malibu Point', 'CA', 'Malibu', '90265', '555-2020', 'tstark@starkindustries.com', 'Y', '2004-01-01'),
    (10, 'Katniss', NULL, 'Everdeen', '12 Seam St', 'FL', 'Panem', '32003', '555-2012', 'keverdeen@panemgov.org', 'Y', '2010-08-24'),
    (11, 'Ellen', NULL, 'Ripley', 'LV-426 Nostromo St', 'IL', 'Chicago', '60607', '555-1979', 'eripley@weylandcorp.com', 'Y', '2006-04-26'),
    (12, 'Sherlock', NULL, 'Holmes', '221B Baker Street', 'WA', 'London', '98101', '555-1895', 'sholmes@detective.co.uk', 'Y', '2004-03-15'),
    (13, 'Dorothy', NULL, 'Gale', '1 Yellow Brick Road', 'GA', 'Oz', '30301', '555-1939', 'dgale@ozmail.com', 'N', NULL),
    (14, 'Walter', 'Hartwell', 'White', '308 Negra Arroyo Lane', 'NM', 'Albuquerque', '87101', '555-2008', 'wwhite@graymattertech.com', 'N', NULL),
    (15, 'Rick', NULL, 'Sanchez', '1721 Street Ave', 'CA', 'San Diego', '92101', '555-1998', 'rsanchez@c137.com', 'Y', '2005-07-04');

ALTER TABLE joe_employee
ADD COLUMN join_date DATE;

INSERT INTO joe_employee (id, ssn, name_f, name_m, name_l, street, state, city, zip, phone, email, emp_role, join_date) VALUES
    (1, 123456789, 'Norman', 'F', 'Osborn', '123 Villain Ave', 'NY', 'New York', '10001', '555-0001', 'norman.osborn@example.com', 'Senior Manager', '2004-06-01'),
    (2, 987654321, 'Lex', NULL, 'Luthor', '456 Metropolis St', 'NY', 'Gotham', '10101', '555-0002', 'lex.luthor@example.com', 'Senior Manager', '2005-07-15'),
    (3, 456789123, 'Envy', NULL, 'Homunculus', '789 Philosopher St', 'CA', 'Central City', '90210', '555-0003', 'envy.homunculus@example.com', 'Junior Manager', '2008-08-08'),
    (4, 789123456, 'Vicious', NULL, 'Syndicate', '321 Mars Lane', 'NY', 'New York', '10002', '555-0004', 'vicious.syndicate@example.com', 'Junior Manager', '2006-09-09'),
    (5, 654321987, 'Darth', NULL, 'Vader', '567 Empire Blvd', 'CA', 'Fresno', '93727', '555-0005', 'darth.vader@example.com', 'Senior Manager', '2004-05-04'),
    (6, 321987654, 'President', 'Coriolanus', 'Snow', '234 Capitol Ave', 'CO', 'Denver', '80014', '555-0006', 'president.snow@example.com', 'Summer Intern', '2010-01-20'),
    (7, 987123654, 'Voldemort', NULL, 'Tom', '876 Dark Arts Rd', 'IL', 'Chicago', '60614', '555-0007', 'voldemort.tom@example.com', 'Summer Intern', '2009-07-30'),
    (8, 456987321, 'Night', 'King', 'White Walker', '432 Winterfell St', 'NY', 'Albany', '12203', '555-0008', 'night.king@example.com', 'Junior Salesperson', '2012-12-21'),
    (9, 321789654, 'Moriarty', 'James', 'Professor', '654 Baker St', 'MA', 'Boston', '02101', '555-0009', 'james.moriarty@example.com', 'Junior Manager', '2007-05-05'),
    (10, 654987321, 'Hans', NULL, 'Westergaard', '987 Ice Palace Way', 'MN', 'Minneapolis', '55401', '555-0010', 'hans.westergaard@example.com', 'Senior Salesperson', '2015-06-15'),
    (11, 321456789, 'Killmonger', NULL, 'Erik', '135 Wakanda St', 'CA', 'Oakland', '94612', '555-0011', 'erik.killmonger@example.com', 'Senior Salesperson', '2018-08-18'),
    (12, 987654123, 'Obadiah', 'J', 'Stane', '300 Iron Monger Ln', 'CA', 'Malibu', '90265', '555-0012', 'obadiah.stane@example.com', 'Junior Salesperson', '2004-03-03'),
    (13, 654123987, 'Ana', NULL, 'Matronic', '1800 Cyborg Ct', 'NV', 'Las Vegas', '89109', '555-0013', 'ana.matronic@example.com', 'Summer Intern', '2007-07-07'),
    (14, 789654123, 'Ares', NULL, 'God of War', '200 Battlefield Blvd', 'DC', 'Washington', '20004', '555-0014', 'ares.war@example.com', 'Senior Salesperson', '2009-09-09'),
    (15, 456321987, 'Agent', NULL, 'Smith', '101 Matrix Loop', 'CA', 'San Francisco', '94103', '555-0015', 'agent.smith@example.com', 'Junior Salesperson', '2006-06-06');



INSERT INTO joe_rent_transaction (id, sup_id, item_id, emp_id, cust_id, sum_total, item, date_rented, date_returned, condition_returned, damage_fees, late_fees) VALUES
    (1, 1, 1, 1, 1, 25.99, 'Hammer', '2024-03-01', '2024-03-03', 'GOOD', NULL, NULL),
    (2, 1, 2, 1, 2, 69.99, 'Drill', '2024-03-02', '2024-03-05', 'POOR', 5.00, 2.00),
    (3, 2, 3, 2, 1, 39.99, 'Saw', '2024-03-03', '2024-03-08', 'GOOD', NULL, NULL),
    (4, 2, 4, 2, 2, 14.99, 'Screwdriver Set', '2024-03-04', '2024-03-06', 'POOR', 2.50, 1.00),
    (5, 3, 5, 3, 3, 9.99, 'Wrench', '2024-03-05', '2024-03-07', 'GOOD', NULL, NULL),
    (6, 3, 6, 3, 4, 119.99, 'Power Sander', '2024-03-06', '2024-03-10', 'POOR', 10.00, 5.00),
    (7, 4, 7, 4, 3, 5.99, 'Paint Roller', '2024-03-07', '2024-03-09', 'GOOD', NULL, NULL),
    (8, 4, 8, 4, 4, 4.99, 'Measuring Tape', '2024-03-08', '2024-03-12', 'POOR', 1.00, 0.50),
    (9, 5, 9, 5, 5, 6.99, 'Pliers', '2024-03-09', '2024-03-15', 'GOOD', NULL, NULL),
    (10, 5, 10, 5, 6, 49.99, 'Ladder', '2024-03-10', '2024-03-17', 'POOR', 7.00, 3.50),
    (11, 6, 11, 6, 5, 7.99, 'Extension Cord', '2024-03-11', '2024-03-18', 'GOOD', NULL, NULL),
    (12, 6, 12, 6, 6, 39.99, 'Nail Gun', '2024-03-12', '2024-03-20', 'POOR', 4.00, 2.00),
    (13, 7, 13, 7, 7, 19.99, 'Toolbox', '2024-03-13', '2024-03-22', 'GOOD', NULL, NULL),
    (14, 7, 14, 7, 8, 79.99, 'Circular Saw', '2024-03-14', '2024-03-25', 'POOR', 15.00, 7.50),
    (15, 8, 15, 8, 7, 2.99, 'C-clamp', '2024-03-15', '2024-03-27', 'GOOD', NULL, NULL),
    (16, 8, 16, 8, 8, 109.99, 'Chainsaw', '2024-03-16', '2024-03-30', 'POOR', 20.00, 10.00),
    (17, 9, 17, 9, 9, 8.99, 'Hacksaw', '2024-03-17', '2024-03-30', 'GOOD', NULL, NULL),
    (18, 9, 18, 9, 10, 29.99, 'Sledgehammer', '2024-03-18', '2024-04-01', 'POOR', 6.00, 3.00),
    (19, 10, 19, 10, 9, 79.99, 'Angle Grinder', '2024-03-19', '2024-04-03', 'GOOD', NULL, NULL),
    (20, 10, 20, 10, 10, 24.99, 'Step Ladder', '2024-03-20', '2024-04-05', 'POOR', 4.50, 2.25),
    (21, 11, 21, 11, 11, 14.99, 'Jigsaw', '2024-04-01', '2024-04-04', 'GOOD', NULL, NULL),
    (22, 11, 22, 11, 12, 32.99, 'Electric Screwdriver', '2024-04-02', '2024-04-06', 'POOR', 3.00, 1.50),
    (23, 12, 23, 12, 11, 89.99, 'Router', '2024-04-03', '2024-04-10', 'GOOD', NULL, NULL),
    (24, 12, 24, 12, 12, 17.99, 'Chisel Set', '2024-04-04', '2024-04-08', 'POOR', 2.00, 1.00),
    (25, 13, 25, 13, 13, 11.99, 'Wire Stripper', '2024-04-05', '2024-04-09', 'GOOD', NULL, NULL),
    (26, 13, 26, 13, 14, 26.99, 'Voltage Tester', '2024-04-06', '2024-04-14', 'POOR', 5.00, 2.50),
    (27, 14, 27, 14, 13, 10.99, 'Saw Horse', '2024-04-07', '2024-04-12', 'GOOD', NULL, NULL),
    (28, 14, 28, 14, 14, 6.99, 'Allen Key Set', '2024-04-08', '2024-04-16', 'POOR', 1.00, 0.50),
    (29, 15, 29, 15, 15, 15.99, 'Pipe Wrench', '2024-04-09', '2024-04-18', 'GOOD', NULL, NULL),
    (30, 15, 30, 15, 15, 44.99, 'Heat Gun', '2024-04-10', '2024-04-22', 'POOR', 7.00, 3.50);


ALTER TABLE joe_purchase_transaction
ADD COLUMN date_purchased DATE NOT NULL;

INSERT INTO joe_purchase_transaction (id, sup_id, item_id, emp_id, cust_id, sum_total, item, discount, date_purchased) VALUES
    (1, 1, 1, 1, 1, 100.00, 'Hammer', 0.00, '2024-01-01'),
    (2, 1, 2, 1, 2, 150.00, 'Drill', 10.00, '2024-01-02'),
    (3, 2, 3, 2, 1, 130.00, 'Saw', 5.00, '2024-01-03'),
    (4, 2, 4, 2, 2, 120.00, 'Screwdriver Set', 0.00, '2024-01-04'),
    (5, 3, 5, 3, 3, 110.00, 'Wrench', 10.00, '2024-01-05'),
    (6, 3, 6, 3, 4, 210.00, 'Power Sander', 20.00, '2024-01-06'),
    (7, 4, 7, 4, 3, 80.00, 'Paint Roller', 0.00, '2024-01-07'),
    (8, 4, 8, 4, 4, 85.00, 'Measuring Tape', 5.00, '2024-01-08'),
    (9, 5, 9, 5, 5, 95.00, 'Pliers', 5.00, '2024-01-09'),
    (10, 5, 10, 5, 6, 205.00, 'Ladder', 25.00, '2024-01-10'),
    (11, 6, 11, 6, 5, 75.00, 'Extension Cord', 0.00, '2024-01-11'),
    (12, 6, 12, 6, 6, 180.00, 'Nail Gun', 20.00, '2024-01-12'),
    (13, 7, 13, 7, 7, 170.00, 'Toolbox', 20.00, '2024-01-13'),
    (14, 7, 14, 7, 8, 130.00, 'Circular Saw', 10.00, '2024-01-14'),
    (15, 8, 15, 8, 7, 40.00, 'C-clamp', 0.00, '2024-01-15'),
    (16, 8, 16, 8, 8, 160.00, 'Chainsaw', 0.00, '2024-01-16'),
    (17, 9, 17, 9, 9, 140.00, 'Hacksaw', 10.00, '2024-01-17'),
    (18, 9, 18, 9, 10, 125.00, 'Sledgehammer', 5.00, '2024-01-18'),
    (19, 10, 19, 10, 9, 200.00, 'Angle Grinder', 30.00, '2024-01-19'),
    (20, 10, 20, 10, 10, 100.00, 'Step Ladder', 0.00, '2024-01-20'),
    (21, 11, 21, 11, 11, 140.00, 'Jigsaw', 10.00, '2024-01-21'),
    (22, 11, 22, 11, 12, 180.00, 'Electric Screwdriver', 15.00, '2024-01-22'),
    (23, 12, 23, 12, 11, 190.00, 'Router', 10.00, '2024-01-23'),
    (24, 12, 24, 12, 12, 80.00, 'Chisel Set', 0.00, '2024-01-24'),
    (25, 13, 25, 13, 13, 120.00, 'Wire Stripper', 10.00, '2024-01-25'),
    (26, 13, 26, 13, 14, 130.00, 'Voltage Tester', 5.00, '2024-01-26'),
    (27, 14, 27, 14, 13, 115.00, 'Saw Horse', 15.00, '2024-01-27'),
    (28, 14, 28, 14, 14, 60.00, 'Allen Key Set', 0.00, '2024-01-28'),
    (29, 15, 29, 15, 15, 150.00, 'Pipe Wrench', 20.00, '2024-01-29'),
    (30, 15, 30, 15, 15, 160.00, 'Heat Gun', 20.00, '2024-01-30');


    