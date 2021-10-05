-- Homework 4
-- Mahrukh Khan

   Select 
   od.orderNumber,
   od.priceEach,
   od.quantityOrdered,
   p.productName,
   p.productLine,
   c.city,
   c.country,
   o.orderDate	
   
FROM orderdetails od
INNER JOIN orders o
ON o.orderNumber = od.orderNumber 
INNER JOIN products p
ON od.productCode = p.productCode
INNER JOIN customers c
ON c.customerNumber = o.customerNumber;