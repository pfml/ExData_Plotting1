#-------------------------------------------------------------------
# plot3.R Energy sub metering vs time of electric popwer consumption
# pfml 20141012 - Coursea exploratory Data Analysis
#-------------------------------------------------------------------

# Load, unzip, and read data
if(!file.exists("exdata-data-household_power_consumption.zip")) {
        zipFile <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",zipFile)
        unZipFile <- unzip(zipFile)
        unlink(zipFile)
}
electricPowerGlobalCons <- read.table(unZipFile, header=TRUE, sep=";", na.strings = "?")
unlink(unZipFile)
# Subset data for 2007-02-01 and 2007-02-02

electricPowerGlobalCons$Date <- as.Date(as.character(electricPowerGlobalCons$Date), "%d/%m/%Y")
electricPowerDaysCons <- electricPowerGlobalCons[(electricPowerGlobalCons$Date=="2007-02-01") | (electricPowerGlobalCons$Date=="2007-02-02"),]
rm(electricPowerGlobalCons)

# Create timestamp data

electricPowerDaysCons <- transform(electricPowerDaysCons, timestamp=as.POSIXct(paste(Date, Time)))

# open graphics device

png(filename = 'plot4.png', width = 506, height = 506, units = "px")

# create matrix for 2 x 2 graphs
        
par(mfrow=c(2,2))

# Plot graphic 1

plot(electricPowerDaysCons$timestamp,electricPowerDaysCons$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Plot graphic 2

plot(electricPowerDaysCons$timestamp,electricPowerDaysCons$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot graphic 3

plot(electricPowerDaysCons$timestamp,electricPowerDaysCons$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(electricPowerDaysCons$timestamp,electricPowerDaysCons$Sub_metering_2,col="red")
lines(electricPowerDaysCons$timestamp,electricPowerDaysCons$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=0.9)

# Plot graphic 4

plot(electricPowerDaysCons$timestamp,electricPowerDaysCons$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# Save as .png and "that's all folks" message

dev.off()
cat("Plot4.png generated and saved in", getwd())