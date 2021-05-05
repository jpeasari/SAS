data westernrates;
  infile '/folders/myfolders/Data for Classes 1 and 2/westernrates.dat';
  input city $ 			1-30 
	    state $ 	    31-33 
	    climateTerrain 	34-38 
	    Housing 		39-44 
	    HealthCareEnvironment 45-49 
	    Crime 			50-54
	    Transportation  55-59
	    Education 		60-64 
	    Arts 			65-70 
	    Recreation 		71-75
	    Economics 		76-79;
run;
proc print data=westernrates split=' ';
	label city='City'
		  state='State'
		  Housing='Housing Score' 
		  Crime='Crime Score';
	var city state Housing Crime;
	TITLE "Western Cities and Their Scores";
	TITLE2 "Housing and Crime";
	FOOTNOTE "Lower Scores are Better";
run;