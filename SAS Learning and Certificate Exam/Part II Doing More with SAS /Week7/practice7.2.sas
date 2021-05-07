***********************************************************;
*  Creating a Split Table with PROC TRANSPOSE             *;
***********************************************************;
*  Syntax                                                 *;
*                                                         *;
*    PROC TRANSPOSE DATA=input-table OUT=output-table     *;
*                   <PREFIX=column> <NAME=column>;        *;
*        <VAR columns(s)>;                                *;
*        <ID column>;                                     *;
*        <BY column(s)>;                                  *;
*    RUN;                                                 *;
***********************************************************;

***********************************************************;
*  Demo                                                   *;
*  1) Run the PROC TRANSPOSE step and examine the error   *;
*     in the log. The step fails because the values of ID *;
*     are not unique.                                     *;
*  2) Add a BY statement to transpose the values within   *;
*     the groups of Season, Basin, and Name. Run the      *;
*     program.                                            *;
*  3) Notice that the unique values of WindRank (1, 2, 3, *;
*     and 4) are assigned as the column names for the     *;
*     transposed values of WindMPH.                       *;
*  4) To give the transposed columns standard names, add  *;
*     the PREFIX=Wind option in the PROC TRANSPOSE        *;
*     statement. To rename the _name_ column that         *;
*     identifies the source column for the transposed     *;
*     values, add the NAME=WindSource option as well. Run *;
*     the step.                                           *;
*  5) Delete the NAME= option and add the DROP= data set  *;
*     option on the output table to drop the _name_       *;
*     column. Run the step.                               *;
***********************************************************;

proc transpose data=pg2.storm_top4_narrow 
       out=wind_rotate(drop=_name_) prefix=Wind;
	var WindMPH;
	id WindRank;
/* notice that the values of the columns listed on the ID  */
/* statement must be unique. It is true that in the WindRank */
/* column there exists duplicates for 1 to 4. However, we know */
/* that within each combination of Season,basin,Name, WindRank  */
/* is unique. Then, we use by statement*/
   by Season Basin Name;
run;
