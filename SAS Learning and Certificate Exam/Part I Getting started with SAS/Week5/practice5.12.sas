/* Open a new program window and write a PROC MEANS step  */
/* to analyze rows from pg1.np_westweather. */
/* Exclude rows where values for Precip are equal to 0. */
/* Analyze precipitation amounts grouped by Name and Year. */
/* Create only an output table, named rainstats, with  */
/* columns for the N and SUM statistics. */
/* Name the columns RainDays and TotalRain, respectively. */
/* Keep only those rows that are the combination of Year  */
/* and Name. Submit the program and view the output data. */

/* Write a PROC PRINT step to print the rainstats table. */
/* Suppress the printing of observation numbers, and display  */
/* column labels. Display the columns in the following  */
/* order: Name, Year, RainDays, and TotalRain. */
/* Label Name as Park Name, RainDays as Number of Days  */
/* Raining, and TotalRain as Total Rain Amount (inches). */
/* Use Rain Statistics by Year and Park as the report title. */
/* Submit the program and review the results. */

proc means data=pg1.NP_WESTWEATHER;
    where Precip not=0;
    var Precip;
    class Name Year;
    output out=rainstats N=RainDays SUM=TotalRain;
    ways 2;
run;

title "Rain Statistics by Yar and Park";
proc print data=rainstats noobs label;
     var Name Year RainDays TotalRain;
     label Name="Park Name"
           RainDays="Number of Days Raining"
           TotalRain="Total Rain Amount(inches)";
run;
title;
    

    