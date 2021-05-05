data pilotdata;
   infile '/folders/myfolders/pilot.dat';
   input EmployeeID $ 1 - 6
         FirstName  $ 7 - 19
         LastName   $ 20 - 34
         JobCode    $ 35 - 41
         Salary       42 - 47
         Category   $ 48 - 50;
run;
