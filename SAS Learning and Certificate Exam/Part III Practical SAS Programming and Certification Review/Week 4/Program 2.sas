/* Write a new program that reads the sashelp.heart table  */
/* and separates rows into two tables, dead and alive,  */
/* based on the value of Status. Drop Status from both tables  */
/* and drop DeathCause and AgeAtDeath from the alive table. */
data dead alive(drop=DeathCause AgeAtDeath);
  set sashelp.heart;
  if Status="Dead" then output dead;
  else output alive;
  drop Status;
run;
  











