proc sort data=cr.m7_sales out=m7sales;
  by Order_ID;
run;
proc sort data=cr.m8_sales out=m8sales;
  by Order_ID;
run;
proc sort data=cr.m9_sales out=m9sales;
  by Order_ID;
run;

data q3_sales;
  set m7sales m8sales(rename=(Employee_ID=EmpID)) 
      m9sales;
  by Order_ID;
  *if insale7=1 and insale8=1 and insale9=1
    then output q3_sales;
run;
proc freq data=q3_sales;
  table Order_Type;
run;