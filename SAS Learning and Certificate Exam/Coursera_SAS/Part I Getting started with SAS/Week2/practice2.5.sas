/* Open a new program window and write a PROC IMPORT step  */
/* to read the np_traffic.csv file and create the traffic  */
/* SAS table. Add a PROC CONTENTS step to view the descriptor */
/* portion of the newly created table. Submit the program. */
/* Examine the data interactively. Scroll down to row 37.  */
/* Notice that the values for ParkName and TrafficCounter  */
/* seem to be truncated. Modify the program to resolve  */
/* this issue. Submit the program and verify that ParkName  */
/* and TrafficCounter are no longer truncated. */

/*in order to fix the truncation issue add guessingrows*/
PROC IMPORT datafile="/folders/myfolders/EPG194/data/np_traffic.csv" dbms=csv 
            out=traffic replace
            guessingrows=max;
RUN;

PROC CONTENTS data=traffic;
RUN;