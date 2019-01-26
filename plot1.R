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
data1$Global_active_power <- as.numeric(data1$Global_active_power)

# create plot
png(file = "plot1.png", width = 480, height = 480, units = "px")

# add histogram
hist(data1$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", xlim = c(0,6), xaxp=c(0,8,4))

# close device
dev.off()
