###############################################################################
## OPERATING ENVIRONMENT  :Windows XP SP3
## DEVELOPMENT ENVIRONMENT:R version 3.1.2
## AUTHOR:ap0306723
## FILE NAME:plot4.R
###############################################################################


## STEP 0: Load the necessary file
if (!file.exists("data")) { dir.create("data")}

dataSourceURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("data/HouseHoldPowerConsumption.zip") || !file.exists("data/household_power_consumption.txt")){
  download.file (dataSourceURL, destfile ="./data/HouseHoldPowerConsumption.zip", cacheOK = FALSE)
  unzip("./data/HouseHoldPowerConsumption.zip", exdir = "./data")
}


## STEP 1: Load the file
POWER_CONSUMPTION <- read.table("./data/household_power_consumption.txt",  header=T, sep=';',
                                na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')


## STEP 2: Transfer data type
POWER_CONSUMPTION$Date <- as.Date(POWER_CONSUMPTION$Date, format="%d/%m/%Y")


## STEP 3: Extract a subset of data
POWER_CONSUMPTION <- subset(POWER_CONSUMPTION, Date >= "2007-02-01" & Date <= "2007-02-02")


## STEP 4: Transfer data type
DATETIME <- paste(as.Date(POWER_CONSUMPTION$Date), POWER_CONSUMPTION$Time)
POWER_CONSUMPTION$Datetime <- as.POSIXct(DATETIME)


## STEP 5: Tidy dataset
POWER_CONSUMPTION <- POWER_CONSUMPTION[, c(10, 3:9)]


## STEP 6: Create the plot
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(POWER_CONSUMPTION, {plot(Global_active_power~Datetime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
                         plot(Voltage~Datetime, type="l",ylab="Voltage (volt)", xlab="")
                         plot(Sub_metering_1~Datetime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
                         lines(Sub_metering_2~Datetime,col='Red')
                         lines(Sub_metering_3~Datetime,col='Blue')
                         legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
                         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
                         plot(Global_reactive_power~Datetime, type="l",ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.off()

## STEP 7: Deleting the variables
rm(DATETIME)
rm(POWER_CONSUMPTION)
