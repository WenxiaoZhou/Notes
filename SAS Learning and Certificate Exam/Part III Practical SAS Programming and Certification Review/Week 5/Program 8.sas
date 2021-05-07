/* Read the cr.employee_training table and create a new  */
/* table named training_narrow. */
/* Convert the wide table to a narrow table so that there  */
/* is one row for each date value. */
/* Generate a report that counts the number of courses  */
/* completed by month (Hint: Use the MONNAME. format.) */

proc sort data=cr.employee_training out=training_sort;
  by Name;
run;
/*Either PROC TRANSPOSE or the DATA step will create training_narrow*/
proc transpose data=training_sort
               out=training_narrow(rename=(col1=Date)) name=Course;
   by Name;
   var Compliance_Training Corporate_Security on_the_Job_Safety;
run;
/* OR */
data training_narrow;
   set training_sort;
   Course="Compliance_Training";
   Date=Compliance_Training;
   output;
   Course="Corportae_Security";
   Date=Corportae_Security;
   output;
   Course="On_the_Job_Safety";
   Date=On_the_Job_Safety;
   output;
   drop Compliance_Training Corporate_Security on_the_Job_Safety;
   format Date date9.;
run;
proc freq data=training_narrow;
   tables Date;
   format Date monname.;
run;
proc freq data=training_narrow;
   tables course;
   format Date monname.;
run;

  