table <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors=FALSE, dec=".")
head(table)
names(table)
str(table)
# table$Date from character to Date format
table[,1] <- as.Date(table[,1], "%d/%m/%Y")
# Subsetting the data, we only need to work within a 2-days interval! 
subsetTable <- table[table$Date=="2007-02-01" |table$Date=="2007-02-02",]

subsetTable[,3] <- as.numeric(subsetTable[,3])  # Parsing from character to numeric
dateTime <- strptime(paste(subsetTable$Date, subsetTable$Time, sep=" "), "%Y-%m-%d %H:%M:%S")
NsubsetTable <- data.frame(subsetTable, dateTime)

#To save the image into a PGN file, with a width of 480 pixels and a height of 480 pixels
png("plot2.png",width = 480, height = 480)
plot(NsubsetTable$dateTime, NsubsetTable$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)")
dev.off()

