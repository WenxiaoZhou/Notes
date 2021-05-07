/* Read the sashelp.stocks table and create a new table  */
/* named stocks_total. Include only rows where the Date is  */
/* in 2005. Create an accumulating column for Volume named  */
/* YTDVolume that is a running total of Volume for each stock. */

*Sort the data first or may lead to errors when accumulation;
proc sort data=sashelp.stocks out=stocks_sort;
  by Stock Date;
  where year(Date)=2005;
run;
data stocks_total;
  set stocks_sort;
  by Stock;
  if first.stock=1 then YTDVolume=0;
  YTDVolume+Volume;
  format YTDVolume comma15.;
run;

proc print data=stocks;
  where Stock="Intel" and Date="01AUG2005"d;
run;



