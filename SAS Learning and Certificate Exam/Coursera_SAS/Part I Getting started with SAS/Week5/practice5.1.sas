/* Write a DATA step that reads the pg1.storm_summary  */
/* table and creates an output table named Storm_cat5 as  */
/* a permanent table in the EPG194/output folder.Include  */
/* only Category 5 storms (MaxWindMPH greater than or  */
/* equal to 156) with StartDate on or after 01JAN2000. */
/* Add a statement to include the following columns in the */
/* output data: Season, Basin, Name, Type, and MaxWindMPH. */

/* libname statement point to construct a permanent table  */
/* in the EPG194/out folder */

libname out "path-to-EPG194/out";
DATA Storm_cat5;
   SET pg1.storm_summary;
   WHERE MaxWindMPH>=156 AND StartDate>="01JAN2000"d;
   KEEP Season Basin Name Type MaxWindMPH;
RUN;
   