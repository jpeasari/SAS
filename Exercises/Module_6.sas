/* Question1 */
/* 1.   Subsetting Observations Based on Three Conditions */


DATA ORDERS; 
  set '/folders/myfolders/Data for Classes 3 to 6/orders.sas7bdat'; 
  raw_date = Order_Date;
  format raw_date mmddyy10.;
RUN; 



PROC PRINT DATA=ORDERS;
RUN;

DATA DELAYS;
	set ORDERS;
	Order_Month = month(raw_date);
	DROP raw_date;
run;

PROC PRINT DATA=DELAYS;
RUN;	

DATA DELAYS01;
	SET DELAYS;	
	format Delivery_Date  Order_Date date9.;
	days=intck('day',Order_Date,Delivery_Date);
RUN;

DATA DELAYS02;
	SET DELAYS01;
	IF Employee_ID = "99999999" and Order_Month = "8" and days > 4;
	DROP days;
RUN;

PROC PRINT DATA=DELAYS02;
RUN;

/* 2.a and 2.b   Interleaving Data  */

LIBNAME BST5030 “PATH_TO_DATASETS”;
PROC SORT DATA = CENTER1 OUT = CETER1_SORT;
	BY ID;
RUN;
PROC SORT DATA = CENTER3 OUT = CETER2_SORT;
	BY ID;
RUN;
PROC SORT DATA = CENTER3 OUT = CETER3_SORT;
	BY ID;
RUN;
DATA MERGE;
	MERGE CENTER1_SORT, CENTER2_SORT, CENTER3_SORT;
	BY ID;
RUN;

DATA CONCAT; 
	SET CETER1_SORT CETER2_SORT CETER2_SORT;
RUN;

PROC PRINT DATA=CONCAT;
RUN;

/* 3.   Merging Data  */

DATA SORTSB; 
  set '/folders/myfolders/Data for Classes 3 to 6/target121999.sas7bdat'; 
  where Date='15dec1999'd and Origin='BHM';
RUN; 

DATA SORTS; 
  set '/folders/myfolders/Data for Classes 3 to 6/sales121999.sas7bdat'; 
  where Date='15dec1999'd and Origin='BHM';
RUN; 

PROC PRINT DATA=SORTSB;
RUN;

PROC PRINT DATA=SORTS;
RUN;


DATA COMPARE;
	MERGE SORTSB SORTS;
   	BY FlightID;
   	LostCargoRev  = CargoTarRev - CargoRev;
RUN;

PROC PRINT DATA=compare split=" ";
	LABEL CargoTarRev = "Total Revenue from Cargo"
			CargoRev  = "Revenue from Cargo"
			LostCargoRev = "Lost Cargo Revenue";
	VAR CargoTarRev CargoRev LostCargoRev;
RUN;

/* 4.   Identifying Data Set Contributors   */

DATA frakfrt; 
  set '/folders/myfolders/Data for Classes 3 to 6/frankfrt.sas7bdat';
  rename IDNo=IDNum;
RUN; 

DATA pilots; 
  set "/folders/myfolders/Data for Classes 3 to 6/pilots.sas7bdat"; 
  KEEP IDNum Fname Lname;
RUN; 

PROC sort DATA=frakfrt;
   	BY IDNum;
RUN;

PROC sort DATA=pilots;
   	BY IDNum;
RUN;

PROC print DATA=frakfrt;
RUN;

PROC print DATA=pilots;
RUN;

DATA SCHEDULE;
	MERGE frakfrt pilots;
   	BY IDNum;
RUN;

PROC PRINT DATA=SCHEDULE;
	VAR IDNum LName Fname Date Flight;
RUN;

/* 4. b  */
data SCHEDULE01;
  set SCHEDULE;
  if missing(Date) then delete;
  if missing(Flight) then delete;
run;

PROC PRINT DATA=SCHEDULE01;
	VAR IDNum LName Fname Date Flight;
RUN;

/* 4. c  */

data NOFRANK;
	SET SCHEDULE;
	if not missing(Date) then delete;
  	if not missing(Flight) then delete;
  	KEEP IDNum LName Fname;
run;

PROC PRINT DATA=NOFRANK;
RUN;






