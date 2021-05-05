*m103e05;

options nolabel;
title 'Order Stats';
proc means data=bst5030.order_fact maxdec=2 mean;
   var total_retail_price;
   class order_type;
run;
title;
