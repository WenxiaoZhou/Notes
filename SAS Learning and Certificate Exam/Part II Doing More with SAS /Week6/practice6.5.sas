**************************************************;
*  LESSON 6, PRACTICE 5                          *;
**************************************************;
/* Open p206p05.sas from the practices folder. */
/* Submit the program and examine the results. Notice that the  */
/* golf export number is farther from the golf import number as  */
/* compared to the racket export and import numbers. */
/* Add a conditional DO loop around the assignment statement  */
/* for Amt_Export. Use a DO WHILE statement that executes while  */
/* the export value is less than or equal to the import value. */
/* Create a Year column that increments by a value of 1. */
/* Create a row of output for each year. */
/* Submit the program and examine the results. */

data IncrExports;
    set pg2.eu_sports;
    where Year=2015 and Country='Belgium' 
          and Sport_Product in ('GOLF','RACKET');
    *Year=0;
    do Year=2016 to 2025 while (Amt_Export<=Amt_Import);
       Amt_Export=Amt_Export*1.07;
       *Year+1;
       output;
    end;
    format Amt_Import Amt_Export comma12.;
run; 

title 'Belgium Golf and Racket Products - 7% Increase in Exports'; 
proc print data=IncrExports;
    var Sport_Product Year Amt_Import Amt_Export;
run;
title;