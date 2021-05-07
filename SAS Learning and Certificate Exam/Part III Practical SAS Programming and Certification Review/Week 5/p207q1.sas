/* In the PROC SORT step, remove any rows with duplicate  */
/* values of Region, Subsidiary, and Product. */
/* Add statements to the PROC TRANSPOSE step to transpose  */
/* values of Sales into columns based on the values of  */
/* the Product column. The resulting table should include  */
/* one row for each unique combination of Region and  */
/* Subsidiary. */
/* Drop the _NAME_ and _LABEL_ columns. */

proc sort data=sashelp.shoes 
             out=shoes_sort nodupkey dupout=out;
	by Region Subsidiary Product;
run;

proc transpose data=shoes_sort 
           out=shoes_sales(drop=_name_ _label_);
   var Sales;
   by Region Subsidiary;
   id Product;
run;