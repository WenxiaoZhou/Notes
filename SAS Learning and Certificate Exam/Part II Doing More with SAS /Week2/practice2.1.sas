/* Create a table, parkTypeTraffic, from the pg2.np_yearlytraffic table. 
/* Use the following specifications: Read only the rows from the input*/
/* table where ParkType is National Monument or National Park. */
/* Create two new columns named MonumentTraffic and  */
/* ParkTraffic. The value of each column should be  */
/* increased by the value of Count for that park type. */
/* Format the new columns so that values are displayed with commas.  */
/* Create a listing report of parkTypeTraffic as follows: */
/* Use Accumulating Traffic Totals for Park Types as  */
/* the report title. Display the columns in this  */
/* order: ParkType, ParkName, Location, Count,MonumentTraffic, and 
/* ParkTraffic. Submit the program and view the results. */

data work.parkTypeTraffic;
  set pg2.np_yearlyTraffic;
  where ParkType in ("National Monument","National Park");
   if ParkType="National Monument" then do;
     MonumentTraffic+Count;
     end;
   else if ParkType="National Park" then do;
     ParkTraffic+Count;
     end;
    format MonumentTraffic ParkTraffic commas 15.;
run;
title "Accumulating Traffic totals for Park Type";
proc print data=work.parkTypeTraffic;
   var ParkType ParkName Location 
       Count MonumentTraffic ParkTraffic;
run;
title;