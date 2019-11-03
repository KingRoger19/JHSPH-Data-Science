# set working directory
setwd("C:\\Users\\Gabriele\\Documents\\Git\\JHSPH-Data-Science\\Exploratory Data Analysis\\W1 Assessment")

# import xt file with sep = ';' and null values = '?'
dataset <- read.table("household_power_consumption.txt", sep = ';', header = TRUE, na.strings="?")

# convert char Data into R date
dataset$Date = as.Date(dataset$Date, format = "%d/%m/%Y")

# subsetting input dataset to get the analysis perimeter
subset <- subset(dataset, Date >= "2007-02-01" & Date <= "2007-02-02")

# open PNG graphic device with 480x480 size
png("plot1.png", width=480, height=480)

# plot the required graph
hist(subset$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = 'red')

# close PNG graphic device
dev.off()

