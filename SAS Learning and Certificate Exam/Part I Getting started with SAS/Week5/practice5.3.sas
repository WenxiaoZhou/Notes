/* Write a DATA step to create a temporary table named  */
/* eu_occ_total that is based on the pg1.eu_occ table.  */
/* Create the following new columns: */
/* Year The four-digit year extracted from YearMon. */
/* Month The two-digit month extracted from YearMon. */
/* ReportDate The first day of the reporting month.  */
/* (Note: Use the MDY function and the new Year and Month  */
/* columns) */
/* Total The total nights spent at any establishment. */
/* Format Hotel, ShortStay, Camp, and Total with commas. */
/* Format ReportDate to display the values in the form  */
/* JAN2018. Keep Country, Hotel, ShortStay, Camp, ReportDate, */
/* and Total in the new table. Submit the program and  */
/* view the output data. */


data eu_occ_total;
   set pg1.eu_occ;
   *since YearMon variable is a character, we cannot 
   *ues Year and Month function directly;
   Year=substr(YearMon,1,4);
   Month=substr(YearMon,6,2);
   ReportDate=MDY(Month,1,Year);
   Total=sum(Hotel,ShortStay,Camp);
   format Hotel ShortStay Camp Total comma17.;
   format ReportDate monyy7.;
   keep Country Hotel ShortStay Camp ReportDate Total;
RUN;
   