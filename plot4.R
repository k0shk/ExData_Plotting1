fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "d.zip", method = "curl")
data <- read.csv(unzip("d.zip"), sep = ";", header = TRUE, na.strings=c("NA","?"))
head(data)
x <- paste (data$Date, data$Time)
f_DateTime <- as.Date(strptime(x, "%d/%m/%Y %H:%M:%S"))
data$Date <- f_date
sub_data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
t <- paste(as.character(sub_data$Date), as.character(sub_data$Time))
sub_dt <- strptime(t, "%Y-%m-%d %H:%M:%S")
sub_data$dt <- sub_dt
f_gap <- as.numeric(levels(sub_data$Global_active_power))[sub_data$Global_active_power]
sub_data$Global_active_power <- f_gap
png(file = "plot4.png", width = 480, height = 480)
par(mfcol=c(2,2))

Sys.setenv("LANGUAGE"="En")
Sys.setlocale(locale = "en_US.UTF-8")

#graph 1
plot(sub_data$dt, sub_data$Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = "")
lines(sub_data$dt, sub_data$Global_active_power)

#graph 2
plot(sub_data$dt, sub_data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(sub_data$dt, as.numeric(sub_data$Sub_metering_1))
lines(sub_data$dt, as.numeric(sub_data$Sub_metering_2), col = "red")
lines(sub_data$dt, as.numeric(sub_data$Sub_metering_3), col = "blue")
legend ("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pt.cex = 1, cex = 0.7, bty = "n")

#graph 3
plot(sub_data$dt, sub_data$Voltage, type = "n", ylab = "Voltage", xlab = "datetime")
lines(sub_data$dt, sub_data$Voltage)

#graph 4
plot(sub_data$dt, sub_data$Global_reactive_power, type = "n", ylab = "Global_reactive_power", xlab = "datetime")
lines(sub_data$dt, sub_data$Global_reactive_power)

dev.off()