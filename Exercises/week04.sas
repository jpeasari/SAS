/* Question1 */
/* 1 Reading the data */
data glucose;
	infile "/folders/myfolders/Date for Classes 1 to 6/glucose.dat";
	input ID $ 1-2 Timepoint1 3-6 Timepoint2 7-10;
run;
proc print data=glucose;
run;

/* 2. Means of Timepoint1 and Timepoint2*/
proc means data=glucose;
run;

/* 3. Univariate*/
proc univariate data=glucose;
run;

/* 4. TTEST*/
proc ttest data=glucose;
	paired Timepoint1 * Timepoint2;
run;

/* Question2 */

data MI;
	infile "/folders/myfolders/Date for Classes 1 to 6/MI.dat";
	input ID $ 1-3
		  GENDER $ 4
		  BMI 5-8
		  AGE 9-10
		  DM $ 11
		  HIN $ 12
		  MI $ 13
		  PACKYR 14-15;
run;

proc print data=MI;
run;

data MI1;
	set MI;
	proc format;
	value $codefmt "M"="Male" "F"="Female" "0"="No" "1"="Yes";
run;

proc print data=MI;
	format Gender DM HIN MI $codefmt.;
run;

data MI2;
	set MI1;
	if 18.5 < BMI < 25.0 then BMI_GROUP = "Normal";
	else if 25.1 < BMI < 30.0 then BMI_GROUP = "Overweight";
	else if BMI > 30.0 then BMI_GROUP = "Obese";
	if PACKYR = 0 then SMOKED=0;
	else SMOKED = 1;
run;

proc print data=mi2;
run;

proc freq data=mi2;
	table BMI_GROUP * SMOKED * MI;
run;

proc freq data=mi2;
	table DM * MI / chisq;
run;

/* Question 3 */

data sanfran;
	infile "/folders/myfolders/Date for Classes 1 to 6/sfosch.dat";
	input FlightID $ 1-7 RouteID $ 8-14 Destination $ 18-20  Model $ 21-40 raw_date $ 41-49  TotPassCap 64-67 CargoRev 75-79;
	Date = input(raw_date,date9.);
	format Date mmddyy10.;
run;

data sanfran1;
	set sanfran;
	proc print data=sanfran split='';
	label Date="Departure Date" TotPassCap = "Total Passenger Capacity" Model = "Aircraft Model";
 	var FlightID RouteID Destination Model Date TotPassCap;
run;

proc contents data=sanfran1;
run;

/* Question 4*/

proc freq data=sanfran1;
	title "Flights from San Francisco";
	table Destination;
run;

proc freq data=sanfran1;
	title "Flights from San Francisco";
	table Destination / NOCUM;
run;

proc freq data=sanfran1;
	title "Flights from San Francisco";
	table Destination * Date;
run;

proc print data="/folders/myfolders/Date for Classes 1 to 6/mechanics.sas7bdat";
run;

proc freq data="/folders/myfolders/Date for Classes 1 to 6/mechanics.sas7bdat" order=freq;
	by Gender JobCode;
run;

proc sort data = "/folders/myfolders/Date for Classes 1 to 6/mechanics.sas7bdat" out = college1;
 by Gender;
run;

proc freq data = college1;
	by Gender;
	tables JobCode;
run; 

data sanfran2;
	infile "/folders/myfolders/Date for Classes 1 to 6/sfosch.dat";
	input FlightID $ 1-7 RouteID $ 8-14 Destination $ 18-20  Model $ 21-40 Date $ 41-49  TotPassCap 64-67 CargoRev 75-79;
run;

proc means data=sanfran2 maxdec=2;
	class Destination;
	variable CargoRev TotPassCap;
run;


