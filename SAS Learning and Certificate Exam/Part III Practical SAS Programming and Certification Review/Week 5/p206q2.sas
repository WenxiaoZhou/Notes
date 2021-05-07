/* Insert a DO loop containing a statement to calculate the  */
/* estimated values of Wages, Retire, and Medical for  */
/* 10 years. Assume the estimated annual increase shown  */
/* in the table below. */
/* Create a new column name TotalCost as the sum of each  */
/* year’s Wage, Retire, and Medical values. Apply a comma  */
/* format to Wage, Retire, Medical, and TotalCost that  */
/* rounds all values to the nearest whole number. */
/* Output one row for each year. */

data future_expenses;
   Wages=12874000;
   Retire=1765000;
   Medical=649000;
  /* insert a DO loop here */
   do Year=1 to 10;
      Wages=Wages*1.06;
      Retire=Retire*1.014;
      Medical=Medical*1.095;
      TotalCost=Wages+Retire+Medical;
      output;
   end;
   format Wages Retire Medical TotalCost comma12.;
run;
