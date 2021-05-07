data qtr_detail;
  set cr.qtr_sales;
  TotalPurchase=sum(of qtr:);
  AvgPurchase=round(mean(of qtr:),.01);
  Customer_Age=int(yrdif(BirthDate,today(),"age"));
  Promo_Date=mdy(month(BirthDate),1,year(today()));
  FirstName=scan(Name,1," ");
*put function, 2nd. argument is the format that writes the;
*number as a string, to insert leading zeros to fill five;
*total positions, use the "z5.: format;
  ID=put(Customer_ID,z5.);
  format TotalPurchase AvgPurchase dollar12.2
         Promo_Date mmddyy10.;
  drop qtr: Customer_ID;
run;

data qtr_detail;
   retain ID NAME FristName BirthDate Customer_Age Promo_Date 
          TotalPurchase AvgPurchase;
   set qtr_detail;
run;