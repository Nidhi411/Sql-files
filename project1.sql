#1 Find the name and city of those customers and salesmen who lives in the same city
SELECT c.name customer,s.name salesman, s.city
      FROM customer c , salesman s 
      WHERE c.city=s.city;
      
#2. Find all those customers information whose names are ending with the letter 'n'.
SELECT *
FROM customer
  WHERE name LIKE '%n';

#3 Find highest purchase amount with customer ID and order date,for only those customers who have the highest purchase amount in a day is more than 2000
SELECT customer_id,ord_date,MAX(purch_amt) AS MAX_AMT
FROM ord_detail
    GROUP BY customer_id,ord_date
    having MAX(purch_amt)>2000;

#4.name all customer along salesman who work with them
SELECT customer.name AS CUSTOMER ,salesman.name AS SALESMAN
FROM customer 
	LEFT JOIN salesman
	ON customer.salesman_id=salesman.salesman_id;
    
#5 Display all orders issued by the salesman 'Paul' from the ord_detail  
SELECT * 
FROM ord_detail 
      WHERE salesman_id=
          ( SELECT salesman_id 
            FROM salesman 
			WHERE name ="Paul"
            );
            
#6.Display all the orders which values are greater than the average order value for 10 oct 2021
 SELECT * 
 FROM ord_detail
      WHERE purch_amt>(
             SELECT AVG(purch_amt)
             FROM ord_detail
			 WHERE ord_date='2021-10-10'
             );
#6.find all orders from salesman whose city is paris
SELECT *  
FROM ord_detail
     WHERE salesman_id IN (
           SELECT salesman_id 
           FROM salesman 
           WHERE city="Paris"
           );
           
#7.Extract data from ord_detail table for the salesman who earned the maximum commission
SELECT *  
   FROM ord_detail
   WHERE salesman_id IN (
           SELECT salesman_id 
           FROM salesman
               WHERE commission =(
               SELECT MAX(commission)
               FROM salesman));
               
#8.Find the name and ids of all salesmen who had more than one customer
SELECT c.salesman_id,s.name 
      FROM salesman s 
      JOIN customer c ON s.salesman_id=c.salesman_id
      GROUP BY c.salesman_id,s.name
      HAVING COUNT(c.salesman_id)>1;
      
#9.Write a query to find all the salesmen who worked for only one customer
SELECT c.salesman_id,s.name 
      FROM salesman s 
      JOIN customer c ON s.salesman_id=c.salesman_id
      GROUP BY c.salesman_id,s.name
      HAVING COUNT(c.salesman_id)=1;
# another way
SELECT * 
FROM salesman 
WHERE salesman_id NOT IN(
SELECT a.salesman_id FROM customer a,customer b
WHERE a.salesman_id=b.salesman_id
AND a.name<>b.name);

#10. Display all the orders that had amounts that were greater than at least one of the orders from September 10th 2012.
SELECT *
FROM ord_detail
WHERE purch_amt> ANY(
SELECT purch_amt 
FROM ord_detail WHERE ord_date='2021-09-10');

#11.Display only those customers whose grade are, in fact, higher than every customer in New York.
SELECT * FROM customer
WHERE grade>ALL (
SELECT grade FROM customer
WHERE city='New York' )