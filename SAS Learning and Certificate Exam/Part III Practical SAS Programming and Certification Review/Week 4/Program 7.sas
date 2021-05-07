/* Read the sashelp.shoes table and create a new table named highlow. */
/* The highlow table should include one row for the lowest value of  */
/* Sales for each Product value, and another row for the highest value  */
/* of Sales for each Product value. Create a column named HighLow that  */
/* includes the value High or Low depending on the value of Sales. */
proc sort data=sashelp.shoes out=shoes_sort
              (keep=Region Product Sales Subsidiary);
  by Product Sales;
run;

data highlow;
  length highlow $ 4;
  set shoes_sort;
  by Product;
  if first.Product=1 then do;
    Highlow="low";
    output;
  end;
  if last.Product=1 then do;
    Highlow="High";
    output;
   end;
run;