/* Merge the cr.employee and cr.employee_addresses tables to  */
/* create a new table named emp_full. */
/* Include all rows from the cr.employee table in the  */
/* emp_full table. */
/* Ensure that the emp_full table is ordered by EmpID. */
proc sort data=cr.employee_addresses(rename=(Employee_ID=EmpID))
  out=address_sort;
  by EmpID;
run;

data emp_full;
  merge cr.employee(in=inemp) 
      address_sort;
  if inemp=1;
  by EmpID;
run;