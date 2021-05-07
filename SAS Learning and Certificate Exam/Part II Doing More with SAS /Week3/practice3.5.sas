/* Notice that the DATA step creates a table named  */
/* parks and reads only those rows where ParkName ends  */
/* with NP (representing National Parks). */
/* Create a new column named Park that uses the SUBSTR  */
/* function read the value in ParkName and exclude the  */
/* NP code at the end of the string. Hint: Use the FIND  */
/* function to identify the position number of the NP  */
/* string. That value can be used as the third argument  */
/* of the SUBSTR function to specify how many characters */
/* to read. */
/* Convert the Location column to proper case. Use the  */
/* COMPBL function to remove any extra blanks between  */
/* words. Create a new column named Gate by using the  */
/* TRANWRD function to read Location and convert the  */
/* string Traffic Count At to a blank. */
/* Create a new column named GateCode that concatenates  */
/* ParkCode and Gate together with a single hyphen  */
/* between the strings. */

data parks;
	set pg2.np_monthlytraffic;
	where ParkName like '%NP';
/* 	Syntax */
/* <variable=>SUBSTR(string, position <, length>) */
	Park=substr(ParkName,1,find(ParkName,'NP','I')-2);
	Location=compbl(propcase(Location));
	Gate=tranwrd(Location,"Traffic Count At"," ");
	GateCode=catx('-',ParkCode,Gate);
run;

proc print data=parks;
	var Park GateCode Month Count;
run;
