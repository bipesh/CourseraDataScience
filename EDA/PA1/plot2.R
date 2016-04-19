#load source to prepare working data
source("workingdata.R")
#get working data
workingData <- getWorkingData()
png(filename = "plot2.png", width = 480, height = 480, units = "px")
with(workingData, {
  plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
})
dev.off()