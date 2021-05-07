/* Fix the program to ensure that the following actions occur: */
/*  */
/* Values of Country should all be uppercase in the output tables. */
/* Include only rows where TermDate is missing. */
/* All rows where Country is US are written to the emp_US table. */
/* All rows where Country is AU are written to the emp_AU table. */

data emp_US emp_AU;
	set cr.employee;
	keep EmpID Name JobTitle Salary Department Country TermDate;
	where TermDate=.;
	Country=upcase(country);
	if Country="US" then output emp_US;
	else output emp_AU;
run;

