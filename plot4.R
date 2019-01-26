library(dplyr)

# set working directory
setwd("C:/Users/deven.choi/Documents/coursera/exploratory_data_analysis/week1")

# download and unzip file
file_name <- "exdata_data_household_power_consumption.zip"

if (!file.exists(file_name)){
    URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(URL, file_name, method="curl")
}  

if (!file.exists("exdata_data_household_power_consumption")) { 
    unzip(file_name) 
}

# read txt file into table
data <- read.table("C:/Users/deven.choi/Documents/coursera/exploratory_data_analysis/week1/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?")

# subset only 2/1/07 - 2/2/07
data1 <- data[which(data$Date == "2/1/2007" | data$Date ==  "2/2/2007"),]

# change a few column classes
data1$Date <- as.Date(data1$Date, format = "%d/%m/%Y")
data1$combined_date <- as.POSIXct(strptime(paste(data1$Date, data1$Time, sep = " "), format = "%Y-%d-%m %H:%M:%S"))

# create plot
png(file = "plot4.png", width = 480, height = 480, units = "px")

# set global parameters
par(mfrow = c(2, 2))

# graph 1
with(data1, plot(combined_date, Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power", ylim = c(0,6), yaxp = c(0,6,3)))

# graph 2
with(data1, plot(combined_date, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

# graph 3
with(data1, plot(combined_date, Sub_metering_1, type = "l", xlab = " ", ylab = "Energy Sub Metering", col = "black", ylim = c(0, 30), yaxp = c(0,30,3)))
with(data1, points(combined_date, Sub_metering_2, type = "l", col = "red"))
with(data1, points(combined_date, Sub_metering_3, type = "l", col = "blue"))
legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)

# graph 4
with(data1, plot(combined_date, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

# close device
dev.off()
