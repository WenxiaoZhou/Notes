/* TSA Case Study: */
/* 1.Accessing Data: Import the TSAClaims2002_2017.csv file. */
/* Hints: */
/* Define the TSA library */
/* Set an option to enforce SAS naming conventions for column names */
/* Use PROC IMPORT to create a SAS table */
/* Use the GUESSINGROWS=MAX statement in the IMPORT procedure */

%let path=/folders/myfolders/ECRB94/data;
libname tsa "&path";
*Set an option to enforce SAS naming conventions for column names;
options validvarname=v7;

proc import datafile="&path/TSAClaims2002_2017.csv"
   dbms=csv
   out=tsa.ClaimImport
   replace;
   guessingrows=max;
run;

/* 2.Exploring Data: Preview the data and Explore the following columns  */
/* and make note of any adjustments you need to make using the information  */
/* from the Requirements document.  */
/* Claim_Site */
/* Disposition */
/* Claim_Type */
/* Date_Received */
/* Incident_Date */
/* Hints: */
/* Use PROC PRINT and PROC CONTENTS to preview the data. */
/* Use PROC FREQ to explore the columns. Be sure to compare the list of  */
/* values in the PROC FREQ results to the list of valid values in the data  */
/* requirements document. This will help you determine what needs to be fixed. */
proc print data=tsa.claimimport(obs=20);
run;
proc contents data=tsa.claimimport varnum;
*varnum option prints a list of the variable names in the order of their logical 
*position in the data set;
run;
*check the name of each variable and missing values and prepare for the next step;
proc freq data=tsa.claimimport; 
   tables claim_site
          disposition
          Claim_Type
          Date_Received
          Incident_Date /nocum nopercent;
    format incident_date date_received year4.;
run;
proc print data=tsa.ClaimImport;
   where date_received<incident_date;
   format date_received incident_date date9.;
run;
          
/* 3.Preparing Data: */

/* Remove duplicate rows. */
proc sort data=tsa.CLAIMIMPORT
       out=tsa.Claims_NoDups noduprecs;
       by _ALL_;
run;
*Log shows that 5 duplicate observations were deleted;
/* Use PROC SORT with the NODUPRECS option to remove duplicate rows. */
/* Use PROC SORT to sort the new duplicate-free table. */
/* Sort the data by ascending Incident_Date. */
proc sort data=tsa.claims_nodups;
   by Incident_Date;
run;

/* Clean the Claim_Site column. */
/* Clean the Disposition column. */
/* Clean the Claim_Type column. */
/* Use IF-THEN logic to test whether the Claim_Site column has invalid characters  */
/* and, if so, set the value of the column to the required value. */
/* Use IF-THEN/ELSE logic to test whether the Disposition column has invalid  */
/* characters and conditionally set the value of the column to the required value. */
/* Use IF-THEN/ELSE logic to test whether the Claim_Type column has invalid  */
/* characters and conditionally set the value of the column to the required value. */
/* Use IF-THEN logic to create the new column Date_Issues by testing the requirements  */
/* for invalid dates on the Incident_Date and Date_Received columns. See the data  */
/* requirements for the definition of date issues in these two columns. */

data tsa.claims_cleaned;
   set tsa.claims_nodups;
   if Claim_Site in ('-','') then Claim_Site="Unknown";
   if Disposition in ('-','') then Disposition="Unknown";
      else if Disposition='losed: Contractor Claim'
         then Disposition='closed:Contractor Claim';
      else if Disposition='Closed: Canceled' 
         then Disposition='Closed:Canceled';
   if Claim_Type in ('-','') then Claim_Type="Unknown";
      else if Claim_Type='Passenger Property Loss/Personal Injur'
          then Claim_Type='Passenger Property Loss';
       else if Claim_Type='Passenger Property Loss/Personal Injury'
          then Claim_Type='Passenger Property Loss';
       else if Claim_Type='Property Damage/Personal Injury'
          then Claim_Type='Property Damage';
/* Use functions to fix the values in the State and StateName columns. */
/* Convert all Sate values to uppercase and all StateName values to proper case. */
    State=upcase(state);
    StateName=propcase(StateName);
/* Create a new column to indicate date issues.*/
    if (Incident_Date>Date_Received or 
        Date_Received=. or
        Incident_Date=. or
        year(Incident_Date)<2002 or
        year(Incident_Date)>2017 or
        year(Date_Received)<2002 or 
        year(Date_Received)>2017)
      then Date_Issues="Needs Review";

/* Use FORMAT and LABEL statements. */
   format Incident_Date Date_Received date9.
          Close_Amount Dollar20.2;
   label Airport_Code="Airport Code"
         Airport_Name="Airport Name"
         Claim_Number="Claim Number"
         Claim_Site="Claim Site"
         Claim_Type="Claim Type"
         Close_Amount="Close Amount"
         Date_Issues="Date Issues"
         Date_Received="Date Received"
         Incident_Date="Incident Date"
         Item_Category="Item Category";   
/* Use a statement to exclude County and City from the output table. */
      drop county city;
run;

*use PROC FREQ to check any other issues in the columns;
proc freq data=tsa.Claims_Cleaned order=freq;
   tables Claim_Site
          Disposition
          Claim_Type
          Date_Issues/ nopercent nocum;
run;

/* 4.Analyzing Data: */
/* Analyze the overall data to answer the business questions:  */
/* How many date issues are in the overall data?  */
/* How many claims per year of Incident_Date are in the overall data?  */
/* Be sure to add appropriate titles. */

/* Use PROC FREQ to analyze the number of date issues in the overall data.  */
/* Use PROC FREQ to analyze the number of claims per year of Incident_Date in the  */
/* overall data. Be sure to format Incident_Date so you are analyzing by year. */
%let statename=Hawaii;
%let outpath=/folders/myfolders/ECRB94/output;
ods pdf file="&outpath/ClaimReport.pdf" style=meadow pdftoc=1;
ods noproctitle;

ods proclabel "Overall Date issues";
title "Overall Date Issues in the Data";
proc freq data=tsa.claims_cleaned;
   table Date_Issues/ missing nocum nopercent;
*treat missing values as valid;
run;
title;
ods graphics on;
ods proclabel "Overall Claims by Year";
title "Overall Claims by Year";
proc freq data=tsa.claims_cleaned;
  table Incident_date/ nocum nopercent plots=freqplot;
  format Incident_date year4.;
  where Date_Issues is null;
run;
title;

/* Analyze the state-level data to answer the business questions:  */
/* What are the frequency value of each Claim_Type, Claim_Site,  */
/* and Disposition for the selected state? What is the mean, min,  */
/* max, and sum of Close_Amount for the selected state, rounded to the  */
/* nearest integer. Be sure to add appropriate titles. */

/* Define a macro variable so you can change the StateName value. Use California as  */
/* the initial value. Use PROC FREQ to analyze the specified columns and PROC MEANS to  */
/* analyze Close_Amount. In both analyses, be sure to subset rows by the specified state  */
/* and exclude any rows with date issues. */
ods proclabel "&StateName Claims Overview";
title "&StateName Claim Types, Claim Sites and Disposition";
proc freq data=tsa.claims_cleaned order=freq;
  table Claim_Type Claim_Site Disposition / nocum nopercent;
  where StateName="&StateName" and Date_Issues is null;
run;
title;

ods proclabel "&StateName Close Amount Statistics";
title "Close Amount for &StateName";
proc means data=tsa.claims_cleaned mean min max sum maxdec=0;
  var Close_Amount;
  where StateName="&StateName" and Date_Issues is null;
run;
title;

/* 5.Exporting Reports: */
/* Export the end results into a single PDF named ClaimReports with the  */
/* style of your choice. */
/* Customize the procedure labels in your report. */
/* Hints: */
/* Use an ODS statement to create a PDF file. */
/* Use an ODS statement to specify procedure labels in your report. */

ods pdf close;









 