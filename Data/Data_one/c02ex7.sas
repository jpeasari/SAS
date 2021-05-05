data work.airports;
   infile '/folders/myfolders/Data for Classes 1 and 2/c02ex7.sas';
   input @ 1 Code $3.
         @ 4 City $50.
         @ 54 Country $15.;
run;

proc print data=work.airports;
run;
