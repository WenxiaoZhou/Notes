*merge two tables;
proc sort data=cr.profit out=profit_sort;
  by Product_ID;
run;
proc sort data=cr.products out=products_sort;
  by Product_ID;
run;

data profit_detail product_nosales(keep=Product_ID Product_Name);
  merge profit_sort(in=inprof) products_sort(in=inprod);
*in dataset option can determine the matches and nonmatches;
*when both inprof and inprod equal 1, means the value of;
*product_id reads from both tables,it's a match;
  by Product_ID;
  if inprof=1 and inprod=1 then output profit_detail;
  if inprof=0 and inprod=1 then output product_nosales;
run;
