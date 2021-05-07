/* Open p203q3.sas from the programs folder. Fix the program  */
/* to ensure that the following actions occur: */
/* HireDate is converted to a numeric SAS date value. */
/* Salary is the numeric equivalent of the character column */
/* AnnualSalary. */
/* Questions: */
/* What is the unformatted SAS date value of HireDate for the first  */
/* row of the emp_new table? */
/* Either the COMMA or DOLLAR informat will remove currency symbols  */
/* and commas.  */
data emp_new;
	  set cr.employee_new(rename=(HireDate=HireDateC));
	  EmpID=substr(EmpID,4);
	  HireDate=input(HireDateC, anydtdte10.);
	  Salary=input(AnnualSalary, dollar10.);
	  drop HireDateC;
run;

	