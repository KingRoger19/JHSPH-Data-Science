# set working directory
setwd("C:\\Users\\Gabriele\\Documents\\Git\\JHSPH-Data-Science\\Exploratory Data Analysis\\W1 Assessment")

# I have to set English Datetime reading
Sys.setlocale("LC_TIME", "English")

# import xt file with sep = ';' and null values = '?'
dataset <- read.table("household_power_consumption.txt", sep = ';', header = TRUE, na.strings="?")

# create net variable Datetime
dataset$Datetime = as.POSIXct(paste(dataset$Date, dataset$Time), format = "%d/%m/%Y %H:%M:%S")

# subsetting input dataset to get the analysis perimeter
subset <- subset(dataset, Datetime >= "2007-02-01" & Datetime < "2007-02-03")

# open PNG graphic device with 480x480 size
png("plot4.png", width=480, height=480)

# build graph frame
par(mfrow=c(2,2))

# Plotting first graph
plot(subset$Datetime, subset$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Plotting second graph
plot(subset$Datetime, subset$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plotting third graph
plot(subset$Datetime, subset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(subset$Datetime, subset$Sub_metering_2, col="red")
lines(subset$Datetime, subset$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1), bty="n", cex=1) 

# Plotting fourth graph
plot(subset$Datetime, subset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# close PNG graphic device
dev.off()