# DATA-CLEANING and EXPLORATION -WITH-SQL

## Overview
This repository contains a comprehensive tutorial and guide on how to clean a real-world dataset using MySQL, focusing on data related to global layoffs. The project demonstrates how to identify and resolve common data issues such as duplicates, null values, inconsistencies, and formatting errors, to ensure that the dataset is clean, reliable, and ready for analysis.

The goal is to showcase a robust data cleaning process that prepares the data for the next step—Exploratory Data Analysis (EDA).

## Key Features
Database Creation & Data Import:
The project begins by setting up a new schema and importing a raw dataset on global layoffs. No changes are made during the import phase, ensuring the raw data is preserved for later analysis.

### Data Cleaning Techniques:

#### Removing Duplicates:
Duplicate rows are identified and removed using SQL’s row_number() function, ensuring each record is unique.
#### Standardizing Inconsistent Data:
Corrected inconsistent values such as "cryptocurrency" vs. "crypto" and removed unnecessary spaces, making the data uniform and ready for analysis.
#### Handling Null Values:
Missing values in key fields like "Industry" and "Country" were either filled based on matching entries or managed with appropriate SQL techniques. The project also addresses null and blank values in the “Total Laid Off” and “Percentage Laid Off” columns.
#### Formatting Date Columns:
Used the STR_TO_DATE() function to convert text-based dates into the correct date format for accurate time series analysis.

### Best Practices:
* All data cleaning is performed on a staging table to preserve the integrity of the raw data.
* The project follows a structured cleaning process that ensures data consistency and reliability for future use.

 https://github.com/DS-Rahul95/DATA-CLEANING-WITH-SQL.git
