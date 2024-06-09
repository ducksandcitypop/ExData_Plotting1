# Read data into data set; convert "?"'s into NA's
# Convert Date entries into date objects

ElectricDataSet <- read.table(file="household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
ElectricDataSet$Date <- as.Date(ElectricDataSet$Date, format = "%d/%m/%Y")

# Subset by date objects; convert times into proper format

ElectricDataSet <- subset(ElectricDataSet, Date == "2007-02-01" | Date == "2007-02-02")
ElectricDataSet$Time <- format(ElectricDataSet$Time, format = "%H:%M:%S")

# Paste Date + Time into datetime
# Convert datetime into POS object

ElectricDataSet$datetime <- paste(ElectricDataSet$Date, ElectricDataSet$Time)
ElectricDataSet$datetime <- as.POSIXct(ElectricDataSet$datetime)
#-----------

# Create Plot1
png(file = "plot1.png")
hist(ElectricDataSet$Global_active_power,
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")
dev.off()

