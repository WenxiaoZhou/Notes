/* Read the sashelp.fish table and create a new temporary  */
/* table named fish. */
/* Compute a new column named Length that is the mean of  */
/* Length1 through Length3. Round the stored values to the  */
/* nearest hundredth. */
/* Create a summary report that calculates the average of  */
/* Length for each value of Species. Round the average to  */
/* two decimal places. */
data fish;
    set sashelp.fish;
    Length=round(mean(of L:), .01);
run;

proc means data=fish mean maxdec=2;
    var Length;
    class Species;
run;
   
  