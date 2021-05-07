/* Create a new program. Write a PROC MEANS step to analyze */
/* rows from pg1.np_westweather with the following  */
/* specifications: */
/* Generate the mean, minimum, and maximum statistics for  */
/* the Precip, Snow, TempMin, and TempMax columns. */
/* Use the MAXDEC= option to display the values with a  */
/* maximum of two decimal positions. */
/* Use the CLASS statement to group the data by Year and  */
/* Name. Use Weather Statistics by Year and Park as the  */
/* report title. Submit the program and review the results. */

title "Weather Statistics by Year and Park";
proc means data=pg1.np_westweather mean min max maxdec=2;
    var Precip Snow TempMin TempMax;
    class Year Name;
run;
title;
