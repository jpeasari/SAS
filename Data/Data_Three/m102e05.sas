/* m102e05 */
title; 
footnote; 

proc print data=bst5030.customer_dim;
   var Customer_Name Customer_Gender Customer_Age;
   where Customer_Group contains 'Gold';
   title 'Gold Customers';
run; 
