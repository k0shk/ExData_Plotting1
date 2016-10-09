fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "d.zip", method = "curl")
data <- read.csv(unzip("d.zip"), sep = ";", header = TRUE)
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
png(file = "plot2.png", width = 480, height = 480)
plot(sub_data$dt, sub_data$Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = "")
lines(sub_data$dt, sub_data$Global_active_power)
dev.off()