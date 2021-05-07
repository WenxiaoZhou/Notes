proc print data=profit_summary label noobs;
   var Age_Range TotalProfit MedProfit;
   label Age_Range="Age Range"
         TotalProfit="Total Profit"
         MedProfit="Median Profit per Order";
   format totalProfit MedProfit dollar10.;
run;

/* Exporting Data */
proc export data=profit_Country 
      outfile="/folders/myfolders/ECRB94/output/orders_update.csv" 
      dbms=csv replace;
run;

libname outxl xlsx "/folders/myfolders/ECRB94/output/orders_update.xlsx";
data Order_Update;
   set profit_country;
run;
data outxl.Country_Lookup;
   set country_clean;
run;
proc means data=profit noprint;
   var profit;
   class Age_Range;
   ways 1;
   output out=outxl.profit_summary;
run;
libname outxl clear;
*The CLEAR option will disassociate a libref from an 
*external file, folder or other data source;