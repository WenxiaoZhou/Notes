/* Write and submit a program to analyze the number of  */
/* employees in the cr.employee table by City, Department, */
/* and JobTitle. */
/* Answer the following questions: */
/* Which city has the highest number of employees? */
/* What percentage of all employees are in the Sales  */
/* Department?  */
/* How many unique values of JobTitle are in the  */
/* employee table? */

proc sort data=cr.employee out=cr.employee_sort;
 by City Department;
run;
/* nlevels option displays the number of levels for  */
/* all TABLES variables */
proc freq data=cr.employee_sort order=freq nlevels;
 tables City Department Jobtitle /nocum;
run;

