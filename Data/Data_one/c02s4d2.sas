data work.staff;
   infile '/folders/myfolders/Data for Classes 1 and 2/emplist.dat';
   input LastName $ 1-20 FirstName $ 21-30
         JobTitle $ 36-43 Salary 54-59;
run;

proc print data=work.staff;
run;

proc means data=work.staff mean max;
   class JobTitle;
   var Salary;
run;
