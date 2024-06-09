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

#Set up grid for plots

png(file = "plot4.png")
par(mfrow = c(2,2))

# Create plot4

with(ElectricDataSet,{
  
  plot(datetime, Global_active_power,
       type = "l",
       xlab = "",
       xaxt = "n",
       ylab = "Global Active Power")
  axis(side = 1, 
       at = c(min(datetime),
              median(datetime),
              max(datetime)),
       labels = c("Thu", "Fri", "Sat"))
  
  #----------------
  
  plot(datetime, Voltage,
       type = "l",
       xaxt = "n",
       ylab = "Voltage")
  axis(side = 1, 
       at = c(min(datetime),
              median(datetime),
              max(datetime)),
       labels = c("Thu", "Fri", "Sat"))
  
  #-----------------
  
  plot(datetime, 
       Sub_metering_1, 
       type = "s",
       col = "black",
       xlab = "",
       xaxt = "n",
       ylab = "Energy sub metering")
  
  # Sub_metering2
  
  points(datetime, 
         Sub_metering_2, 
         type="s",
         col = "red")
  
  # Sub_metering3
  
  points(datetime, 
         Sub_metering_3, 
         type="s",
         col = "blue")
  
  # Add the ticks/labels
  
  axis(side = 1, 
       at = c(min(datetime),
              median(datetime),
              max(datetime)),
       labels = c("Thu", "Fri", "Sat"))
  
  # Add the legend
  
  legend("topright", 
         col=c("black", "red", "blue"), 
         lty=1, 
         lwd=2, 
         bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  # ----------------
  
  plot(datetime, 
       Global_reactive_power,
       type = "l",
       xaxt = "n")
  
  axis(side = 1, 
       at = c(min(datetime),
              median(datetime),
              max(datetime)),
       labels = c("Thu", "Fri", "Sat"))
  
}
)

dev.off()