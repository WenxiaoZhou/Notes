/* Calculate summary statistics for the cr.employee table. */
/* Subset the rows to include only the Sales Department. */
/* Calculate the sum, mean, minimum, and maximum of Salary */
/* for each value of JobTitle. Round values to the  */
/* nearest whole number. */
/* Answer the following questions: */
/* What is the total salary for all Sales employees  */
/* combined? */
/* What is the mean salary for Sales Rep.IV employees? */

proc means data=cr.employee sum mean min max maxdec=0;
  where Department="Sales";
  var Salary;
  class Department Jobtitle;
  ways 0 1;
run;
  
  