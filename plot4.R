# Download and unzip the data into the working directory.  This can be commented out after run once for efficiency.
message("Downloading and unpackaging data ...")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
unzip("household_power_consumption.zip")

# Read all the data in.  I know ... it's a lot.
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

# Subset the data to just 2007-02-01 and 2007-02-02.
data <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]

# Convert Date from factor to date.
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
# Create a new date/time column.
data$DateTime <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Draw the plot in a window.
par(mfrow = c(2,2))
plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(data$DateTime, data$Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")
points(data$DateTime, data$Sub_metering_2, col="red", type="l")
points(data$DateTime, data$Sub_metering_3, col="blue", type="l")
legend("topright", bty="n", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datatime", ylab="Global_reactive_power")

# Draw the plot to PNG file.  Doing this rather than dev.copy so that the legend doesn't get cropped.
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))
plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(data$DateTime, data$Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")
points(data$DateTime, data$Sub_metering_2, col="red", type="l")
points(data$DateTime, data$Sub_metering_3, col="blue", type="l")
legend("topright", bty="n", lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datatime", ylab="Global_reactive_power")
dev.off()