data storm_complete;
/* Since two tables for year has different names, we should rename */
/* the new table to standardize the column name */
/* For some columns like location only exists in one table, we can drop it or  */
/* there might exist some missing values in the new table */
	set pg2.storm_summary pg2.storm_2017(rename=(Year=Season) drop=Location); 
	Basin=upcase(Basin);
run;

proc sort data=storm_complete;
	by descending StartDate;
run;
