data shoes_profit;
   set sashelp.shoes;
   Profit=Sales-Returns;
   format Profit dollar12.;
   label Profit="Profit (USD)";
run;

proc means data=shoes_profit noprint;
   var Profit;
   class Region Subsidiary;
   output out=shoes_summary sum=Profit;
   ways 2;
run;

title "Shoes Profit by Region, Subsidiary";
proc print data=shoes_summary noobs;
   by Region;
   var Subsidiary Profit;
run;
title;