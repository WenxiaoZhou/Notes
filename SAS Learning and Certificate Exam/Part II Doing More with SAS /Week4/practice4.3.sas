***************************************************;
*  Creating and Using Custom Formats              *;
***************************************************;
*  Syntax                                         *;
*                                                 *;
*    PROC FORMAT;                                 *;
*      VALUE format-name                          *;
*            value-or-range-1='formatted-value'   *;
*            value-or-range-2='formatted-value'   *;
*            ... ;                                *;
*    RUN;                                         *;
***************************************************;

proc format;
    value $genfmt 'F'='Female'
                  'M'='Male'
                  other='Miscoded';
    value hrange low-<58  = 'Below Average'
                 58-60    = 'Average'
                 60<-high = 'Above Average';
run;

proc print data=pg2.class_birthdate noobs;
    where Age=12;
    var Name Gender Height;
    format Gender $genfmt. Height hrange.;
run;

***********************************************************;
*  Demo                                                   *;
*  1) Notice the syntax for creating the STDATE format in *;
*     the PROC FORMAT step.                               *;
*  2) Add a VALUE statement to the PROC FORMAT step to    *;
*     create the $REGION format with the following        *;
*     labels:                                             *;
*         NA => Atlantic                                  *;
*         WP, EP, SP => Pacific                           *;
*         NI, SI => Indian                                *;
*         blank => Missing                                *;
*         other => Unknown                                *;
*  3) Highlight the PROC FORMAT step and run the selected *;
*     code. Verify in the SAS log that the formats have   *;
*     been output.                                        *;
*  4) Add a FORMAT statement in the PROC FREQ step to     *;
*     format Basin with the $REGION format and StartDate  *;
*     with the STDATE format. Highlight PROC FREQ step    *;
*     and run the selected code.                          *;
***********************************************************;

proc format;
    *numeric format stdate;
    value stdate low - '31DEC1999'd = '1999 and before'
                 '01JAN2000'd - '31DEC2009'd = '2000 to 2009'
                 '01JAN2010'd - high = '2010 and later'
                 . = 'Not Supplied';
    *custom character format region;
    value $region 'NA'='Alantic'
                  'WP','EP','SP'='Pacific'
                  'NI','SI'='Indian'
                  ' '='Missing'
                  other='Unknow';
run;

proc freq data=pg2.storm_summary;
    tables Basin*StartDate / norow nocol;
    format StartDate stdate. Basin $region.;
run;
