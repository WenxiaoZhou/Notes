/*Accessing Data*/
%let path=/folders/myfolders/ECRB94;

options validvarname=v7;
libname ctryxl xlsx "&path/data/country_lookup.xlsx";

%let path=/folders/myfolders/ECRB94;
libname cr "&path/output";
proc import datafile="&path/data/orders.csv"
              out=cr.orders dbms=csv replace;
run;

/* lists the descriptor portion of the data. */
proc contents data=cr.orders;
run;
/* listing two tables in ctryxl library: countries,population */
proc contents data=ctryxl._all_;
run;

proc contents data=cr._all_ nods;
run;

/* Exploring Data */
/* Validate Country Lookup Excel Table */
proc print data=ctryxl.countries(obs=30);
run;
/* use proc freq to easy detect the duplicates */
proc freq data=ctryxl.countries order=freq;
 tables Country_Key Country_Name;
run;
/* find the duplicates in countries table; */
proc print data=ctryxl.countries;
   where Country_Key in ('AG','CF','GB','US');
run;
/* nodupkey option for printing table without duplicates */
/* dupout option with a new table named dups for  */
/* duplicates variables */
proc sort data=ctryxl.countries out=country_clean
           nodupkey dupout=dups;
     by country_key;
run;

/* Validate Imported Orders Table */
/* Since the delivery_date is after order_date; */
/* order_type should be 1,2 or 3; Customer_country should */
/* be 2 uppercase letters; customer_continent should be */
/* one of 5 continents */
/* The following steps detect if there exists mistake */
proc print data=cr.orders;
  where Order_date>Delivery_date;
  var Order_ID Order_Date Delivery_Date;
run;

proc means data=cr.orders maxdec=0 ;
   var Quantity Retail_Price Cost_Price;
run;
/* there is a table for extreme observation in this proc */
proc univariate data=cr.orders;
       var Quantity Retail_Price Cost_Price;
run;



