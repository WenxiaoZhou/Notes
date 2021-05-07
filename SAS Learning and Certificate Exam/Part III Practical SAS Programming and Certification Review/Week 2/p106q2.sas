ods noproctitle;
ods pdf file="/folders/myfolders/ECRB94/output/truck.pdf"
     style=journal startpage=no;
title "Truck Summary";
title2 "SASHELP.CARS Table";

proc freq data=sashelp.cars;
	where Type="Truck";
	tables Make / nocum;
run;

proc print data=sashelp.cars;
	where Type="Truck";
	id Make;
	var Model MSRP MPG_City MPG_Highway;
run;
ods pdf close;
