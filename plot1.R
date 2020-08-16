

#Downloading and unzipping data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, "data.zip")
unzip("data.zip")
list.files()

#Reading data and formatting
data <- read.table("household_power_consumption.txt", 
                   header=TRUE, sep=";", na.strings = "?", 
                   colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
data <- data[complete.cases(data),]


#Histogram
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)",col = "red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()