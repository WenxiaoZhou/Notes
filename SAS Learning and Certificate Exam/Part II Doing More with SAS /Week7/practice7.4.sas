/* Examine the np_2016camping table. Notice that the table  */
/* contains one row for each location type (Tent, RV, and  */
/* Backcountry) by ParkName. In addition, notice that the table  */
/* is sorted alphabetically by ParkName. */
/* Open a new program window and write a PROC TRANSPOSE step to  */
/* create a wide table named work.camping2016_t. */
/* Include only the ParkName column and individual columns for  */
/* the values of CampType. */
/* Submit the program and examine the output data. */

proc print data=pg2.np_2016camping(obs=5);
run;
proc transpose data=pg2.np_2016camping
                 out=work.camping2016_t(drop=_NAME_);
               var CampCount;
               id CampType;
               by ParkName;
run;
