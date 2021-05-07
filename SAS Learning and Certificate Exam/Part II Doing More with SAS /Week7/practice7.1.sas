***********************************************************;
*  LESSON 7, PRACTICE 1                                   *;
*  a) Highlight the PROC PRINT step and run the selected  *;
*     code. Note that the Tent, RV, and Backcountry       *;
*     columns contain visitor counts.                     *;
*  b) To convert this wide table to a narrow table, the   *;
*     DATA step must create a new column named CampType   *;
*     with the values Tent, RV, and Backcountry, and      *;
*     another new column named CampCount with the numeric *;
*     counts. The DATA step includes statements to output *;
*     a row for CampType='Tent'. Modify the DATA step to  *;
*     output additional rows for RV and Backcountry.      *;
*  c) Add a LENGTH statement to ensure that the values of *;
*     the CampType column are not truncated.              *;
*  d) Run the DATA step. Confirm that each ParkName value *;
*     has three rows corresponding to the Tent, RV, and   *;
*     Backcountry visitor counts.                         *;
***********************************************************;

proc print data=pg2.np_2017camping(obs=10);
run;

data work.camping_narrow(drop=Tent RV Backcountry);
	set pg2.np_2017Camping;
	format CampCount comma12.;
	CampType='Tent';
	CampCount=Tent;
	output;
	CampType='RV';
	CampCount=RV;
	output;
	CampType='Backcountry';
	CampCount=Backcountry;
	output;
run;





