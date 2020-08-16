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

#Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
        plot(Global_active_power~DateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~DateTime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~DateTime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~DateTime,col='Red')
        lines(Sub_metering_3~DateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~DateTime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()

