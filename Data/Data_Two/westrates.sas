data westrates;
  infile '/folders/myfolders/Data for Classes 3 to 6/westernrates.dat';
  input  city $ 		1-30 
	state $ 		31-33 
	HealthCareEnvironment 	45-49 
	Crime 			50-54;
 run;
