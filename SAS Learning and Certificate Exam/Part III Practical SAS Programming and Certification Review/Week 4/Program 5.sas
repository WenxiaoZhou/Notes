proc sort data=cr.profit out=decDaily;
   where month(Order_Date)=12;
   by Order_Date;
run;
/* We would like to create two variables for daily profits and  */
/* monthly profits. According to the out dataset decDaily, the  */
/* data includes profits for month 12. Thus, we define the  */
/* Monthly profit as the accumulation of the total profits. As  */
/* for dailySales, we group by the order_date, and judge the  */
/* boundaries by first.order_date=1. Also, we end each iteration */
/* by the judge the boundaries by last.order_date=1. */

data DecSales;
   set decDaily;
   by Order_Date;
   MTDSales+Profit;
   if first.Order_Date=1 then DailySales=0;
   DailySales+Profit;
   if last.Order_Date=1;
/* this will create and retain the column in the left */
/* add profit in each row and ignore missing values */
/* same thing for DailySales, but remember we need to reset */
/* it as 0 at the beginning of each new day; */
   format MTDSales dailySales dollar12.;
   keep Order_ID Order_Date Profit MTDSales DailySales;
run;