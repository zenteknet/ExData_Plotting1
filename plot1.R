## R script to plot Global Active Power from the Electric Power Consumption dataset

# Set working directory
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
png(filename = "plot1.png",
    width = 480,
    height = 480)

# Plot histogram of Global_active_power
plot1 = hist(hPCsubset$Global_active_power, 
        col = "red", 
        xlab = "Global Active Power (kilowatts)", 
        ylab = "Frequency",
        main = "Global Active Power")

dev.off()       # close png device

#EOF

        

