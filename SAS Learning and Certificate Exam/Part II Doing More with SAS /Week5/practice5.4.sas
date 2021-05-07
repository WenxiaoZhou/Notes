***********************************************************;
*  Merging Tables with Non-matching Rows                  *;
***********************************************************;
*  Syntax and Examples                                    *;
*                                                         *;
*    DATA output-table;                                   *;
*        MERGE input-table1(IN=variable1)                 *;
*              input-table2(IN=variable2) ...;            *;
*        BY by-variable;                                  *;
*        IF expression;                                   *;
*    RUN;                                                 *;
***********************************************************;

/*Include matching rows only*/
data class2;
    merge pg2.class_update(in=inUpdate) 
          pg2.class_teachers(in=inTeachers);
    by name;
    if inUpdate=1 and inTeachers=1;
run;

***********************************************************;
*  Demo                                                   *;
*  1) Highlight the first PROC SORT step and run the      *;
*     selected code. A table named STORM_FINAL_SORT is    *;
*     created, arranged by Season and Name. Because some  *;
*     storm names have been used more than once, unique   *;
*     storms are identified by both Season and Name.      *;
*  2) Open PG2.STORM_DAMAGE. Notice that it does not      *;
*     include the columns Season and Name, which are in   *;
*     STORM_FINAL_SORT. Season and Name must be derived   *;
*     from the Date and Event columns.                    *;
*  3) Examine the DATA step that creates a temporary      *;
*     table named STORM_DAMAGE. SAS functions are used to *;
*     create Season and Name with values that match the   *;
*     values in the STORM_FINAL_SORT table. Highlight the *;
*     DATA step and the PROC SORT step that follows it,   *;
*     and run the selection.                              *;
*  4) Complete the final DATA step to merge the sorted    *;
*     tables by Season and Name. Highlight the DATA step  *;
*     and run the selection. Notice in the output table   *;
*     that row 4 is storm Allen, which is included in the *;
*     STORM_DAMAGE table. Therefore, each of the columns  *;
*     has values read from both input tables. Most of the *;
*     values in the Cost and Deaths columns are missing   *;
*     because those storms are not found in the           *;
*     STORM_DAMAGE table.                                 *;
*  5) Use the IN= data set option after the STORM_DAMAGE  *;
*     table to create a temporary variable named inDamage *;
*     that flags rows where Season and Name were read     *;
*     from the STORM_DAMAGE table. Add a subsetting IF    *;
*     statement to write the 38 rows from STORM_DAMAGE    *;
*     and the corresponding data from STORM_FINAL_SORT to *;
*     the output table. Highlight the DATA step and run   *;
*     the selection.                                      *;
***********************************************************;

proc sort data=pg2.storm_final out=storm_final_sort;
	by Season Name;
run;

data storm_damage;
	set pg2.storm_damage;
	Season=Year(date);
	Name=upcase(scan(Event, -1));
	format Date date9. Cost dollar16. deaths comma5.;
	drop event;
run;

proc sort data=storm_damage;
	by Season Name;
run;
/* if we don't add in option, we find a lot of missing values */
/* in Costs and Deaths columns, which come from storm_damage */
/* table, only included 38 rows. What if we only want to include */
/* those 38 rows in the table? */
data damage_detail;
	merge storm_final_sort storm_damage(in=InDamage);
	by Season Name;
	if InDamage=1;
/* if statement is true, SAS will continue processing the following codes */
	keep Season Name BasinName MaxWindMPH MinPressure Cost Deaths;
run;


