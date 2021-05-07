/* Open p204p05.sas from the practices folder. */
/* Modify the first DATA step to create the np_lookup  */
/* table that will be used to build a custom format. */
/* Add a RETAIN statement to create the FmtName column  */
/* with a value of $RegLbl. Rename the ParkCode column to Start. */
/* Add conditional statements to create the Label column.  */
/* The Label column is equal to the Region column unless the region is missing.  */
/* In that case, the Label column has the value Unknown. */
/* Add a statement to include the Start, Label, and  */
/* FmtName columns in the output data. */
/* Submit the first DATA step and examine the output data. */
/* Modify the PROC FORMAT step to read in the np_lookup table. */
/* In the second DATA step, create a new column named Region.  */
/* Use the PUT function to create the new column by applying the  */
/* $RegLbl format to the ParkCode column. */
/* Submit the the second DATA step and the PROC FREQ step. */

data np_lookup;
    retain FmtName '$RegLbl';
    set pg2.np_codeLookup(rename=(ParkCode=Start));
    if Region ne ' ' then Label=Region;
    else Label='Unknown';
    keep Start Label FmtName;
run;

proc format cntlin=np_lookup;
run;

data np_endanger;
    set pg2.np_species;
    where Conservation_Status='Endangered';
    Region=put(ParkCode,$RegLbl.);
run;

title 'Number of Endangered Species by Region';
proc freq data=np_endanger;
    tables Region / nocum;
run;
title;

