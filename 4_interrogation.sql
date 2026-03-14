-- ============================================================
--  4_interrogation.sql
--
-- We use Alias for speed efficiency : 
--  ALIAS CONVENTIONS Tbale:
--    itm = item           clt = client        ord = order_
--    pmt = payment        pdt = paid          str = store
--    emp = employee       mat = material      hqs = headquarters
--    hst = has            cnt = contains      iof = is_made_of
--    blt = belongs_to     slt = selling_type  mgr = manager (self-join)
--    sub = subquery
--
--  Here is our usage scenario (We chose to do this scénario using AI to create à realistic and interesting scénario but querys where done by our group:
--  Lets take Marie (Marketing Manager) at Paris HQ, and she wants to prepare
--  the next seasonal sales campaign. In oder to do that she needs to analyse:
--  - which items and categories sell best,
--  - which clients are most loyal and active,
--  - how stores and their stock are performing,
--  - payment trends and order volumes.
--  Note that she also works with the Operations team who need stock and supply chain queries.



--  Part 1 - PROJECTIONS & SELECTIONS


-- Q1. List all items with their price, sorted by price ascending. Marie wants an overview of the full catalogue from cheapest to most expensive.
SELECT itm.I_name, itm.I_category, itm.I_price, itm.brand
FROM item itm
ORDER BY itm.I_price ASC;

-- Q2. List all unique item categories available in the catalogue.
SELECT DISTINCT itm.I_category
FROM item itm
ORDER BY itm.I_category;

-- Q3. Find all items whose name contains 'Yarn'.
SELECT itm.I_id, itm.I_name, itm.I_price, itm.brand
FROM item itm
WHERE itm.I_name LIKE '%Yarn%';

-- Q4. Find all items in the 'Accessory' or 'Yarn' categories priced between 8 and 20 euros. Marie targets affordable craft materials for a promotion.
SELECT itm.I_name, itm.I_category, itm.I_price, itm.brand
FROM item itm
WHERE itm.I_category IN ('Accessory', 'Yarn')
  AND itm.I_price BETWEEN 8.00 AND 20.00
ORDER BY itm.I_category, itm.I_price;

-- Q5. List all clients who are loyalty programme members, sorted alphabetically.
SELECT clt.c_id, clt.c_first_last_name, clt.c_email_adress
FROM client clt
WHERE clt.member_loyalty_prgm = TRUE
ORDER BY clt.c_first_last_name ASC;

-- Q6. List all online orders that have been delivered, sorted by total price descending.
SELECT ord.order_id, ord.Total_price, ord.delivery, ord.status
FROM order_ ord
WHERE ord.online = TRUE
  AND ord.status = 'delivered'
ORDER BY ord.Total_price DESC;

-- Q7. Find all employees whose name starts with a vowel.
SELECT emp.E_id, emp.E_first_last_name, emp.role
FROM employee emp
WHERE emp.E_first_last_name REGEXP '^[AEIOUaeiouA-y]';

-- Q8. List all payments made between January 2024 and June 2024, sorted by date.
SELECT pmt.payement_id, pmt.payement_date, pmt.amount, pmt.method
FROM payment pmt
WHERE pmt.payement_date BETWEEN '2024-01-01' AND '2024-06-30'
ORDER BY pmt.payement_date;


--  SECTION 2 - AGGREGATION FUNCTIONS WITH GROUP BY / HAVING
--  (at least 5)

-- Q9. Count the number of items per category and show average price per category. Marie wants to know which categories have the most products.   
SELECT itm.I_category,
       COUNT(*)                    AS nb_items,
       ROUND(AVG(itm.I_price), 2)  AS avg_price,
       MIN(itm.I_price)            AS min_price,
       MAX(itm.I_price)            AS max_price
FROM item itm
GROUP BY itm.I_category
ORDER BY nb_items DESC;

-- Q10. Total revenue per payment method. Finance team wants to know which payment channels generate the most revenue.
SELECT pmt.method,
       COUNT(*)                    AS nb_payments,
       SUM(pmt.amount)             AS total_revenue,
       ROUND(AVG(pmt.amount), 2)   AS avg_payment
FROM payment pmt
GROUP BY pmt.method
ORDER BY total_revenue DESC;

-- Q11. Number of orders per client, showing only clients with more than 1 order. Marie targets frequent buyers for an exclusive loyalty offer.     
SELECT clt.c_first_last_name,
       COUNT(ord.order_id)   AS nb_orders,
       SUM(ord.Total_price)  AS total_spent
FROM client clt
JOIN order_ ord ON clt.c_id = ord.c_id
GROUP BY clt.c_id, clt.c_first_last_name
HAVING COUNT(ord.order_id) > 1
ORDER BY total_spent DESC;

-- Q12. Average stock level per store. Operations wants to spot under-stocked locations.    
SELECT str.store_id,
       str.store_location,
       ROUND(AVG(hst.disponibility), 1)  AS avg_stock,
       SUM(hst.disponibility)            AS total_stock,
       COUNT(hst.I_id)                   AS nb_distinct_items
FROM store str
JOIN has hst ON str.store_id = hst.store_id
GROUP BY str.store_id, str.store_location
ORDER BY avg_stock ASC;

-- Q13. Total number of orders containing each item, showing only items that appear in more than 2 orders. Identifies best-sellers for the campaign.
SELECT itm.I_name,
       itm.I_category,
       COUNT(cnt.order_id) AS nb_orders_containing_item
FROM item itm
JOIN contains cnt ON itm.I_id = cnt.I_id
GROUP BY itm.I_id, itm.I_name, itm.I_category
HAVING COUNT(cnt.order_id) > 2
ORDER BY nb_orders_containing_item DESC;

-- Q14. Number of employees per store, only stores with at least 2 staff.
SELECT str.store_location,
       COUNT(emp.E_id) AS nb_employees
FROM store str
JOIN employee emp ON str.store_id = emp.store_id
GROUP BY str.store_id, str.store_location
HAVING COUNT(emp.E_id) >= 2
ORDER BY nb_employees DESC;

-- Q15. Revenue per payment method grouped by year.
SELECT YEAR(pmt.payement_date)  AS year,
       pmt.method,
       COUNT(*)                 AS nb_payments,
       SUM(pmt.amount)          AS total_revenue
FROM payment pmt
GROUP BY year, pmt.method
HAVING SUM(pmt.amount) > 50
ORDER BY year, total_revenue DESC;



--  Part 3 - JOINS (internal, external, simple, multiple)


-- Q16. INNER JOIN: List each order with the client name and payment method.
SELECT ord.order_id,
       clt.c_first_last_name  AS client,
       ord.Total_price,
       ord.status,
       pmt.method             AS payment_method,
       pmt.payement_date
FROM order_  ord
JOIN client  clt ON ord.c_id        = clt.c_id
JOIN paid    pdt ON ord.order_id    = pdt.order_id
JOIN payment pmt ON pdt.payement_id = pmt.payement_id
ORDER BY ord.order_id;

-- Q17. INNER JOIN (multiple): List each item with the materials it is made of.
SELECT itm.I_name, itm.I_category, mat.material_name
FROM item       itm
JOIN is_made_of iof ON itm.I_id        = iof.I_id
JOIN material   mat ON iof.material_id = mat.material_id
ORDER BY itm.I_name, mat.material_name;

-- Q18. LEFT OUTER JOIN: List all items, including those with no stock in any store.
SELECT itm.I_id, itm.I_name, itm.I_category,
       str.store_location,
       hst.disponibility
FROM item itm
LEFT JOIN has   hst ON itm.I_id     = hst.I_id
LEFT JOIN store str ON hst.store_id = str.store_id
ORDER BY itm.I_id, str.store_location;

-- Q19. LEFT OUTER JOIN: List all clients and their orders (including clients with no orders).
SELECT clt.c_id, clt.c_first_last_name,
       ord.order_id, ord.Total_price, ord.status
FROM client clt
LEFT JOIN order_ ord ON clt.c_id = ord.c_id
ORDER BY clt.c_id;

-- Q20. INNER JOIN: Items and their selling types.
SELECT itm.I_name, itm.I_category,
       slt.ST_amount, slt.ST_weight, slt.ST_length,
       slt.ST_yarn_weight, slt.ST_yarn_ply, slt.ST_fabric_weave
FROM item         itm
JOIN belongs_to   blt ON itm.I_id  = blt.I_id
JOIN selling_type slt ON blt.ST_id = slt.ST_id
ORDER BY itm.I_name;

-- Q21. INNER JOIN (multiple): Employees with their store and HQ.
SELECT emp.E_first_last_name  AS employee,
       emp.role,
       str.store_location,
       str.hq_name            AS headquarters
FROM employee emp
JOIN store    str ON emp.store_id = str.store_id
ORDER BY str.hq_name, str.store_location, emp.role;

-- Q22. SELF JOIN: Each employee with their manager name.
SELECT emp.E_first_last_name  AS employee,
       emp.role,
       mgr.E_first_last_name  AS manager
FROM employee emp
LEFT JOIN employee mgr ON emp.manager_id = mgr.E_id
ORDER BY mgr.E_first_last_name IS NULL, mgr.E_first_last_name, emp.E_first_last_name;


--  Part 4 - NESTED QUERIES ((NOT) IN, (NOT) EXISTS, ANY, ALL)


-- Q23. IN: Find all clients who have placed at least one online order.
SELECT clt.c_id, clt.c_first_last_name, clt.c_email_adress
FROM client clt
WHERE clt.c_id IN (
    SELECT DISTINCT ord.c_id
    FROM order_ ord
    WHERE ord.online = TRUE
)
ORDER BY clt.c_first_last_name;

-- Q24. NOT IN: Find all items that have never been ordered. Marie can decide whether to discontinue or promote them.
SELECT itm.I_id, itm.I_name, itm.I_category, itm.I_price
FROM item itm
WHERE itm.I_id NOT IN (
    SELECT DISTINCT cnt.I_id
    FROM contains cnt
)
ORDER BY itm.I_category;

-- Q25. EXISTS: Find all clients who have at least one delivered order.
SELECT clt.c_id, clt.c_first_last_name
FROM client clt
WHERE EXISTS (
    SELECT 1
    FROM order_ ord
    WHERE ord.c_id   = clt.c_id
      AND ord.status = 'delivered'
)
ORDER BY clt.c_first_last_name;

-- Q26. NOT EXISTS: Find stores that carry no 'Yarn' items at all. Operations can plan a yarn stock transfer.
SELECT str.store_id, str.store_location
FROM store str
WHERE NOT EXISTS (
    SELECT 1
    FROM has  hst
    JOIN item itm ON hst.I_id = itm.I_id
    WHERE hst.store_id   = str.store_id
      AND itm.I_category = 'Yarn'
);

-- Q27. ANY: Find items whose price is higher than ANY item in the 'Yarn' category.
SELECT itm.I_id, itm.I_name, itm.I_category, itm.I_price
FROM item itm
WHERE itm.I_price > ANY (
    SELECT itm2.I_price
    FROM item itm2
    WHERE itm2.I_category = 'Yarn'
)
ORDER BY itm.I_price;

-- Q28. ALL: Find items whose price is higher than ALL items in the 'Yarn' category.  Non-yarn items more expensive than every yarn product.    
SELECT itm.I_id, itm.I_name, itm.I_category, itm.I_price
FROM item itm
WHERE itm.I_price > ALL (
    SELECT itm2.I_price
    FROM item itm2
    WHERE itm2.I_category = 'Yarn'
)
ORDER BY itm.I_price;

-- Q29. Nested IN with aggregation: Find clients whose total spending exceeds the average total spending across all clients.
SELECT clt.c_id, clt.c_first_last_name,
       SUM(ord.Total_price) AS total_spent
FROM client clt
JOIN order_ ord ON clt.c_id = ord.c_id
GROUP BY clt.c_id, clt.c_first_last_name
HAVING SUM(ord.Total_price) > (
    SELECT AVG(sub.client_total)
    FROM (
        SELECT SUM(ord2.Total_price) AS client_total
        FROM order_ ord2
        GROUP BY ord2.c_id
    ) sub
)
ORDER BY total_spent DESC;

-- Q30. NOT IN: Find all materials not used in any item currently stocked in any physical store (store_id 1-5, excluding the online store 6).
SELECT mat.material_id, mat.material_name
FROM material mat
WHERE mat.material_id NOT IN (
    SELECT DISTINCT iof.material_id
    FROM is_made_of iof
    JOIN has        hst ON iof.I_id = hst.I_id
    WHERE hst.store_id IN (1, 2, 3, 4, 5)
)
ORDER BY mat.material_name;
