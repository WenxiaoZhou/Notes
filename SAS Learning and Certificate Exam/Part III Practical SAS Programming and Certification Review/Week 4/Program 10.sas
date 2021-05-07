/* Read the sashelp.baseball table and create a new table  */
/* named outfield. */
/* Filter rows to include only players where the second  */
/* letter of Position is F. */
/* Create a new column named Player that rearranges  */
/* the value in the Name column so that first name is  */
/* first and then last name separated by a space. */
/* Compute a new column named BatAvg as nHits divided  */
/* by nAtBat. Round the calculated value to three  */
/* decimal places. */
/* Sort the outfield table by descending BatAvg. */

data outfield;
  set sashelp.baseball;
  where substr(Position,2)="F";
  Player=catx(" ",substr(Name,2),substr(Name,1));
  BatAvg=round(nHits/nAtBat,.001);
run;

proc sort data=outfield;
  by descending BatAvg;
run;


