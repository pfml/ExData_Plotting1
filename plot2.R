#-------------------------------------------------------------------
# plot2.R global active power vs time of electric popwer consumption
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

png(filename = 'plot2.png', width = 506, height = 506, units = "px")

# Plot graphic

plot(electricPowerDaysCons$timestamp, electricPowerDaysCons$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Save as .png and "that's all folks" message

dev.off()
cat("Plot2.png generated and saved in", getwd())
