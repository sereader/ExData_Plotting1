library(data.table)
library(lubridate)
data <- as.data.frame(fread("data.txt", header = TRUE, stringsAsFactors = FALSE, na.strings="?", sep=";"))
data <- data[(data$Date=="1/2/2007" | data$Date=="2/2/2007"),]

data$Date <- as.character(dmy(data$Date))
datetime <- strptime(as.character(paste(data$Date, data$Time)), format="%Y-%m-%d %H:%M:%S")
data <- cbind(datetime, data)

png(file="plot1.png")
hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()