***********************************************************;
*  Demo                                                   *;
*    1) Add a SELECT statement to retrieve all columns    *;
*       from PG1.STORM_FINAL. Highlight the step and run  *;
*       the selected code. Examine the log and results.   *;
*    2) Modify the query to retrieve only the Season,     *;
*       Name, StartDate, and MaxWindMPH columns. Format   *;
*       StartDate with MMDDYY10. Highlight the step and   *;
*       run the selected code.                            *;
*    3) Modify Name in the SELECT clause to convert the   *;
*       values to proper case.                            *;
*    4) Add a WHERE clause to include storms during or    *;
*       after the 2000 season with MaxWindMPH greater     *;
*       than 156.                                         *;
*    5) Add an ORDER BY clause to arrange rows by         *;
*       descending MaxWindMPH, and then by Name.          *;
*    6) Add TITLE statements to describe the report.      *;
*       Highlight the step and run the selected code.     *;
***********************************************************;

title "International Storms since 2000";
title2 "Category 5(MPH>156)";
proc sql;
*Add SELECT statement;
select Season, propcase(Name) as Name, 
     StartDate format=mmddyy10.,MaxWindMPH
   from pg1.storm_final
   where MaxWindMPH>156 and Season>2000
   order by MaxWindMPH desc, Name;
quit;
title;