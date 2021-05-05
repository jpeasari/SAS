libname bst5030 '/folders/myfolders;
data preferred_cust;
   set bst5030.orders_midyear;
   array Mon{6} Month1-Month6;
   keep Customer_ID Over1-Over6 Total_Over;
   array Target               ;
   array Over                 ;


run;
proc print data=preferred_cust noobs;
run;
