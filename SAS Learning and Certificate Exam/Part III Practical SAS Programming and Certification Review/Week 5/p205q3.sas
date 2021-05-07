/* The donation table contains all EmpID values that are in  */
/* both the cr.employee and cr.employee_donations tables. */
/* TotalDonation should be calculated in the donation table. */
/* Create an additional output table named nodonation that  */
/* includes EmpID values that are in the cr.employee table  */
/* but not in the cr.employee_donations table. */

proc sort data=cr.employee(keep=EmpID Name Department) out=emp_sort;
	by EmpID;
run;

proc sort data=cr.employee_donations out=donate_sort;
	by EmpID;
run;

data donation;
	merge emp_sort(in=in_emp) donate_sort(in=in_don);
	by EmpID;
	if in_don=1 and in_emp=1;
	TotalDonation=sum(of Qtr1-Qtr4);
run;
data nodonation;
	merge emp_sort(in=in_emp) donate_sort(in=in_don);
	by EmpID;
    if in_emp=1 and in_don=0 then output nodonation;
run;