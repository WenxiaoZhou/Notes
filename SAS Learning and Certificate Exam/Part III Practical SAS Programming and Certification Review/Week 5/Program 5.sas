*Using Iterative and Conditional DO Loops;
data profit_forecast;
  set cr.profit_summary;
  Year=1;
  TotalProfit=TotalProfit*1.05;
  output;
  Year=2;
  TotalProfit=TotalProfit*1.05;
  output;
  Year=3;
  TotalProfit=TotalProfit*1.05;
  output;
run;
*the above codes can be replaced by the do-loop;
data profit_forecast;
  set cr.profit_summary;
  do Year=1 to 3;
 *do Year=1,2,3;
   TotalProfit=TotalProfit*1.05;
   output;
   end;
run;

data rewards;
   Reserve=1000000;
   Rewards=-1000000;
   do Year=1 to 10;
      Reserve+25000;
      Reserve+(Reserve*0.03);
      Reserve+Rewards;
      output;
   end;
   format Reserve dollar12.;
run;
*If there is no explicit OUTPUT statement in this program,
*only one row will be written to the rewards table;

data rewards;
   Reserve=1000000;
   Rewards=-100000;
*how many years will the reserve be gone?;
   do while(Reserve>0);
      Year+1;
      Reserve+25000;
      Reserve+(Reserve*0.03);
      Reserve+Rewards;
      output;
   end;
   format Reserve dollar12.;
run;

data rates;
  input rate;
  datalines;
0.02
0.03
0.04
0.05
;
run;

data rewards; 
    set rates; 
    Reserve=1000000; 
    Rewards=-100000; 
    do Year=1 to 50 until(Reserve<0); 
       do month=1 to 12; 
          Reserve+2500; 
          Reserve+(Reserve*rate/12); 
       end; 
       Reserve+Rewards; 
       *output; 
    end; 
    format Reserve dollar12.; 
run;
/* if I want to have only the final row for the each rate in */
/* the output table, delete the OUTPUT STATEMENT to obtain */





