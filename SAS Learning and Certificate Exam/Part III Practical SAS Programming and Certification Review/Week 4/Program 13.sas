/* Use the cr.continent_codes table to create a  */
/* numeric format named CONTFMT. The Code column  */
/* contains data values, and the Continent column  */
/* contains labels. */
/* Read the cr.demographics table and compute the  */
/* sum of the Pop column for each value of Cont.  */
/* Apply the CONTFMT format to the Cont column.  */
data Contfmt;
  set cr.continent_codes;
  retain FmtName "ctryfmt";
  Start=Code;
  Label=Continent;
  keep FmtName Start Label;
run;
proc format cntlin=Contfmt;
run;

proc means data=cr.demographics N sum;
 var Pop;
 class cont;
 format cont contfmt.;
run;

