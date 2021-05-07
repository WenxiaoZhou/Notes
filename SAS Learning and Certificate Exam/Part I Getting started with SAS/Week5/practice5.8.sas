***********************************************************;
*  Demo                                                   *;
*    1) Highlight the PROC FREQ step and run the selected *;
*       code. Examine the default results.                *;
*    2) In the PROC FREQ statement, add the ORDER=FREQ    *;
*       option to sort results by descending frequency.   *;
*       Add the NLEVELS option to include a table with    *;
*       the number of distinct values.                    *;
*    3) Add the NOCUM option in the TABLES statement to   *;
*       suppress the cumulative columns.                  *;
*    4) Change Season to StartDate in the TABLES          *;
*       statement. Add a FORMAT statement to display      *;
*       StartDate as the month name (MONNAME.).           *;
*    5) Add the ODS GRAPHICS ON statement before PROC     *;
*       FREQ. Use the PLOTS=FREQPLOT option in the TABLES *;
*       statement to create a bar chart. Add the chart    *;
*       options ORIENT=HORIZONTAL and SCALE=PERCENT.      *;
*    6) Add the title Frequency Report for Basin and      *;
*       Storm Month. Turn off the procedure title with    *;
*       the ODS NOPROCTITLE statement. Add a LABEL        *;
*       statement to display BasinName as Basin and       *;
*       StartDate as Storm Month. Clear the titles and    *;
*       turn the procedure titles back on.                *;
***********************************************************;

ods graphics on;
ods noproctitle;
title "Frequency Report for Basin and Storm Month";
proc freq data=pg1.storm_final order=freq nlevels;
	tables BasinName Season /nocum plots=freqplot(orient=horizontal scale=percent);
	*tables BasinName StartDate /nocum;
	*it tells how many storms occurred on each date, a long table;
	*if interested in group the data with date, how many storms in each 
	month, however, there is no variable named month. However, we still 
	can progress it;
	format StartDate monname.;
	label BasinName="Basin"
	StartDate="Storm Month";
run;
title;
ods proctitle;


