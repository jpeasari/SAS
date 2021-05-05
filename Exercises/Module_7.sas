 /* B . Performing computations with DO loop */

data future_expenses;
   Wages=12874000;
   Retire=1765000;
   Medical=649000;
   Income = 50000000;
   Year=year(today())+1;
   DO i=1 TO 10;
   Wages = Wages + (Wages * 0.06);
   Retire = Retire + (Retire * 0.014);
   Medical = Medical + (Medical * 0.095);
   Year = Year + 1;
   Total_Cost = Wages + Retire + Medical;
   Income = Income  + Income * 0.01;
   OUTPUT;
   END;
run;

PROC PRINT DATA=future_expenses;
	format Wages Retire Medical Income Total_Cost comma14.2;
	var Year Wages Retire Medical Income Total_Cost;
RUN;

 /* c . Performing computations with DO loop */


data future_expenses;
   Wages=12874000;
   Retire=1765000;
   Medical=649000;
   Income = 50000000;
   Year=year(today())+1;
   FLAG=0;
   DO WHILE (FLAG=0);
	   Wages = Wages + (Wages * 0.06);
	   Retire = Retire + (Retire * 0.014);
	   Medical = Medical + (Medical * 0.095);
	   Year = Year + 1;
	   Total_Cost = Wages + Retire + Medical;
	   Income = Income  + Income * 0.01;
	   IF Income < Total_Cost THEN FLAG=1;
	   OUTPUT;
   END;
run;

PROC PRINT DATA=future_expenses;
	format Income Total_Cost comma14.2;
	var Year Income Total_Cost;
RUN;


/* Creating Bar and Pie charts*/

/* 1 */
LIBNAME BST5030 "/folders/myfolders/Data for Classes 3 to 6";

proc sgplot data=BST5030.staff;
   vbar Job_Title;
   where Job_Title =:'Sales Rep';
   title 'Number of Employees by Job Title';
run;
quit;

/* 2 */

proc sgplot data=BST5030.staff;
   hbar Job_Title;
   title 'Number of Employees by Job Title';
   where Job_Title =:'Sales Rep';
run;
quit;

/* 3 */
 
proc sgplot data=BST5030.staff;
   histogram salary;
   where Job_Title =:'Sales Rep';
   format salary dollar9.;
   title 'Salary Distribution Midpoints for Sales Reps';
run;
quit;

/* 4 */

proc sgplot data=BST5030.staff;
   histogram salary/ nbins = 5 showbins;
   where Job_Title =:'Sales Rep';
   format salary dollar9.;
   title 'Salary Distribution Ranges for Sales Reps';
run;
quit;

/* 5 */

proc sgplot data=bst5030.staff;
   vbar Job_Title / response=salary stat=mean;
   where Job_Title =:'Sales Rep';
   format salary dollar9.;
   label Job_Title='Job Title'
         Salary='Salary';
   title 'Average Salary by Job Title';
run;
quit;

/* 6 */

proc sgplot data=bst5030.staff;
   vbar Job_Title/group=Gender;
   where Job_Title =:'Sales Rep';
   title 'Frequency of Job Title, Broken Down by Gender';
run;
quit;

/* Creating plots*/

/* 1.*/

proc sgplot data=bst5030.budget;
   scatter X = Month Y = Yr2007;
   format Yr2007 dollar12.;
   title 'Plot of Budget by Month';
run;
quit;

/*2 */

proc sgplot data=bst5030.budget;
   series X = Month Y = Yr2007 / markers;
   label Yr2007='Budget';
   format Yr2007 dollar12.;
   title 'Plot of Budget by Month';
run;
quit;

/* 3*/

proc sgplot data=bst5030.budget;
   series X = Month Y = Yr2007 / markers;
series X = Month Y = Yr2006 / markers;
   label Yr2007='2007 Budget';
label Yr2006='2006 Budget';
   format Yr2007 dollar12.;
format Yr2006 dollar12.;
   title 'Plot of Budget by Month for 2006 and 2007';
run;
quit;








