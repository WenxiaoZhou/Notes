*create three tables for ocean with different names;
data indian (drop=MaxWindMPH) 
     atlantic(drop=MaxWindKM) 
     pacific;
    set pg2.storm_summary(drop=MinPressure); 
    length Ocean $ 8;
    Basin=upcase(Basin);
    StormLength=EndDate-StartDate;
    MaxWindKM=MaxWindMPH*1.60934;
	if substr(Basin,2,1)="I" then do;
	  Ocean="Indian";
	  output indian;
	end;
	else if substr(Basin,2,1)="A" then do;
	  Ocean="Atlantic";
	  output atlantic;
	  end;
	else do;
	  Ocean="Pacific";
	  output pacific;
	  end;
run;
