/* Tasks of Tourism 1:Create the Cleaned_Tourism Table  */
/* Part I:*/
/* Read the cr.tourism table and create the  */
/* cr.cleaned_tourism table. Remove the columns _1995  */
/* through _2013. Create the Country_Name and  */
/* Tourism_Type columns from values in the Country column.  */
/* Valid values for Tourism_Type are Inbound tourism  */
/* and Outbound tourism. */
/* Run your code and view the cleaned_tourism table so  */
/* far. Remove rows that contain only the country  */
/* name and tourism type information. */
data cleaned_tourism;
*when there is a value in the A column, that indicates a new country;
*name and the country column;
*set the length of Country_Name as the first column, to put it before set statement;
  length Country_Name $300 Tourism_Type $20;
  retain Country_Name "" Tourism_Type "";
  set cr.tourism(drop=_1995-_2013);
  if A ne . then Country_Name=Country;
  if lowcase(Country)="inbound tourism" then 
        Tourism_Type="Inbound Tourism";
    else if lowcase(Country)="outbound tourism" then
        Tourism_Type="Outbound Tourism";
   if Country_Name ne Country and Country ne Tourism_Type;
/* Part II: */
/* In the Series column, convert values to uppercase and convert ".."  */
/* to missing a character value. */
/* Determine the conversion type (Mn or Thousands) that will be used  */
/* to calculate values for the new Y2014 column. Hint: You might find  */
/* it easiest to create a new column with this information. */
/* In the _2014 column, change values of ".." to a single period. */
   series=upcase(series);
   if series="." then Series="";
   ConversionType=scan(country,-1," ");
   if _2014=".." then _2014=".";
/* Part III: */
/* Create the Y2014 column by explicitly converting character values  */
/* in _2014 to numeric and multiplying by the conversion type  */
/* (millions or thousands) that is found in the Country column or new  */
/* column, if you created one. */
/* Create the new Category column from values in the Country column and  */
/* change the original values to the following valid values: Arrivals,  */
/* Departures, Passenger Transport - US$, Tourism expenditure in other  */
/* countries - US$, Tourism expenditure in the country - US$,  */
/* Travel - US$ */
/* Permanently format Y2014 with the COMMA format. */
/* Include only Country_Name, Tourism_Type, Category, Series, and Y2014  */
/* in the output table. */
   if ConversionType="Mn" then do;
     if _2014 ne ":" then Y2014=input(_2014,16.)*1000000;
*not equal to a period(:) means there is a character value in there;
        else Y2014=.;
    Category=cat(scan(country,1,'-','r'),'-US$');
    end;
    else if ConversionType="Thounsands" then do;
        if _2014 ne ":" then Y2014=input(_2014,16.)*1000;
*not equal to a period(:) means there is a character value in there;
        else Y2014=.;
    Category=scan(country,1,'-','r');
    end; 
    format y2014 comma25.;
    drop A ConversionType Country _2014;
*r modifier removes leading and trailing blanks;
run;

/* proc freq data=cleaned_tourism; */
/*   tables Country_Name Tourism_Type Series ConversionType; */
/* run; */

proc freq data=cleaned_tourism;
  tables category tourism_type Series;
run;

proc means data=Cleaned_tourism min mean max n maxdec=0;
   var Y2014;
run;

/* Tasks of Tourism 2:Create the Final_Tourism Table */
/* Part I: */
/* Create a format for the Continent column that labels continent IDs  */
/* with the corresponding continent names found in the table below. */
/* Merge the cleaned_tourism table with a sorted version of country_info  */
/* to create the final_tourism table. Include only matches in the output  */
/* table. Use the new format to format Continent. */

/* create the custom format */
proc format;
  value contIDs
    1="North America"
    2="South America"
    3="Europe"
    4="Africa"
    5="Asia"
    6="Oceania"
    7="Antarctica";
run;
/* merge matching rows */
proc sort data=cr.country_info(rename=(Country=Country_Name)) 
      out=country_sorted;
    by country_name;
run;
data final_tourism;
  merge cleaned_tourism(in=t) Country_Sorted(in=c);
  by Country_name;
  if t=1 and c=1 then output Final_Tourism;
  format continent contIDs.;
run;
proc freq data=final_tourism nlevels;
   tables category series Tourism_Type Continent /nocum nopercent;
run;
proc means data=final_tourism min mean max maxdec=0;
  var Y2014;
run;

/* Tasks of Tourism 3:Create the NoCountryFound Table */
/* Create the NoCountryFound table that has a list of countries  */
/* from Cleaned_Tourism that are not found in the country_info  */
/* table. This table should have only one row for each country. */
/* Hints: */
/* In the DATA step merge, add an IF-THEN statement to output  */
/* rows where there is a row from the cleaned_tourism table but  */
/* not a match in the country_sorted table AND it is the first  */
/* time you see the country name. This will output only unique  */
/* countries from the cleaned_tourism table that do not have a  */
/* match in the country_sorted table. You will need to use the  */
/* BY statement and check the values of the FIRST./LAST.  */
/* variables to output only the first occurrence of a country  */
/* name. */
data final_tourism
     NoCountryFound(keep=Country_Name);
  merge cleaned_tourism(in=t) Country_Sorted(in=c);
  by Country_name;
  if t=1 and c=1 then output final_tourism;
  if (t=1 and c=0) and first.country_name=1
    then output NoCountryFound;
  format continent contIDs.;
run;

/* Test the case study */
proc means data=final_tourism mean min max maxdec=0;
  var Y2014;
  class Continent;
  where Category="Arrivals";
run;
proc means data=final_tourism mean maxdec=0;
  var Y2014;
  where lowcase(Category) contains "tourism expenditure in other countries";
run;

  
  
  
  
  












  
  