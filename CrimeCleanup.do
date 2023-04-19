cd "G:\My Drive\Coding\StataProjects\WeatherCrime"

import delimited "SPD_Crime_Data__2008-Present.csv"

sort offensestartdatetime
//creating dates and encoding from str to int
gen newdate = substr(reportdatetime, 1,10)
gen newtime = substr(reportdatetime, 12, 22)
gen date_var = date(newdate, "MDY")
format date_var %td

//cleanup crimes and create violent/property categories 
keep if crimeagainstcategory == "PROPERTY" | crimeagainstcategory == "PERSON"

tab offense if crimeagainstcategory == "PERSON"

encode offense, gen(offense1)

gen violentcrime = 0
replace violentcrime = 1 if inlist(offense1, 1, 13, 20, 21, 23, 27, 28, 29, 31, 32)

gen propertycrime = 0 
replace propertycrime = 1 if crimeagainstcategory == "PROPERTY"
replace propertycrime = 0 if offense1 == 28 

total violentcrime propertycrime
//counts for each day 
collapse (sum) propertycrime violentcrime, by(date_var)

total violentcrime propertycrime
//merge and export
merge 1:1 date_var using "temp_averages.dta"
drop if _merge==2
save "crime_temp_merge.dta", replace
export excel "crime_temp", firstrow(variables) replace

clear all
