/* Open a new program window and write a PROC FREQ  */
/* step to analyze rows from pg1.np_codelookup. */
/* Generate a two-way frequency table for Type by  */
/* Region. Exclude any park type that contains the  */
/* word Other. The levels with the most rows should */
/* come first in the order. Suppress the display  */
/* of column percentages. Use Park Types by Region  */
/* as the report title. Submit the program and  */
/* review the results. */

/* Limit the park types to the three that were determined  */
/* in the previous step. In addition to suppressing the  */
/* display of column percentages, use the CROSSLIST option */
/* to display the table. Add a frequency plot that groups  */
/* the bars by the row variable, displays row percentages,  */
/* and has a horizontal orientation. Note: Use SAS  */
/* documentation to learn how the GROUPBY=, SCALE=, and  */
/* ORIENT= options can be used to control the appearance of */
/* the plot. Use Selected Park Types by Region as the  */
/* report title. Submit the program and review the results. */

title "Park Types by Region";
proc freq data=pg1.np_codelookup order=freq;
  tables Type*Region /nocol plots=freqplot(orient=
  horizontal scale=percent) ;
  *where type not="Other";
  where type in ("National Historic Site","National 
       Park","National Monument");
run;
title;
  
