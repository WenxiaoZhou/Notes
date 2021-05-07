/*using a library to read the excel tables*/
/*class_birthdate is name of the one excel sheet in the file*/

options validvarname=v7;
libname xlclass xlsx "/folders/myfolders/EPG194/data/class.xlsx";

proc contents data=xlclass.class_birthdate;
run;

libname xlclass clear;