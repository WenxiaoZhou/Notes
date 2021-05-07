/* evaluate whether the data in the cr.employee_raw  */
/* table meets the requirements listed below. */
/* Requirements: */
/* Values in the EmpID column must be unique. */
/* Values in the Country column should be either US  */
/* or AU. There are 17 unique department names. */
/* If TermDate has a known value, it should be after  */
/* HireDate. */

proc freq data=cr.employee_raw order=freq nlevels;
   tables EmpID Country Department;
run;

proc print data=cr.employee_raw;
  where TermDate ne . and HireDate>TermDate;
  format salary dollar10. TermDate 
         HireDate BirthDate date9.;
run;