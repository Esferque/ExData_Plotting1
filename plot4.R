table <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors=FALSE, dec=".")
head(table)
names(table)
str(table)
# table$Date from character to Date format
table[,1] <- as.Date(table[,1], "%d/%m/%Y")
# Subsetting the data, we only need to work within a 2-days interval! 
subsetTable <- table[table$Date=="2007-02-01" |table$Date=="2007-02-02",]

subsetTable[,7] <- as.numeric(subsetTable[,7])  # Parsing from character to numeric
subsetTable[,8] <- as.numeric(subsetTable[,8])
subsetTable[,9] <- as.numeric(subsetTable[,9])
dateTime <- strptime(paste(subsetTable$Date, subsetTable$Time, sep=" "), "%Y-%m-%d %H:%M:%S")
NsubsetTable <- data.frame(subsetTable, dateTime)


#To save the image into a PGN file, with a width of 480 pixels and a height of 480 pixels
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

plot(NsubsetTable$dateTime, NsubsetTable$Global_active_power, type="l", xlab = " " , ylab = "Global Active Power")

plot(NsubsetTable$dateTime, NsubsetTable$Voltage, type="l", xlab ="datetime", ylab = "Voltage")

plot(NsubsetTable$dateTime, NsubsetTable$Sub_metering_1, type="l", xlab = " " ,ylab = "Energy Submetering", col="black")
lines(NsubsetTable$dateTime, NsubsetTable$Sub_metering_2, type="l", col="red")
lines(NsubsetTable$dateTime, NsubsetTable$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2, col=c("black", "red", "blue"))

plot(NsubsetTable$dateTime, NsubsetTable$Global_reactive_power, type="l", xlab ="datetime", ylab = "Global_reactive_power")

dev.off()
