## Read Me

This project generates poverty thresholds using Census Bureau Guidelines. Original Census files can be found [here](https://www.census.gov/data/tables/time-series/demo/income-poverty/historical-poverty-thresholds.html). I used the files for thresholds by Size of Family and Number of Childrens only.

__What this project contains:__ 
- yearly(from 1980 to 2016) poverty thresholds by family size and number of childrens in stata format
- an appended stata dataset of poverty thresholds from 1980 to 2016 
- `povertyGenerator.do` : this can be modified to incorporate more years, this file reads raw `excel` files provided by Census and creates the yearly and aggregate thresholds. 

__How these stata files can be used:__ 

- poverty thresholds can be merged with any existing data using , `year` `hiuNumber`(family/household size) `chilNum`(No of children) `under65age` and `under65head` (see below for description) . 

__Variable Description:__ 
-`chilNum` : no of children in household or family
- `povThres`: income level where the family is assumed to be at 100% poverty, this allows for scaling to higher and lower values of poverty levels. 
- `hiuNumber`: household or family size 
- `under65age`: 1 if the household size is 1 and the occupant is under 65 years of age
- `under65head`: 1 if the household size is 2 and the head of the household is under 65 years of age

**PS:** There is another measure of poverty, defined by [ASPE-HHS](https://aspe.hhs.gov/poverty-guidelines) which are used for most means tested programs such as social-security, food-stamp etc. These poverty thresholds constructed here are mostly used for reporting national poverty levels.

For any questions, comments or concerns, [@ougnic](https://twitter.com/ougnic) 
