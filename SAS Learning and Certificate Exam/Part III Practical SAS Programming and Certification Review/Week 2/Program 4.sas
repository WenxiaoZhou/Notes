proc sql;
   create table profit_country as 
      select profit.*,Country_Name
      from cr.profit inner join cr.country_clean
      on profit.Customer_Country=country_clean.Country_key
      order by Order_Date desc;
quit;
/* Orders Frequency Analysis */
ods noproctitle;
title "Number of Orders by Month";
title2 "and Customer Continent/Order Source";
proc freq data=profit_country order=freq;
  tables Order_Date /nocum;
  format Order_Date monname.;
  tables Customer_Continent*Order_Source /norow nocol;
run;

/* Ship Days Summary */
%let os=Retail;
title "Days to Ship By Country";
title2 "&os Orders";
proc means data=profit_country min max mean maxdec=0;
   var ShipDays;
   class Country_Name;
   where ShipDays>0 and Order_Source="&os";
run;
*create a summary for different order_source in countries;  
title "Days to Ship by Country";
proc means data=profit_country min max mean maxdec=0;
   var ShipDays;
   class Order_Source Country_Name;
   where ShipDays>0;
run;
*another way to create;
proc sort data=profit_Country out=profit_sort;
   by Order_Source;
run;

title "Days to Ship by Country";
proc means data=profit_sort min max mean maxdec=0;
   var ShipDays;
   class Country_Name;
   where ShipDays>0;
   by Order_Source;
run;

/* Profit Analysis by Customer Age */
proc means data=profit_country noprint;
   var Profit;
   class Age_Range;
   output out=profit_summary median=MedProfit sum=TotalProfit;
   ways 1;
run;

proc print data=profit_summary noobs label;
  var Age_Range TotalProfit MedProfit;
  label Age_Range="Age Range"
        TotalProfit="Total Profit"
        MedProfit="Median Profit per order";
   format TotalProfit MedProfit dollar10.;
run;
