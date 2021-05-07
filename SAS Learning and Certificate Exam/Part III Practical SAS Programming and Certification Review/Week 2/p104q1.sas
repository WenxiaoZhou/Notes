/* Open p104q1.sas from the programs folder. */
/* Identify and fix the syntax errors. The values of CountryCode  */
/* should be the last two letters of Category. The output table  */
/* should include the Desc, CountryCode, and Date columns. */
/* Run the program. */

data holiday2019;
	set sashelp.holiday;
	where end=. and rule=0;
	CountryCode=substr(Category,4,2);
	Date=mdy(month,day, 2019);
	keep Desc CountryCode Date;
run;

