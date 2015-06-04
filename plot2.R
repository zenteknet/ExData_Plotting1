## R script to plot Global Active Power from the Electric Power Consumption dataset

# Set working directory
if (!"household_power_consumption.txt"  %in% list.files()) {
        print("You need to set the working directory to the directory the data file: household_power_consumption.txt is in with the setwd() function")
} 
# setwd("~/Dropbox/Coursera/Exploratory Data Analysis/Project1")

# Load packages
library(dplyr)
library(tidyr)
library(lubridate)

# Read in data (make sure the txt file is in your working directory)
household_power_consumption <- read.table("household_power_consumption.txt", sep=";", quote="\"", stringsAsFactors=FALSE, header=TRUE)

# Set to dyplry data frame
household_power_consumption = data.frame(household_power_consumption)
hPC = tbl_df(household_power_consumption)

# Set class of date and time 
# hPC$Date = as.Date(hPC$Date, format = "%d/%m/%Y") 
# hPC$Time = strptime(hPC$Time, format="%H:%M:%S")
hPC = unite(hPC, Date_time, Date, Time, sep=" ")
hPC$Date_time = strptime(hPC$Date_time, "%d/%m/%Y %H:%M:%S")

# Subset by date: 2007-02-01 and 2007-02-02
hPCsubset = with(hPC, subset(hPC, Date_time >= as.POSIXct("2007-02-01") & Date_time < as.POSIXct("2007-02-03")))

# Make Global_active_power column numeric from character class
hPCsubset$Global_active_power = as.numeric(hPCsubset$Global_active_power)

# Open png device & set resolution params
png(filename = "plot2.png",
    width = 480,
    height = 480)

# Plot  Global_active_power vs Date
plot2 = plot(hPCsubset$Date_time, hPCsubset$Global_active_power, 
        type = "l",
        ylab = "Global Active Power (kilowatts)", 
        xlab = "Day",
        main = ""
)

dev.off()       # close png device

#EOF

        

