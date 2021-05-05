data contacts;
   length Name $ 20 Phone Mobile $ 14;
   infile '/folders/myfolders/Data for Classes 3 to 6/phone.csv' dsd;
   input Name $ Phone $ Mobile $;
run;

proc print data=contacts noobs;
run;
