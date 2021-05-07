/* In a new program window, write a LIBNAME 
statement to create a library named NP that reads
np_info.xlsx in the data folder. Be sure to specify the full 
path to your EPG194/data folder and the complete file name. */
/* Run the code. */
/* Navigate to the Libraries panel and open the NP library. */


options validvarname=v7;

libname NP xlsx "/folders/myfolders/EPG194/data/np_info.xlsx";

PROC CONTENTS data=NP.parks;
RUN;

libname NP clear;
