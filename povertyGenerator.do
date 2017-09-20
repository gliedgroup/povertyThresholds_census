// purpose: process rawthresholds from census automatically

clear
set more off

global raw "D:\Google Drive\ougniProjects\skunkWorks\povertyThresholds_census\data\raw"
global out "D:\Google Drive\ougniProjects\skunkWorks\povertyThresholds_census\data\stata_yearly"
global final "D:\Google Drive\ougniProjects\skunkWorks\povertyThresholds_census"
local povdata "D:\Google Drive\ougniProjects\povertyThresholds\data"

cd "$raw"


forvalues i =1980/2016 {
clear
local l2 = substr("`i'",3,.)
di `l2'
import excel thresh`l2'
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

ge float under65head =.
replace under65head=1 in 3

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
save "$out\povThres`i'", replace
}

// append them into one file 

use "$out\povThres1980"

forvalues k = 1981/2016{
append using "$out\povThres`k'" 
}

save "$final\povThres_census_1980_2016", replace
