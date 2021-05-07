/* Read the payroll.csv text file in the data folder  */
/* and create a temporary SAS table named payroll.  */
/* Enable SAS to scan all the rows from the text file  */
/* to determine column attributes in the payroll table. */
/* Generate a report of the descriptor portion of the  */
/* payroll table. */

%let path=/folders/myfolders/ECRB94;
proc import datafile="&path/data/payroll.csv" 
         out=payroll dbms=csv replace;
         guessingrows=max;
run;
proc contents data=payroll;
run;

libname employee xlsx "&path/data/employee.xlsx";

proc contents data=employee._all_;
run;
