LIBNAME BST5030 "/folders/myfolders/Data for classes 8 to 11";

/* 1. Using Arrays for Repetitive Computations */
data ORDERS; 
   set BST5030.orders_midyear;
   array NumVar _numeric_;
   do over NumVar;
      if NumVar=. then NumVar=0;
   end;
run;

DATA ORDER;
	SET BST5030.orders_midyear;
	ARRAY MON (3) Total_Sales Projected_Sales Difference;
		DO i = 1 TO 3;
		MON(1) = SUM(Month1, Month2, Month3, Month4, Month5, Month6);
		MON(2) = SUM(Month1 * (1-0.10), Month2 * (1-0.10), Month3 * (1-0.10), Month4, Month5, Month6);
		MON(3) = MON(1) - MON(2);
		END;
		KEEP Total_Sales Projected_Sales Difference;
RUN;


PROC PRINT DATA=order;
   format  Total_Sales Projected_Sales Difference dollar9.2;
   sum Difference;
RUN;


/* 2. Using an Array for Table Lookup */

DATA WORK.PREFERRED_CUST;
	SET BST5030.orders_midyear;
	TAR1 = 200;
	TAR2 = 400;
	TAR3 = 300;
	TAR4 = 100;
	TAR5 = 100;
	TAR6 = 200;
	ARRAY ALL (7) OVER1 OVER2 OVER3 OVER4 OVER5 OVER6 Total_Over;
	DO i = 1 TO 7;
		IF TAR1 < Month1 then ALL(1) = Month1 - TAR1;
		ELSE ALL(1) = ".";
		IF TAR2 < Month2 then ALL(2) = Month2 - TAR2;
		ELSE ALL(2) = ".";
		IF TAR3 < Month3 then ALL(3) = Month3 - TAR3;
		ELSE ALL(3) = ".";
		IF TAR4 < Month4 then ALL(4) = Month4 - TAR4;
		ELSE ALL(4) = ".";
		IF TAR5 < Month5 then ALL(5) = Month5 - TAR5;
		ELSE ALL(5) = ".";
		IF TAR6 < Month6 then ALL(6) = Month6 - TAR6;
		ELSE ALL(6) = ".";
		ALL(7) = SUM(OVER1,OVER2,OVER3,OVER4,OVER5,OVER6);
	END;
RUN;

DATA preferred_cust1;
	SET preferred_cust;
	IF Total_Over > 500 ;
RUN;

PROC PRINT DATA=work.preferred_cust1;
	VAR CUstomer_ID OVER1 OVER2 OVER3 OVER4 OVER5 OVER6 Total_Over;
RUN;
	
/* 3.	Rotating a Data Set */


DATA ROTATE;
	SET BST5030.orders_midyear;
	ARRAY MONTHS {6} (1 2 3 4 5 6);
	ARRAY SALE {6} Month1 Month2 Month3 Month4 Month5 Month6;
		DO i = 1 TO 6;
		Month = MONTHS {i};
		Sales = SALE {i};
		OUTPUT;
		END;
RUN;

OPTIONS missing = ' ';	
DATA ROTATE1;
	SET ROTATE;
	  if missing(Sales) then delete;
RUN;
	
PROC PRINT DATA=rotate1;
	VAR Customer_ID Month Sales;
RUN;

/* 4.	Rotating a Data Set */
	
PROC SORT DATA = BST5030.order_summary;
	BY CUSTOMER_ID ORDER_MONTH;
RUN;

PROC TRANSPOSE DATA = BST5030.order_summary OUT = WORK.OUTDATA;
	BY Customer_ID;
	ID ORDER_MONTH;
RUN;

PROC PRINT DATA = OUTDATA SPLIT = "";
	LABEL _1 = "Month1" _2 = "Month2" _3 = "Month3" _4 = "Month4" _5 = "Month5" _6 = "Month6"
		  _7 = "Month7" _8 = "Month8" _9 = "Month9" _10 = "Month10" _11 = "Month11" _12 = "Month12" ;
	VAR CUSTOMER_ID _1 _2 _3 _4 _5 _6 _7 _8 _9 _10 _11 _12;
RUN;


