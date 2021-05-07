/* In a new program window, write a PROC CONTENTS step to generate  */
/* a report of the storm_summary.sas7bdat table. Be sure to specify  */
/* the path to your EPG194/data folder and the full name of the table. */
/* 注意：在调用数据时，SAS要求文件在服务器文件和文件夹中，data后面的引用路径可以通过点开 */
/* 数据文件的指引来确定。如果是library里的数据直接由目标文件夹.数据文件名的形式引用即可。 */

PROC CONTENTS data="/folders/myfolders/EPG194/data/storm_summary.sas7bdat";
RUN;

PROC PRINT data="/folders/myfolders/EPG194/data/storm_summary.sas7bdat";
RUN;