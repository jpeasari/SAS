libname bst5030 '/folders/myfolders';

data work.mid_q4;
  set bst5030.order_fact;
  where '01nov2004'd <= Order_Date <= '14dec2004'd;
run;


title 'Orders from 01Nov2004 through 14Dec2004';
proc print data=work.mid_q4;
  var Order_ID Order_Date Total_Retail_Price;
run;
title;
