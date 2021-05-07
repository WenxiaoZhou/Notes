/* Create a numeric format named BMIRANGE that  */
/* assigns the following ranges and labels. */
/* Create a frequency report based on the BMI column */
/* in the sashelp.bmimen table. Include rows where  */
/* Age is greater than or equal to 21. Apply the  */
/* BMIRANGE format to the BMI column. */
proc format;
  value Bmirange
    low-<18.5="Underweight"
    18.5-24.9="Normal"
    25-29.9="Overweight"
    30-high="Obese";
run;
proc freq data=sashelp.bmimen;
  where Age>=21;
  format BMI Bmirange.;
run;