// purpose: process rawthresholds from census automatically
// change the start and end year to be 2018 _ ben 8/21/2020
// modified by Dong to change the start 2020 and end 2021 9/23/2022.
// modified by Dong to change the start 2021 and end 2022 9/23/2023
// modified by Dong to change the start 2022 and end 2023 9/18/2024.
// modified by Dong to change the start 2023 and end 2024 6/26/2025.
clear
set more off


local startyear = 2024
local endyear = 2024

forvalues i = `startyear'/`endyear' {
clear
local l2 = substr("`i'",3,.)
di `l2'
import excel "C:\Users\dd1774\Documents\GitHub\povertyThresholds_census\data\raw\thresh`l2'", sheet("Sheet1")
rename  *, lower 

ge float year=`i'

drop b 
keep a-k
destring a-k , replace

drop in 1/10

drop in 3/4 
drop in 5
drop in 12 
keep in 1/11

ge float hiuNumber = 9 
replace hiuNumber = 8 in 10 
replace hiuNumber = 7 in 9
replace hiuNumber = 6 in 8 
replace hiuNumber = 5 in 7 
replace hiuNumber = 4 in 6
replace hiuNumber = 3 in 5 
replace hiuNumber = 2 in 3/4 
replace hiuNumber = 1 in 1/2 

ge float under65age =.
replace under65age =1 in 1
replace under65age =0 in 2 

ge float under65head =.
replace under65head=1 in 3
replace under65head=0 in 4

rename c chx0 
rename d chx1 
rename e chx2 
rename f chx3 
rename g chx4
rename h chx5 
rename i chx6
rename j chx7
rename k chx8

drop a 
ge index = _n 

reshape long chx ,  i(index)  j(chilNum) 
rename chx povThres 
desc povThres

destring povThres , replace
drop if povThres ==.

drop index

recast float chilNum
ge year=`i'

desc
save "C:\Users\dd1774\Documents\GitHub\povertyThresholds_census\data\stata_yearly\povThres`i'", replace
}

// append them into one file 

*use "data/stata_yearly/povThres`startyear'", clear

*forvalues k = `startyear'/`endyear'{
*append using "data/stata_yearly/povThres`k'" 
*}

*save "data/povThres_census_`startyear'_`endyear'", replace
