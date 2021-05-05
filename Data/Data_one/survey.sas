data survey;
     infile '/folders/myfolders/survey.sas';
     input Initials   $
           Gender     $
           State      $
           Years
           Profession $;

run;

proc print data=survey;
run;

proc freq data=survey;
     tables Gender State Profession;
run;

proc means data=survey;
run;

