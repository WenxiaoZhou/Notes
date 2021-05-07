/* Open the p207p04.sas program in the practices folder. */
/* Submit the PROC PRINT step to display the first five rows  */
/* of pg2.np_2017camping. Notice that the table contains three  */
/* columns (Tent, RV, and Backcountry) with visitor counts for  */
/* each value of ParkName. In addition, notice that the table is  */
/* sorted by ParkName. */
/* In the PROC TRANSPOSE step, add the OUT= option to create a  */
/* table named work.camping2017_t. */
/* Add a BY statement to group the data by ParkName. This creates  */
/* one row in the output table for each unique value of ParkName. */
/* Add a VAR statement to transpose the Tent and RV columns. */
/* Submit the PROC TRANSPOSE step and examine the output data. */

proc print data=pg2.np_2017camping(obs=5);
run;

proc transpose data=pg2.np_2017camping name=Location
                out=work.camping2017_t(rename=(col1=Count));
      by ParkName;
      var Tent RV;
run;