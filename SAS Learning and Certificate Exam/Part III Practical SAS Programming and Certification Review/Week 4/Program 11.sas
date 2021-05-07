proc format;
  value shiprange 0="Same day"
                  1-3="1-3 days"
                  4-7="4-7 days"
                  8-high="8+ days"
                  .="Unknown";
run;
*by default,this format is written to the work library;
*create permanently to the appropriate column in a table,use
*data step;
data profit2;
  set cr.profit;
  format ShipDays shiprange.;
  *create a new column use the format;
  Shiprange=put(ShipDays,shiprange.);
run;

proc freq data=cr.profit;
  table ShipDays;
  format shipDays shiprange.;
run;

data country;
  set cr.country_clean;
  FmtName="$ctryfmt";
  Start=Country_key;
  Label=Country_Name;
  keep FmtName Start Label;
run;
proc format cntlin=country;
*create the format be ready to use with any column that; 
*a country code; 
data profit2;
  set cr.profit;
  format ShipDays shiprange.;
  ShipRange=put(ShipDays,shiprange.);
  format Customer_Country ctryfmt.;
run;
  
  
  
  
  
  
  