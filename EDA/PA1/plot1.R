#load source to prepare working data
source("workingdata.R")
#get working data
workingData <- getWorkingData()
png(filename = "plot1.png", width = 480, height = 480, units = "px")
with(workingData, {
  hist(Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
})
dev.off()
