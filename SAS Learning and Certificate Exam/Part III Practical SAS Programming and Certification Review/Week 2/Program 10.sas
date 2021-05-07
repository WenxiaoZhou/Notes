/* Exporting PDF Results from Orders Exploration */
ods pdf file="/folders/myfolders/ECRB94/output/orders_validation.pdf"
     pdftoc=1;
*pdftoc Controls the level of the expansion of the table of contents in PDF documents;
ods proclabel "Orders with Order Date After Delivery Date";
title "Orders with Order Date After Delivery Date";
proc print data=cr.orders;
   where Order_date>Delivery_Date;
   var Order_ID Order_Date Delivery_Date;
run;

ods proclabel "Examine Values of Numeric Columns in Orders";
title "Examine Values of Numeric Columns in Orders";
proc freq data=cr.orders;
   tables Order_Type Customer_Country Customer_Continent;
run;

ods proclabel "Examine Values of Categorical Columns in Orders";
title "Examine Values of Categorical Columns in Orders";
proc means data=cr.orders maxdec=0;
  var Quantity Retail_Price Cost_Price;
run;

ods pdf close;