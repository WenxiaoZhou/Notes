*wide table to narrow table;
data sales_n;
  set cr.qtr_sales;
  Qtr="Qtr1";
  Sales=Qtr1;
  output;
  Qtr="Qtr2";
  Sales=Qtr2;
  output;
  Qtr="Qtr3";
  Sales=Qtr3;
  output;
  Qtr="Qtr4";
  Sales=Qtr4;
  output;
  keep Customer_ID Name Qtr Sales; 
run;

proc means data=sales_n sum mean maxdec=0;
  var Sales;
  class Qtr;
  ways 0 1;
run;

*narrow table to wide table;
/* Also we only want each row for each obeservation, we need */
/* to retaint the values assigned to Qtr1-3 through the PDV */
/* so that by the time we reach the Qtr4, all the Qtr columns */
/* are populated */
data sales_w;
  set cr.sales;
  by Customer_ID;
  retain Qtr1-Qtr4;
  if Qtr="Qtr1" then Qtr1=Sales;
  else if Qtr="Qtr2" then Qtr2=Sales;
  else if Qtr="Qtr3" then Qtr3=Sales;
  else if Qtr="Qtr4" then Qtr4=Sales;
  if last.Customer_ID=1;
  drop Qtr Sales;
run;








