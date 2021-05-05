/* m104e01 */
title; 
footnote; 

%macro emporders(idnum=121044);
   proc print data=bst5030.orders noobs;
      var Order_ID Order_Type Order_Date Delivery_Date;
      where Employee_ID=&idnum;
      title "Orders Taken by Employee &idnum";
   run;
%mend emporders;
%emporders()
