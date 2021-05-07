/* Validate Imported Orders Table */
proc print data=cr.orders;
     where Order_date>Delivery_date;
     var Order_ID Order_Date Delivery_Date;
run;
proc freq data=cr.orders;
    tables Order_Type Customer_Country Customer_Continent;
run;
proc univariate data=cr.orders; 
     var Quantity Retail_Price Cost_Price;
run;
/* Preparing Data */
data profit;
   set cr.orders;
   length Order_Source $ 8;
   where Delivery_Date>=Order_Date;
   Customer_Country=upcase(Customer_Country);
   if Quantity<0 then Quantity=.;
   Profit=(Retail_Price-Cost_Price)*Quantity;
   format Profit dollar12.2;
   ShipDays=Delivery_Date-Order_Date;
   Age_Range=substr(Customer_Age_Group,1,5);
   If Order_type=1 then Order_Source="Retail";
   else if Order_type=2 then Order_Source="Phone";
   else if Order_type=3 then Order_Source="Internet";
   else Order_Source="Unknown";
   drop Retail_Price Cost_Price Customer_Age_Group Order_Type;
run;  

proc sql;
    create table profit_country as
       select profit.*, Country_Name
       from profit inner join country_clean
         on profit.Customer_Country=Country_clean.Country_Key;
         order by Order_date desc;
quit;


















