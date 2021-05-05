data pilotdata;
     infile '/folders/myfolders/Data for Classes 1 and 2/pilot.dat';
     input EmployeeID  $  1 - 6 FirstName   $  7 - 19
           LastName    $ 20 - 34 JobCode     $ 35 - 41
           Salary        42 - 47 Category    $ 48 - 50;
run;

proc print data=pilotdata;
   var FirstName LastName JobCode Salary;
   where Salary lt 70000;
run;

proc print data=pilotdata;
   var FirstName LastName JobCode Salary;
   where JobCode='PILOT2';
run;

proc print data=pilotdata;
   var FirstName LastName JobCode Salary;
   where JobCode='PILOT2' and Salary lt 70000;
run;


