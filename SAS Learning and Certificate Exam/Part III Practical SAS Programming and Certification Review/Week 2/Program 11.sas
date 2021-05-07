/* Write a new program that uses PROC EXPORT to export  */
/* cr.employee_current to the output folder as a  */
/* comma-delimited file. */
/* In the navigation pane, find the exported text file  */
/* in the output folder. Right-click the file and  */
/* select Properties. What is the file size, rounded  */
/* to the nearest KB?In the navigation pane,  */
/* right-click the file and select View File as Text. */
proc export data=cr.employee_current
   outfile="/folders/myfolders/ECRB94/output/employee.csv"
   dbms=csv replace;
run;
