fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "d.zip", method = "curl")
data <- read.csv(unzip("d.zip"), sep = ";", header = TRUE)
head(data)

Sys.setenv("LANGUAGE"="En")
Sys.setlocale(locale = "en_US.UTF-8")

f_date <- as.Date(data$Date, "%d/%m/%Y")
data$Date <- f_date
sub_data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
png(file = "plot1.png", width = 480, height = 480)
hist(as.numeric(levels(sub_data$Global_active_power))[sub_data$Global_active_power], col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()