library(data.table)
library(lubridate)
data <- as.data.frame(fread("data.txt", header = TRUE, stringsAsFactors = FALSE, na.strings="?", sep=";"))
data <- data[(data$Date=="1/2/2007" | data$Date=="2/2/2007"),]

data$Date <- as.character(dmy(data$Date))
datetime <- strptime(as.character(paste(data$Date, data$Time)), format="%Y-%m-%d %H:%M:%S")
data <- cbind(datetime, data)

png(file="plot3.png")
max <- max(c(max(data$Sub_metering_1), max(data$Sub_metering_2), max(data$Sub_metering_3)))
plot(data$datetime, (data$Sub_metering_1 | data$Sub_metering_2 | data$Sub_metering_3), type="n", ylab="Energy sub metering", xlab = "", ylim=c(0,max))
lines(data$datetime, data$Sub_metering_1, col="black")
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")
legend("topright", lwd=1, col=c("black", "blue", "red"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=.9)
dev.off()