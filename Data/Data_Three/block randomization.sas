
%macro _blckrandom;
 *** for 200 in each group, blocksizes of 2-10 ***;
 *** I solved 200 = 10x + 8x + 6x + 4x, rounded up, then divided ***;
 *** the remainder by 2 to get the number of 2-sized blocks ***;
 proc datasets;  delete randomized;  run;
 data blocksizedat;
   retain n 0;
   do blocksize=2 to 10 by 2;
     if blocksize=2 then do i = 1 to 2;
	   n = n + 1;
	   output;
	 end;
	 else do i= 1 to 7;
	   n = n + 1;
	   output;
	 end;
   end;
   drop i;
 run;
 proc print data=blocksizedat;
 run;
 proc means data=blocksizedat sum;
   var blocksize;
 run;
 proc plan;
   factors n=30;
   output data=blocksizedat out=randomblock;
 run;
 proc sort data=randomblock;  by n; run;
 proc print data=randomblock;
 run;
 ** iteration for each block **;
 %do _block = 1 %to 30;
  ** grab the block size from the row corresponding with the iteration **;
  data randomblock;
    set randomblock;
	if n = &_block then call symput('_blocksize', blocksize);
  run;
  %put blocksize = &_blocksize;
  ** assign treatment to half of the subjects in each block **;
  data Unrandomized; 
    half = &_blocksize / 2;
	block = &_block;
    do unit = 1 to &_blocksize;
      if (unit <= half ) then Treatment=0;
        else                  Treatment=1;
        output;
      end;
  run;
  ** Randomly permute the blocks **;
  proc plan;
     factors unit=&_blocksize;
     output data=Unrandomized out=Randomized&_block;
  run;
  proc sort data=Randomized&_block;
     by unit;
  run;
  ** append all the block datasets into one **;
  Proc append base=randomized data=randomized&_block; 
  run;
 %end;
 ** assign subject order **;
 data randomized;
   set randomized;
   retain subject 0;
   subject = subject + 1;
   drop half unit;
 run;
%mend _blckrandom;