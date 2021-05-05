ods listing close;
ods csvall file='/folders/myfolders/myexcel.csv';
ods msoffice2k file='/folders/myfolders/myexcel.html';
ods tagsets.excelxp file='/folders/myfolders/myexcel.xml';

proc freq data=bst5030.sales;
   tables Country;
   title 'Report 1';
run;

proc means data=bst5030.sales;
   var Salary;
   title 'Report 2';
run;

proc print data=bst5030.sales;
   var First_Name Last_Name 
       Job_Title Country Salary;
   where Salary > 75000;
   title 'Report 3';
run;

ods _all_ close;
ods listing;

title;

