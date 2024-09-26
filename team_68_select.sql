/*
 QUERY 1) This query specified John Doe Smith. In the final version, the
user will be able to inquire about any and all customers!
 It is designed to return all information regarding all the transactions
 
the specified employee has made (Rohan's Query).
*/
SELECT DISTINCT
CONCAT(c.name_f, ' ', IFNULL(c.name_m, ''), ' ', c.name_l) AS
customer_full_name,
i. name AS item_purchased,
IFNULL(r.date_rented, p.date_purchased) AS transaction_date,
IFNULL(r.sum_total, p.sum_total) AS total_cost,
CONCAT(e.name_f, ' ', IFNULL(e.name_m, ''), ' ', e.name_l) AS
employee_full_name,
CASE
WHEN r.date_rented IS NOT NULL THEN 'Rental'
WHEN p.date_purchased IS NOT NULL THEN 'Purchase'
ELSE 'Unknown'
END AS transaction_type
FROM
joe_customer c
LEFT JOIN
joe_rent_transaction as r ON c.id = r.cust_id
LEFT JOIN
joe_purchase_transaction as p ON c.id = p.cust_id
JOIN
joe_item as i ON i.id = r.item_id OR i.id = p.item_id
JOIN
joe_employee as e ON e.id = r.emp_id OR e.id = p.emp_id
WHERE
c.name_f = 'John' AND c.name_m = 'Doe' AND c.name_l = 'Smith';

/*
QUERY 2) This query specifies Sarah Martinez. In the final query, the
user will be able to specify any and all employees.
Similar to the first query, this query is designed to return all
information regarding the transactions that the specified
employee has been involved in (Rohan's Query)!
*/

SELECT
CONCAT(e.name_f, ' ', IFNULL(e.name_m, ''), ' ', e.name_l) AS
employee_full_name,
e.emp_role AS position,
CASE
WHEN r.id IS NOT NULL THEN 'Rental'
WHEN p.id IS NOT NULL THEN 'Purchase'
ELSE 'Unknown'
END AS transaction_type,
CONCAT(c.name_f, ' ', IFNULL(c.name_m, ''), ' ', c.name_l) AS
customer_name,
IFNULL(r.sum_total, p.sum_total) AS total_amount,
IFNULL(r.date_rented, p.date_purchased) AS transaction_date
FROM
joe_employee e
LEFT JOIN
joe_rent_transaction as r ON e.id = r.emp_id
LEFT JOIN
joe_purchase_transaction as p ON e.id = p.emp_id
JOIN
joe_customer as c ON c.id = r.cust_id OR c.id = p.cust_id
WHERE
e.name_f = 'Sarah' AND IFNULL(e.name_m, '') = 'F' AND e.name_l =
'Martinez';

/*
QUERY 3) This query specifies Dunn and Dunn. In the final query, the
user will be able to specify any and all suppliers.
This query is designed to return information regarding what item(s)
each supplier provides to Joe's Shop! (Jake's Query)
*/

SELECT
s.company_name AS Supplier,
s.point_of_contact AS Point_of_Contact,
i. name AS Item,
i. item_condition AS 'Condition',
COUNT(DISTINCT r.id) + COUNT(DISTINCT p.id) AS Total_Transactions
FROM
joe_supplier s
JOIN
joe_item as i ON s.id = i.supplier_id
LEFT JOIN
joe_rent_transaction as r ON i.id = r.item_id
LEFT JOIN
joe_purchase_transaction as p ON i.id = p.item_id
WHERE
s.company_name = 'Dunn and Dunn'
GROUP BY
i. id;

/*
QUERY 4) This query specifices Michael James Brown. In the final query,
the user can select from any and all of the customers that are a part of
the rewards program.
This query is designed to return information regarding the total amount
of money the customer spent and the date of their last transaction.

(Johnathan's Query)
*/
SELECT
CONCAT(c.name_f, ' ', IFNULL(c.name_m, ''), ' ', c.name_l) AS
Customer_Full_Name,
c.loyalty_program,
COALESCE((
SELECT SUM(IFNULL(r.sum_total, 0) + IFNULL(p.sum_total, 0))
FROM joe_rent_transaction r
LEFT JOIN joe_purchase_transaction as p ON r.cust_id = c.id AND
p.cust_id = c.id
WHERE r.cust_id = c.id OR p.cust_id = c.id
), 0) AS Total_Spending,
COALESCE((
SELECT MAX(GREATEST(IFNULL(r.date_rented, '1000-01-01'),
IFNULL(p.date_purchased, '1000-01-01')))
FROM joe_rent_transaction r
LEFT JOIN joe_purchase_transaction as p ON r.cust_id = c.id AND
p.cust_id = c.id
WHERE r.cust_id = c.id OR p.cust_id = c.id
), 'no recent transactions') AS Last_Transaction_Date
FROM
joe_customer c
WHERE
c.loyalty_program = 'Y'
AND c.name_f = 'Michael' AND IFNULL(c.name_m, 'James') = 'James' AND
c.name_l = 'Brown';
/*
QUERY 5) This query specifies suppliers from Birmingham. In the final
query, the user can select from any and all the cities in alabama where
our suppliers are located.
This query is designed to return information regarding the revenue each
supplier has generated, giving a detailed breakdown (Malcom's Query).
*/

SELECT
s.company_name,
s.city AS Supplier_City,
SUM(CASE WHEN rt.id IS NOT NULL THEN rt.sum_total ELSE 0 END) AS
TotalRentalRevenue,
SUM(CASE WHEN pt.id IS NOT NULL THEN pt.sum_total ELSE 0 END) AS
TotalPurchaseRevenue,
SUM(CASE WHEN rt.id IS NOT NULL THEN rt.sum_total ELSE 0 END + CASE WHEN
pt.id IS NOT NULL THEN pt.sum_total ELSE 0 END) AS TotalRevenue
FROM joe_supplier s
LEFT JOIN joe_item as i ON s.id = i.supplier_id
LEFT JOIN joe_rent_transaction as rt ON i.id = rt.item_id
LEFT JOIN joe_purchase_transaction as pt ON i.id = pt.item_id
WHERE s.city = 'Birmingham'
GROUP BY s.company_name, s.city
ORDER BY TotalRevenue DESC;

/*
QUERY 6) This query specifies customers from Texas. In the final query,
the user will be able to select from any and all the states our customers
come from!
This query is desgined to return information regarding how many items
each customer has rented (malcom's query).
*/

SELECT CONCAT(c.name_f, ' ', c.name_l) AS customer_name,
COUNT(i.name) AS num_rented_items
FROM joe_rent_transaction AS rt
JOIN joe_customer AS c ON c.id = rt.cust_id
JOIN joe_item AS i ON i.id = rt.item_id
WHERE c.state = 'TX'
GROUP BY c.name_f, c.name_l
ORDER BY customer_name;
/*
QUERY 7) This query specifies employees working as sales associates. In
the final query, the user will be able to select from any and all the
different types of employees!
This query is designed to return information regarding which employee
helped which customer with which product (jakes's query)
*/

SELECT CONCAT(c.name_f, ' ', c.name_l) AS Customer,
CONCAT(e.name_f, ' ', e.name_l) AS Employee,
e.emp_role AS Employee_Role,
i. name AS Item_Name,
t.sum_total AS Transaction_Amount
FROM joe_purchase_transaction t
JOIN joe_employee e ON t.emp_id = e.id
JOIN joe_item i ON t.item_id = i.id
JOIN joe_customer c ON t.cust_id = c.id
WHERE e.emp_role = 'Sales Associate'
ORDER BY Customer;

/*
QUERY 8) This query specifies the items as new. In the query, the user
will be able to select from all types of item status.
This query returns info regarding the items based on their condition
(Johnathan's query)
*/

SELECT i.name AS Item_Name,
(SELECT COUNT(*) FROM joe_rent_transaction rt WHERE rt.item_id =
i.id) AS Rental_Count,
(SELECT COUNT(*) FROM joe_purchase_transaction pt WHERE pt.item_id
= i.id) AS Purchase_Count
FROM joe_item as i
WHERE i.item_condition = 'New'
ORDER BY i.name;