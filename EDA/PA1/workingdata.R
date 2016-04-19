getWorkingData <- function() {
  
  zipFile <- "household_power_consumption.zip"
  zipFileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  workingDataFile <- "working_data.csv"
  
  if(file.exists(workingDataFile)) {
    workingData <- read.csv(workingDataFile)
    workingData$DateTime <- strptime(workingData$DateTime, "%Y-%m-%d %H:%M:%S")
    workingData
  } else {
    if(!file.exists(zipFile)) {
      download.file(zipFileURL,destfile=zipFile,method="curl")
      txtFile <- unz(zipFile, "household_power_consumption.txt")
      workingData <- read.table(txtFile, header=T, sep=';', na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
    }
    workingData <- workingData[(workingData$Date == "1/2/2007") | (workingData$Date == "2/2/2007"),]
    workingData$DateTime <- strptime(paste(workingData$Date, workingData$Time), "%d/%m/%Y %H:%M:%S")
    write.csv(workingData, workingDataFile)
    workingData
  }
}