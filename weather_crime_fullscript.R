library(tidyverse)
mydata <- read_csv("BFI.csv")

# only keeping relevant variables 
mydata <- select(mydata, station:tmpf)

#new var creation
mydata <- mydata |>
  mutate(date = as.Date(substr(valid,1,10), format = "%Y - %m - %d"))

mydata <- select(mydata, station, tmpf, date)

summary(mydata)

mydata <- mydata |>
  mutate(month = (substr(date,6,7)))

# dropping missing temperatures
mydata <- na.omit(mydata)

#avg monthly temps
#monthtemp <- mydata |>
  #group_by(month) |>
  #summarize(mean_tmpf = mean(tmpf))

#removing columns 
mydata <- mydata[-c(1,4)]

#collapsing temp by month
mydata <- mydata |>
  mutate(month = format(date, "%m"), year = format(date, "%Y"))


tmpf_monthly <- mydata |>
  group_by(month,year) |>
  summarize(mean_tmpf = mean(tmpf, na.rm = TRUE))

#bringing in crime dataset
crimedata <- read_csv("SPD_Crime.csv")
view(head(crimedata,100))

#fixing dates

crimedata <- crimedata |>
  mutate(date1 = as.Date(substr(`Report DateTime`, 1, 10), format = "%m - %d - %y"))

crimedata <- crimedata |>
  mutate(month = format(date1, "%m"), year = format(date1, "%Y"))


tmpf_monthly <- mydata |>
  group_by(month,year) |>
  summarize(mean_tmpf = mean(tmpf, na.rm = TRUE))













