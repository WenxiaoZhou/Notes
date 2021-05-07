proc sort data=sashelp.baseball out=baseball_sort;
  by Team Name;
run;
title "Baseball Team Statistics";
proc print data=baseball_sort label;
	by Team;
	var Position YrMajor nAtBat nHits nHome;
	sum nAtBat nHits nHome;
	id Name;
*check for the original dataset, sashelp.baseball
*table already has the labels for variables;
	*label Name="Player's Name"
	      Position="Position(s) in 1986"
	      YrMajor="Years in the Major Leagues"
	      nAtBat="Times at Bat in 1986"
	      nHits="Hits in 1986"
	      nHome="Home Runs in 1986";
run;

