/* Add a FORMAT statement in the DATA step to format the following values: */
/* Date: display three-letter month and four-digit year values */
/* Volume: add commas */
/* CloseOpenDiff and HighLowDiff: add dollar signs and include two decimal places. */

/* Add a FORMAT statement in the PROC MEANS step to format  */
/* the values of Date to show only a four-digit year. */

data work.stocks;
    set pg2.stocks;
    CloseOpenDiff=Close-Open;
    HighLowDiff=High-Low;
    *add a FORMAT statement;
    format Date monyy7. Volume comma10.
           CloseOpenDiff HighLowDiff dollar8.2;
run;

proc print data=stocks (obs=5);
    var Stock Date Volume CloseOpenDiff HighLowDiff;
run;

proc means data=stocks maxdec=0 nonobs mean min max;
    class Stock Date;
    var Open; 
    format Date year4.;
    *add a FORMAT statement; 
run;

