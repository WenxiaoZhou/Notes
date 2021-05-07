***********************************************************;
*  Activity 6.02                                          *;
*  1) Run the program and view the Savings3K table.       *;
*  2) How many months until James exceeds 3000 in         *;
*     savings?                                            *;
*  3) How much savings does James have at that month?     *;
*  4) Change the DO UNTIL statement to a DO WHILE         *;
*     statement and modify the expression to produce the  *;
*     same results.                                       *;
*  5) Run the program and view the Savings3K table.       *;
*  6) Are the results for James identical with the DO     *;
*     WHILE as compared to the DO UNTIL?                  *;
***********************************************************;

data Savings3K;
   set pg2.savings;
   Month=0;
   Savings=0;
   do until (Savings>3000);
/* change the do loop to "do while (Savings<=3000);"  */
/* can get same results */
      Month+1;
      Savings+Amount;
      Savings+(Savings*0.02/12);
   end;
   format Savings comma12.2;
run;

