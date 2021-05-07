/* Create custom formats for the values of Status  */
/* (M, S, and O) and for ranges of Salary. */
/* Apply the custom formats in the PROC FREQ step. */
proc format;
	value $statfmt S="Single"
	              M="Married"
	              O="Other";
	value salrange low-<50000="Under $50K"
	               50000-100000="50K-100K"
	               100000<-high="Over 100K";
run;

proc freq data=cr.employee;
	tables Status;
	tables City*Salary / nopercent nocol;
	format Status $statfmt. Salary salrange.;
run;