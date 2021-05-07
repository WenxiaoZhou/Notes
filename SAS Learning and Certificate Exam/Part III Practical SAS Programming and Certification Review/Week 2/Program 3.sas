/* Create a new table named bonus and read cr.employee. */
/* Exclude any employees with a known value for TermDate. */
/* Use the YRDIF function to create a new column named YearsEmp  */
/* that calculates the number of years that each person has been */
/* employed as of 01JAN2019. */
/* For employees that have been employed 10 years or more, create  */
/* a new column named Bonus that is 3% of Salary. Create another  */
/* column named Vacation that is assigned the number 20. */
/* For all other employees, calculate Bonus as 2% of Salary.  */
/* Assign 15 as the value of Vacation. */
/* Count the number of employees with 20 and 15 vacation days. */
/* Sort the bonus table by YearsEmp in descending order. */

data bonus;  
   set cr.employee;
   where TermDate=.;
   YearsEmp=yrdif(HireDate,"01JAN2019"d, "age");
   if YearsEmp>=10 then do;
      Bonus=0.03*Salary;
      Vacation=20;
      end;
   else do;
       Bonus=0.02*Salary;
       Vacation=15;
    end;
run;
proc freq data=bonus;
 tables vacation;
run;
proc sort data=bonus;
  by descending YearsEmp;
run;
       