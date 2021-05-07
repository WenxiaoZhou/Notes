/* Determine the name of the common column in the pg2.np_codelookup  */
/* and pg2.np_2016 tables. */
/* Write a new program to sort the data in both tables by the  */
/* matching column. */
/* Using a DATA step, merge the pg2.np_codelookup and  */
/* pg2.np_2016 tables to create two new tables named  */
/* work.parkStats and work.parkOther. */
/* The work.parkStats table should contain only ParkCode  */
/* values that are in the np_2016 table, and it should only  */
/* the ParkCode, ParkName, Year, Month, and DayVisits columns. */
/* The work.parkOther table should contain all other rows,  */
/* and it should include only the ParkCode and ParkName  */
/* columns. */
/* Submit the program and examine the output data. */

proc sort data=pg2.np_codelookup out=sort1;
	by ParkCode;
run;
proc sort data=pg2.np_2016 out=sort2;
   by ParkCode;
run;
data work.parkStats(keep=ParkCode ParkName Year Month DayVisits)
     work.parkOther(keep=ParkCode ParkName);
   merge sort2(in=inStats) sort1;
   by ParkCode;
   if inStats=1 then output work.parkStats;
   else output work.parkOther;
run;
