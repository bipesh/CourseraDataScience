#getworkingdata.R
#this source file loads data and required libraries

#ggplog2 library
library(ggplot2)

datafile <- "./data/exdata_data_NEI_data.zip"
datafileurl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
datafileurl <- "./data/exdata%2Fdata%2FNEI_data.zip"
NEIfilename <- "./data/summarySCC_PM25.rds"
SCCfilename <- "./data/Source_Classification_Code.rds"

getNEI <- function() {
  if(!file.exists(NEIfilename)) {
   getWorkingData()
  }
  if(!exists("NEI")){
    NEI <- readRDS(NEIfilename)
  }
  NEI
}

getSCC <- function() {
  if(!file.exists(SCCfilename)) {
    getWorkingData()
  }
  if(!exists("SCC")){
    SCC <- readRDS(SCCfilename)
  }
  SCC
}

getWorkingData <- function() {
  
  if(!file.exists(datafile)) {
    download.file(datafileurl, datafile)
    unzip(datafile)
  }
}
