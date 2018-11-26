
-- 1 Retrieve Internet Sales Amount As Per Customer. In other words, we can say show the 
-- Detail of amount spent by customers during purchase from Internet.


SELECT lastname, sum(salesamount) 
FROM factinternetsales 
INNER JOIN dimcustomer USING (customerkey)
WHERE dimcustomer.customerkey = factinternetsales.customerkey
GROUP BY lastname
ORDER BY lastname;



-- 2 View Internet Sales amount detail between year 2005 to 2008


SELECT sum(salesamount) 
FROM factinternetsales
INNER JOIN dimdate ON factinternetsales.duedatekey=dimdate.datekey
WHERE calendaryear BETWEEN '2005' and '2008';



-- 3 View Internet Sales by product category and sub-category.


SELECT sum(salesamount) , spanishproductcategoryname , spanishproductsubcategoryname
FROM factinternetsales
INNER JOIN dimproduct USING (productkey)
INNER JOIN dimproductsubcategory USING (productsubcategorykey)
INNER JOIN dimproductcategory USING (productcategorykey)
GROUP BY spanishproductcategoryname , spanishproductsubcategoryname;



-- 4 View Internet Sales and Freight Cost by product category, sub-category and product.


SELECT sum(salesamount) AS "Total de ventas"  ,sum(freight) AS "Cargo de envio", 
spanishproductcategoryname , spanishproductsubcategoryname, spanishproductname
from factinternetsales
inner join dimproduct using (productkey)
inner join dimproductsubcategory using (productsubcategorykey)
inner join dimproductcategory using (productcategorykey)
group by spanishproductcategoryname , spanishproductsubcategoryname,spanishproductname;



-- 5 Retrieve only those products whose names begin with “A” and Internet sales amount <5000.


SELECT spanishproductname ,salesamount 
FROM factinternetsales
INNER JOIN dimproduct USING (productkey)
WHERE spanishproductname LIKE 'a%'
AND salesamount::numeric < 5000
GROUP BY spanishproductname , salesamount;



-- 6 What is sales amount in all the countries?? 


SELECT sum(salesamount), dimsalesterritory.salesterritorycountry AS "PAIS"
FROM factinternetsales
INNER JOIN dimsalesterritory USING(salesterritorykey)
GROUP BY dimsalesterritory.salesterritorycountry
ORDER BY dimsalesterritory.salesterritorycountry;



-- 7 Retrieve all the products in descending order of their Internet sales amount of year 2007 


SELECT dimproduct.englishproductname AS "PRODUCTO", sum(salesamount) AS "TOTAL", dimdate.calendaryear AS "AÑO"
FROM factinternetsales
INNER JOIN dimproduct USING (productkey)
INNER JOIN dimdate ON factinternetsales.duedatekey=dimdate.datekey
WHERE calendaryear = 2007
GROUP BY dimproduct.englishproductname, dimdate.calendaryear;



-- 8 Generate a report with Internet Sales sub total, grand total per year and month.


SELECT calendaryear, monthnumberofyear, sum(salesamount::numeric) AS monto
FROM factinternetsales
INNER JOIN dimdate ON factinternetsales.duedatekey=dimdate.datekey
GROUP BY ROLLUP (calendaryear, monthnumberofyear);




-- 9 Generate a report with the amount of "Pedals" and "Tires and Tubes" category of products.
-- in the inventory. Also with the amount of in and outs of each of them on the second half of the year 2006.


SELECT englishproductname, count(productkey), sum(unitsin), sum(unitsout) 
FROM factproductinventory
INNER JOIN dimproduct dp USING (productkey)
INNER JOIN dimdate USING(datekey)
INNER JOIN dimproductsubcategory USING(productsubcategorykey)
INNER JOIN dimproductcategory USING (productcategorykey)
WHERE englishproductname LIKE '%Pedal%' OR englishproductname LIKE '%Tire%' 
AND fiscalyear = 2006 AND fiscalsemester =2
GROUP BY englishproductname;
