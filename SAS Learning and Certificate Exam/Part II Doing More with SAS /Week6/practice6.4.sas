**************************************************;
*  LESSON 6, PRACTICE 4                          *;
**************************************************;

data IncreaseDayVisits;  
    set pg2.np_summary;
    where Reg='NE' and DayVisits<100000;
     IncrDayVisits=DayVisits;
     Year=0;
     do until (IncrDayVisits>100000);
      IncrDayVisits=IncrDayVisits*1.06;
      Year+1;
     *output;
    end;
    output;
    format IncrDayVisits comma12.;
    keep ParkName DayVisits IncrDayVisits Year;
run;

proc sort data=IncreaseDayVisits;
    by ParkName;
run;

title1 'Years Until Northeast National Monuments Exceed 100,000 Visitors';
title2 'Based on Annual Increase of 6%';
proc print data=IncreaseDayVisits label;
    label DayVisits='Current Day Visitors'
          IncrDayVisits='Increased Day Visitors';
run;
title;
