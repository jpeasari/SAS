LIBNAME BST5030 "/folders/myfolders/Data for classes 8 to 11";

/* 1. Calculating Statistics and Rounding */

DATA SALE_STATS;
	SET BST5030.orders_midyear;
	MonthAvg = ROUND(MEAN(Month1,Month2,Month3,Month4,Month5,Month6));
	MonthMax = MAX(Month1,Month2,Month3,Month4,Month5,Month6);
	MonthSum = SUM(Month1,Month2,Month3,Month4,Month5,Month6);
RUN;

PROC PRINT DATA = sale_stats;
	VAR CUSTOMER_ID MonthAvg MonthMax MonthSum;
RUN;

/* 2. Extracting Characters Based on Position */


DATA CODES;
	SET bst5030.au_salesforce;
	FCode1 = Lowcase(substr(First_Name,1,1));
	FCode2 = substr(First_Name,LENGTH(First_Name)-0,1);
	LCode = substr(Last_Name,1,4);
RUN;

PROC PRINT DATA = CODES;
	VAR FIRST_NAME FCode1 FCode2 Last_Name LCode;
RUN;

/* 3.   Extracting Characters Based on Position */

DATA SMALLSTORE;
	SET bst5030.newcompetitors;
	Country = substr(ID,1,2);
	Store_Code = substr(ID,3,LENGTH(ID));
RUN;

PROC PRINT DATA = SMALLSTORE;
	VAR STORE_CODE COUNTRY CITY POSTAL_CODE;
RUN;

/* 4. Cleaning Text Data */

PROC PRINT DATA = bst5030.customers_ex5;
RUN;

DATA NAMES;
	SET bst5030.customers_ex5;
	I = FIND(Name,",");
	new_name1 = Propcase(substr(Name,1,I-1));
	new_name2 = substr(Name,I+1,LENGTH(Name));
	IF GENDER = "M" THEN NEW_NAME1 = cats("Mr.",new_name2,'-',new_name1);
	ELSE NEW_NAME1 = cats("Ms.",new_name2, "-",new_name1);
	New_Name = tranwrd(NEW_NAME1, "-", " ");                                                                                                    
RUN;

PROC PRINT DATA = NAMES;
	VAR New_Name NAME GENDER;
RUN;
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
