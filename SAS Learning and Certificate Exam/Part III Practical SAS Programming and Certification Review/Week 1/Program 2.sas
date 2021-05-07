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