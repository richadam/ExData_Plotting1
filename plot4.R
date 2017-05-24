# load required packages
packages <- c("ggplot2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

inpath <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
outpath <- "household_power_consumption.zip"
datafile <- "household_power_consumption.txt"

# download and unzip	
if(!file.exists(dirname(outpath)))
	dir.create(dirname(outpath))
if(!file.exists(outpath))
	download.file(inpath, destfile = outpath)

unzip(zipfile = outpath)

# Read the Global_active_power data and plot the frequency to a png
data <- read.table(datafile, header = TRUE, sep=";", stringsAsFactors= FALSE)

data <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")
esm1 <- as.numeric(data$Sub_metering_1)
esm2 <- as.numeric(data$Sub_metering_2)
esm3 <- as.numeric(data$Sub_metering_3)
voltage <- as.numeric(data$Voltage)
grp <- as.numeric(data$Global_reactive_power)
gap <- as.numeric(data$Global_active_power)
datetime <- strptime(paste(data$Date, data$Time, sep = " "), "%d/%m/%Y %H:%M:%OS")
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

plot(datetime, gap, type = "l", xlab = "", ylab="Global Active Power", cex = 0.2)

plot(datetime, voltage, type = "l", xlab = "datetime", ylab="Voltage")

plot(datetime, esm1, type = "l", xlab = "", ylab="Energy sub metering")
lines(datetime, esm2, type = "l", col="red")
lines(datetime, esm3, type = "l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

plot(datetime, grp, type = "l", xlab = "datetime", ylab="Global_reactive_power")

dev.off()
