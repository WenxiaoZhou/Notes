PROC FREQ data=pg1.np_summary;
     TABLES Reg Type;
RUN;

PROC UNIVARIATE data=pg1.np_summary;
     Var Acres;
RUN;