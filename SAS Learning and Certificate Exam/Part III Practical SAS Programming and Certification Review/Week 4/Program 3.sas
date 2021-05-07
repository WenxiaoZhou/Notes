/* Read the cr.employee_current table and create a  */
/* summary table named salary that calculates TotalSalary  */
/* (sum of Salary) for each department. In the output table,  */
/* include only one row for each department. */
/* Create a new table named salaryforecast that reads the  */
/* salary summary table. */
/* For each row in the salary table, write three rows to the  */
/* salaryforecast table. For the first row written to the  */
/* salaryforecast table, create a column named Year that is  */
/* equal to 1. Increase TotalSalary by 3% (multiply by 1.03).  */
/* Write additional rows to the output table with Year equal  */
/* to 2 and 3 and TotalSalary increased by an additional 3%.  */
/* Round values of salaryforecast to the nearest whole number. */

proc means data=cr.employee_current noprint;
  var Salary;
  class Department;
  output out=salary sum=TotalSalary;
  ways 1;
run;

data salaryforecast;
  set salary;
  format TotalSalary dollar12.;
  Year=1;
  TotalSalary=1.03*TotalSalary;
  output;
  Year=2;
  TotalSalary=1.03*TotalSalary;
  output;
  Year=3;
  TotalSalary=1.03*TotalSalary;
  output;
run;

  