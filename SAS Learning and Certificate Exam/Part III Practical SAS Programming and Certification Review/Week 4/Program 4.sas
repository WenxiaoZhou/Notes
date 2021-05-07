data new;
   putlog "NOTE: Value of Height at the top of the DATA STEP";
   putlog HeightCM=;
   retain HeightCM;
   set sashelp.class(obs=3);
   HeightCM=Height*2.54;
   putlog "NOTE: Value of Height at the bottom of the DATA STEP";
   putlog HeightCM=;
run;
   