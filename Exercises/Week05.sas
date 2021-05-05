LIBNAME BST5030 '/folders/myfolders/Data for Classes 3 to 6';
 /*Assigning variable attributes */
data work.passngrs2;
	set bst5030.passngrs;
run;

proc datasets lib=work;
	modify passngrs2;
	rename FClass = FirstClass;
	label FirstClass = First Class Passengers;
	format Depart Date9.;
	label Depart = Departure Date;
run;
quit;

proc contents data=work.passngrs2;
run;

/* Creating accumulating totals*/
data work.order_fact1;
	set bst5030.order_fact;
	where '01nov2004'd <= Order_Date <= '14dec2004'd;
	retain SalesToDte Num_Orders;
	if _n_ = 1 then SalesToDte = Total_Retail_Price;
	else SalesToDte = SalesToDte + Total_Retail_Price;
	if _n_ = 1 then Num_Orders = 1;
	else Num_Orders = Num_Orders + 1;
run;

proc print data=work.order_fact1;
	var Order_id Order_Date Total_Retail_Price SalesToDte Num_Orders;
run;

/*Creating accumulating totals with conditional logic */

data work.typetotals;
	set bst5030.order_fact;
	retain TotalRetail 0 TotalCatalog 0 TotalInternet 0;
	where '01jan2005'd <= Order_Date <= '31dec2005'd;
	if Order_type = 1 then TotalRetail = TotalRetail + Quantity;
	else if Order_type = 2 then TotalCatalog = TotalCatalog + Quantity;
	else if Order_type = 3 then TotalInternet = TotalInternet + Quantity;
run;

proc print data=work.typetotals;
run;



