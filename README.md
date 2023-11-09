# window-functions-mysql

### Overview
- Window functions allow for advanced calculations across sets of rows that are somehow related to the current row.
- Unlike Group By aggregate functions, the number of rows in the output is not reduced.

#### OVER clause is used to create a window
#### PARTITION BY is used to create groups in that window

### Aggregate Window Functions
Calculates aggregate output value across a set of rows while retaining their separate identity <br>
(AVG, MIN, MAX, SUM, and COUNT)

### Analytical Window Functions
  - Ranking Functions - Calculate rank based on the values in a particular order <br> (RANK, DENSE_RANK, ROW_NUMBER)
  - Value Functions - Find value related to the current row <br> (FIRST_VALUE, LAST_VALUE, NTHVALUE, LAG, LEAD)
                        
