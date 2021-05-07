/* Write a DATA step to create two temporary tables,  */
/* named parks and monuments, that are based on the  */
/* pg1.np_summary table. Read only national parks or  */
/* monuments from the input table. (Type is either NP  */
/* or NM.) Create a new column named Campers that is the  */
/* sum of all columns that contain counts of campers.  */
/* Format the column to include commas. */
/* When Type is NP, create a new column named ParkType */
/* that is equal to Park, and write the row to the  */
/* parks table. When Type is NM, assign ParkType as  */
/* Monument and write the row to the monuments table. */
/* Keep Reg, ParkName, DayVisits, OtherLodging, Campers, */
/* and ParkType in both output tables. Submit the  */
/* program and view the output data. */

data parks monuments;
  set pg1.np_summary;
  where Type in ("NP","NM");
  Campers=sum(OtherCamping,RNCampers,TentCampers,BackcountryCampers);
  *format Campers comma17.;
  length ParkType $ 8;
  if Type="NP" then do;
    ParkType="Park";
    output parks;
  end;
  if Type="NM" then do;
    ParkType="Monument";
    output Monuments;
  end;
  keep Reg ParkName DayVisits OtherLodging Campers ParkType;
run;

  