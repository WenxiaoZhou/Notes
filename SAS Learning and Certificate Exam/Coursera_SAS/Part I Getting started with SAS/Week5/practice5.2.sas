/* Open a new program window and write a DATA step to read  */
/* the pg1.np_species table and create a new table named fox */
/* as a permanent table in the EPG194/output folder. Include */
/* only the rows where Category is Mammal and Common_Names  */
/* includes Fox. Exclude the Category, Record_Status,  */
/* Occurrence, and Nativeness columns from the output data. */
/* Submit the program. Notice that Fox Squirrels are  */
/* included in the output table. Add a condition in the  */
/* WHERE statement to exclude rows that include Squirrel. */
/* Submit the program and verify the results.Sort the fox  */
/* table by Common_Names. */

DATA fox;
  SET pg1.np_species;
  WHERE Category="Mammal" and Common_Names like "%Fox%"
     AND COMMON_Names NOT like "%Squirrels%";
  DROP Category Record_Status Occurrence Nativeness;
RUN;

PROC SORT DATA=fox;
   by Common_Names;
RUN;