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
DateTime <- paste(data$Date, data$Time)
DateTime <- setNames(DateTime, "DateTime")
data <- data[ ,!(names(data) %in% c("Date","Time"))]
data <- cbind(DateTime, data)
data$DateTime <- as.POSIXct(DateTime)

#Plot 3
plot(data$DateTime, data$Sub_metering_1, type = "l", ylab="Global Active Power (kilowatts)", xlab="")
lines(data$Sub_metering_2~data$DateTime, col = "red")
lines(data$Sub_metering_3~data$DateTime, col = "blue")
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()

