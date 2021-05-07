/* read the cr.employee_raw table and create a new  */
/* sorted table named emp_sort. Sort rows by all columns  */
/* and remove entirely duplicated rows. */
proc sort data=cr.employee_raw 
     out=emp_sort noduprecs;
     by _all_ ;
run;
/* write and submit a procedure step to read the  */
/* emp_sort table and create a listing of all employees  */
/* with a JobTitle that includes Logistics. */
proc print data=emp_sort;
   where JobTitle contains "Logistics";
   format salary dollar10. 
       TermDate HireDate Birthdate date9.;
run;

/* What is the average salary for employees with a  */
/* hire date on or after January 1, 2010, and a missing  */
/* value for TermDate? Note: Type your answer exactly  */
/* as the value is displayed. */
proc means data=emp_sort mean n;
  where Hiredate>= "01JAN2010"d and TermDate is missing;
  var salary;
run;

/* What is the third highest salary among all employees? */
proc univariate data=emp_sort;
  var salary;
run;



  
