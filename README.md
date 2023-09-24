# SQL_case_Study

# SQL Project: Analysis

## Overview

This SQL project focuses on analyzing financial data related to credit card transactions. The dataset is stored in an SQLite database named `sql_task_credit_cards.sqlite`. The analysis encompasses various aspects such as total expense analysis, card type analysis, data cleaning and validation, and expense type analysis.

## Files

- `sql_task_credit_cards.sqlite`: SQLite database containing the credit card transaction data.
- `queries.sql`: SQL queries for the different analyses.

## Queries

### General Task queries
-Total amount spent by everyone.
-Highest total expenditure.
-Lowest total expenditure.
-Highest average expenditure
-Lowest average expenditure.
-For which expense was the platinum card used most.

### Total Expense Analysis

1. **Total Expenditure based on card type, city,year,month and year:**
   - Provides the total expenditure for each card type,city,month and year and each year.
     
2. **Total Expenditure by Card type and gender:**
   - Provides the total expenditure for each gender via each card.
  
2. **Total Expenditure by expense type and year:**
   - Provides the total expenditure for each expense type each year.

4. **Monthly Expenditure Trend by expense type:**
   - Displays the trend of monthly total expenditure on each expense type.
  
5. **TOP 3 City expense trend**
   - Which 3 cities spend the most each year.


### Expense Type Analysis

1. **Total Expenditure by Expense Type:**
    - Provides the total expenditure for each expense type.

2. **Expense Type Distribution by Gender:**
    - Analyzes the distribution of expense types by gender.

3. **Average Expenditure in each Expense Types:**
    - Average expenditure trend on ecah expense type.
  

  ### Card Type Analysis

1. **Count of each card type used in each city:**
   - Shows the total number of particular card type used in each city.

2. **Count of each card type used by each gender:**
   - Shows the total number of particular card type used in gender.
     
3. **Count of each card type used for each expense type :**
   - Shows the type of expense, type of cards and number of cards.
  
   
### Data Cleaning and Validation

1. **Check for Missing Values:**
   - Identifies rows with missing values in specific columns.

2. **Check for Duplicate Entries:**
   - Identifies and removes duplicate entries based on all columns.

3. **Amount Validation:**
   - Identifies rows with negative or invalid amounts.

4. **Gender Validation:**
   - Filters rows with invalid gender values.

## Conclusion

This SQL project involves a thorough analysis of credit card transaction data, focusing on different aspects of expenditure and expense types. The queries provided enable a deeper understanding of spending patterns and aid in making informed financial decisions. Further analysis and visualization can be performed to derive more detailed insights from the dataset.
