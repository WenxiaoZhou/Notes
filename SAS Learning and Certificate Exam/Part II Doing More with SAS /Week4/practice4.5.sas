***************************************************;
*  Creating Custom Formats from Tables            *;
***************************************************;
*  Syntax                                         *;
*                                                 *;
*    CNTLIN table must include:                   *;
*        FmtName: name of format                  *;
*        Start: values to format                  *;
*        Label: labels to apply                   *;
*                                                 *;
*    PROC FORMAT CNTLIN=input-table FMTLIB;       *;
*       SELECT format-names;                      *;
*    RUN;                                         *;
***************************************************;

*********************************************************************;
*  Demo                                                             *;
*    1) Examine the DATA step that creates the SBDATA table from    *;
*       the PG2.STORM_SUBBASINCODES table and the PROC FORMAT step  *;
*       that imports the SBDATA table. Highlight the demo program   *;
*       and run the selected code. Verify that the new table        *;
*       contains three required columns to build a format. View the *;
*       log and confirm the $SBFMT format was created.              *;
*    2) Open the PG2.STORM_CATEGORIES table. This table defines a   *;
*       range of maximum wind speeds (Low and High) and assigns a   *;
*       storm Category.                                             *;
*    3) Modify the second DATA and PROC FORMAT steps to create a    *;
*       table named CATDATA that will include the following         *;
*       columns. Highlight the DATA and PROC FORMAT steps and run   *;
*       the selected code. View the log and confirm the CATFMT      *;
*       format was created.                                         *;
*           Column in PG2.STORM_CATEGORIES => Column in CATDATA     *;
*               <none> => FmtName (assign CATFMT for each row       *;
*               Low => Start                                        *;
*               High => End                                         *;
*               Category => Label                                   *;
*    4) Add a FORMAT statement in the PROC FREQ step to format      *;
*       Sub_basin with the $SBFMT. format and Wind with the CATFMT. *;
*       format. Highlight the TITLE statements and PROC FREQ step   *;
*       and run the selected code.                                  *;
*********************************************************************;

/*Create the $SBFMT format for subbasin codes*/
/* First step is to create a temporary table, also notice */
/* that in order to create a custom format table, needs to */
/* have the three required columns: FmtName start label */
/* rename three columns; */
data sbdata;
    retain FmtName '$sbfmt';
    set pg2.storm_subbasincodes(rename=(Sub_Basin=Start 
                                        SubBasin_Name=Label));
    keep Start Label FmtName;
run;

proc format cntlin=sbdata;
run;

*Create a format based on the range;
/* Retain statement to create a column,numeric column doesn't */
/* need $ sign */
data catdata;
    retain FmtName "catfmt";
    set pg2.storm_categories(rename=(low=Start High=End Category=label)) ;
    keep FmtName Start End Label;
run;

proc format cntlin=catdata;
run;

title "Frequency of Wind Measurements for Storm Categories by SubBasin";
title2 "2016 Storms";
proc freq data=pg2.storm_detail;
    /*include only Category 1-5 2016 storms with known subbasin*/
	where Wind>=64 and Season=2016 and Sub_basin not in('MM', 'NA');
	tables Sub_basin*Wind / nocol norow nopercent;
	*Add a FORMAT statement;
	format Sub_basin $sbfmt. Wind catfmt.;
run;
title;






