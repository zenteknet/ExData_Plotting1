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

# Convert character data to numeric in numeric columns
hPCsubset[ , 2:8] = as.numeric(unlist(hPCsubset[ , 2:8]))

# Open png device & set resolution params
png(filename = "plot4.png",
    width = 480,
    height = 480)

# Plot 4 charts simultaneously
par(mfrow = c(2, 2))

# Plot  Global_active_power vs Day
plot1 = plot(hPCsubset$Date_time, hPCsubset$Global_active_power, 
             type = "l",
             ylab = "Global Active Power (kilowatts)", 
             xlab = "Day",
             main = ""
)

# Plot  Voltage vs Date
plot2 = plot(hPCsubset$Date_time, hPCsubset$Voltage, 
             type = "l",
             ylab = "Voltage", 
             xlab = "Day",
             main = ""
)

# Plot Sub-metering vs Day
plot3 = plot(hPCsubset$Date_time, hPCsubset$Sub_metering_1, 
        type = "l",
        xlab = "Day",
        ylab = "Sub-metering"
)
plot3 = lines(hPCsubset$Date_time, hPCsubset$Sub_metering_2, col = "red")
plot3 = lines(hPCsubset$Date_time, hPCsubset$Sub_metering_3, col = "blue")

plot3 = legend("topright",
               c("Sub-metering 1", "Sub-metering 2", "Sub-metering 3"),
               lty = c(1,1,1),
               col = c("black", "red", "blue"),
               pt.cex = .1,
               cex = .7
)


# Plot  Global_reactive_power vs Date
plot4 = plot(hPCsubset$Date_time, hPCsubset$Global_reactive_power, 
             type = "l",
             ylab = "Global Reactive Power (kilowatts)", 
             xlab = "Day",
             main = ""
)


dev.off()       # close png device

#EOF

        

