data work.staff;
   infile '/folders/myfolders/Data for Classes 1 and 2/survey.dat';
   input ID $ 1-3 Gender $ 4-5 State $ 6-8
         Item_1  9-11 Item_2 $ 12;
run;

proc print data=work.staff;
run;

Proc contents data=work.survey;
Run;


