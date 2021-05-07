/* Open p206p01.sas from the practices folder. */
/* Add an iterative DO loop around the sum statement for */
/* Invest. The DO statement should create the column Year  */
/* with values ranging from 1 to 6. */
/* Add an OUTPUT statement to write the value of the  */
/* retirement account for each year. */
/* Don't forget an END statement. */
/* Submit the program and examine the results. */

/* Now add an inner iterative DO loop between the sum  */
/* statement and the OUTPUT statement to include the  */
/* accrued quarterly compounded interest based on an  */
/* annual interest rate of 7.5%. */
/* Add a DO statement that creates the column Quarter  */
/* with values ranging from 1 to 4. */
/* Add the following sum statement to add the accrued  */
/* interest to the Invest value: Invest+(Invest*(.075/4)); */
/* Add an END statement. */
/* Submit the program and examine the results. */

data retirement;
    do Year = 1 to 6;
       Invest+10000;
       output;
    end;
run;

title1 'Retirement Account Balance per Year';
proc print data=retirement noobs;
    format Invest dollar12.2;
run;
title;

data retirement;
      do Year=1 to 6;
      Invest+10000;
      do Quarter=1 to 4;
        Invest+(Invest*(0.075/4));
       end;
       output;
      end;
      drop Quarter;
run;

title1 'Retirement Account Balance per Year';
proc print data=retirement noobs;
    format Invest dollar12.2;
run;
title;
