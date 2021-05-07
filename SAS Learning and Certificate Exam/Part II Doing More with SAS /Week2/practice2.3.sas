/* Complete the PROC SORT step to sort the  */
/* pg2.np_yearlytraffic table by ParkType and ParkName. */
/* In the DATA step, read the sorted table created in  */
/* PROC SORT. Add a BY statement to group the data  */
/* by ParkType. Create a column, TypeCount, that is  */
/* the running total of Count within each value of  */
/* ParkType. Format TypeCount so that values are  */
/* displayed with commas. */
/* Keep only the ParkType and TypeCount columns in the output table. */
/* Submit the program. */
/* Examine the TypeTraffic table and confirm that  */
/* TypeCount is reset at the beginning of each  */
/* ParkType group. */

/* Modify the program to write only the last row for  */
/* each value of ParkType to the output table. */
/* Submit the program and examine the output data */

proc sort data=pg2.np_yearlyTraffic   
          out=sortedTraffic(keep=ParkType ParkName 
                                  Location Count);
          by ParkType ParkName;
    *Insert BY statement;
run;

data TypeTraffic;
    set sortedTraffic;
    by ParkType;
    if first.ParkType=1 then TypeCount=0;
    TypeCount+Count;
    format TypeCount comma 15.;
    keep ParkType TypeCount;
    if last.ParkType=1;
run;
