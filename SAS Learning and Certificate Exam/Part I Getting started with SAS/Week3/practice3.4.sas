/* Open a new program window and write a PROC FREQ step  */
/* to analyze rows from pg1.np_species. Generate frequency */
/* tables for Abundance and Conservation_Status. In the  */
/* PROC FREQ output, include only rows where Species_ID  */
/* starts with YOSE (Yosemite National Park) and Category  */
/* equals Mammal.Write a PROC PRINT step to list the same  */
/* subset of rows from pg1.np_species. Include Species_ID, */
/* Category, Scientific_Name, and Common_Names in the  */
/* report. Run the program. */

%let Species=YOSE%;
%let Category=Mammal;

PROC FREQ data=pg1.np_species;
	tables Abundance Conservation_Status;
	WHERE Species_ID like"&Species" and Category="&Category";
RUN;

PROC PRINT data=pg1.np_species;
	VAR Species_ID Category Scientific_Name Common_Names;
	WHERE Species_ID like"&Species" and Category="&Category";
RUN;

%let Parkcode=ZION%;
%let SpeciesCat=Bird;

PROC FREQ data=pg1.np_species;
	tables Abundance Conservation_Status;
	WHERE Species_ID like"&Parkcode" and Category="&SpeciesCat";
RUN;

PROC PRINT data=pg1.np_species;
	VAR Species_ID Category Scientific_Name Common_Names;
	WHERE Species_ID like"&Parkcode" and Category="&SpeciesCat";
RUN;