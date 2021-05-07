/* Analyze frequency counts for the cr.profit table. */
/* Create a two-way frequency table that includes the  */
/* frequency count and percent for each Order_Date and  */
/* Order_Source. */
/* Display Order_Date using the MONNAME format so there  */
/* is one row per month in the table. */
proc freq data=cr.profit nlevels;
  tables Order_Date*Order_Source /nocum norow;
  format Order_Date monname.;
run;