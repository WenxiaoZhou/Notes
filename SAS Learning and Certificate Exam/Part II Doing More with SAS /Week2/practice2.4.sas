/* Write a program to create a sorted copy of  */
/* sashelp.shoes that is ordered by Region and Product. */
/* Write a DATA step to read the sorted table and  */
/* create a new table named profitsummary. */
/* Create a column named Profit that is the difference  */
/* between Sales and Returns. */
/* Create an accumulating column named TotalProfit that  */
/* is a running total of Profit within each value of  */
/* Region and Product. */
/* Reset TotalProfit for each new combination of Region  */
/* and Product. */
/* Submit program and verify that TotalProfit is accurate. */

proc sort data=sashelp.shoes out=sort_shoes;
    by Region Product;
run;

data profitsummary;
   set sort_shoes;
   by Region Product;
   Profit=Sales-Returns;
   if first.Product=1 then TotalProfit=0;
   TotalProfit+Profit;
   format TotalProfit dollar12.;
   if last.Product=1;
   keep Region Product TotalProfit;
run;