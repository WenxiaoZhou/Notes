/* The pg1.np_largeparks table contains gross acreage  */
/* for large national parks. Notice that there are exact  */
/* duplicate rows for some parks. Open a new program and  */
/* write a PROC SORT step that creates two tables  */
/* (park_clean and park_dups), and removes the duplicate  */
/* rows. Submit the program and view the output data. */

PROC SORT DATA=PG1.NP_LARGEPARKS 
          OUT=park_clean
          DUPOUT=park_dups
          NODUPRECS;
          BY _ALL_;
RUN;