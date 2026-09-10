-- 1. Creating the database bda_june_2026_p1
CREATE DATABASE bda_june_2026_p1;

-- 1.2. Using the database bda_june_2026_p1
USE bda_june_2026_p1;

-- 2. Creating table called clients
CREATE TABLE clients (
  client_ID INTEGER PRIMARY KEY,
  client_name VARCHAR(100),
  street_address VARCHAR(100),
  city VARCHAR(100),
  state VARCHAR(100),
  phone_number VARCHAR(100)
);

-- 2(cont.). Inserting some records into the clients table
INSERT INTO clients (
  client_ID,
  client_name,
  street_address,
  city,
  state,
  phone_number
)
VALUES 
(1,'Vinte','3 Nevada Parkway','Syracuse','NY','315-252-7305'),
(2,'Myworks','34267 Glendale Parkway','Huntington','WV','304-659-1170'),
(3,'Yadel','096 Pawling Parkway','San Francisco','CA','415-144-6037'),
(4,'Kwideo','81674 Westerfield Circle','Waco','TX','254-750-0784'),
(5,'Topiclounge','0863 Farmco Road','Portland','OR','971-888-9129')
;

-- 3. Imported the csv files as tables.

-- 4.a. Give me the list of unique states from ‘customers’ table
SELECT DISTINCT state 
FROM mosh_customers
;

-- 4.b. Say a new price for products is set as the 1.1times the unit_price. How would the
-- new price look like in ‘products’ table?
SELECT *, (unit_price * 1.1) as unit_price_new
FROM mosh_products
;

-- 4.c. Show the invoice_id, client_id, invoice_total, payment_total, invoice_date and
-- due_date from the ‘invoices’ table after the invoice_date June 2019.
SELECT invoice_id, client_id, invoice_total, payment_total, invoice_date, due_date
FROM mosh_invoices
WHERE STR_TO_DATE(invoice_date, '%c/%e/%Y') > '2019-06-30'
;

-- 4.d. Identify those customers (from ‘customers’ table) who were born after 1990
-- having points more than 1000.
SELECT * 
FROM mosh_customers
WHERE STR_TO_DATE(birth_date, '%c/%e/%Y') > '1990-12-31' AND points > 1000
;

-- 4.e. Find out those clients from ‘payments’ table with client_id 5 having amount more
-- than 20.00.
SELECT *
FROM mosh_payments 
WHERE client_id = 5 AND amount > 20
;

-- 4.f. Identify those products which are less expensive than lettuce from products table.
SELECT *
FROM mosh_products
WHERE unit_price < (
	SELECT unit_price
    FROM mosh_products
    WHERE name LIKE '%lettuce%'
)
;

-- 5.a. Show all possible payment_method names in payments table by joining
-- payments and payment_methods tables
SELECT *
FROM mosh_payments p
JOIN mosh_payment_methods pm
ON p.payment_method = pm.payment_method_id
;

-- 5.b. Show the client_id, name, state, payment_total, due_date, payment_date, phone
-- by joining the tables: clients, invoices
SELECT c.client_id, c.client_name, c.state, inv.payment_total, inv.due_date, inv.payment_date, c.phone_number
From clients c
JOIN mosh_invoices inv
ON c.client_ID = inv.client_id
;

-- 6.a. Find out clients without any invoices and output their names from clients and
-- invoices tables
SELECT client_name
FROM clients 
WHERE client_ID NOT IN (
	SELECT client_id
	FROM mosh_invoices
)
;

-- Find out all information about clients who have invoice_total larger than client 3
-- from invoices and clients table.
SELECT *
FROM clients 
WHERE client_ID IN (
	SELECT client_id
	FROM mosh_invoices
	WHERE invoice_total > (
		SELECT MAX(invoice_total) 
		FROM mosh_invoices
		WHERE client_id = 3
	)
)
;

-- 6.c. Group and rank the clients based on their invoice_total from invoices table
SELECT client_id, invoice_total,
DENSE_RANK() OVER (PARTITION BY client_id ORDER BY invoice_total DESC) as rank_in_clients
FROM mosh_invoices
;

SELECT client_id, invoice_total,
RANK() OVER (PARTITION BY client_id ORDER BY invoice_total DESC) as rank_in_clients
FROM mosh_invoices
;

-- 6.d. Find out the name of the clients with at least 2 invoices from clients and
-- invoices tables
SELECT client_name, client_ID
FROM clients 
WHERE client_ID IN (
	SELECT client_id 
	FROM mosh_invoices
	GROUP BY client_id
	HAVING COUNT(invoice_total) >= 2 
)
;

-- 6.e. Retrieve the number from invoices table who chose payment method-1 in
-- payments table
SELECT client_id, number 
FROM mosh_invoices
WHERE invoice_id IN (
	SELECT invoice_id
	FROM mosh_payments
	WHERE payment_method = 1
)
;