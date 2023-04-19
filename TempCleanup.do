cd "G:\My Drive\Coding\StataProjects\WeatherCrime"

import delimited "BFI.csv"

keep v1-v3
drop if _n == 1

//create new date var
gen date = substr(v2, 1,10)
gen newdate = date(date, "YMD")
format newdate %td

//format temp
gen temp = v3
drop if temp == "M"
drop v1-date
destring temp, replace
//generate daily averages for each day 
collapse (mean)temp, by(newdate)

rename newdate date_var

save "temp_averages.dta"
export excel using "temp_averages", replace
