#plot1.R

#Question
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

#Answer
# Total emission in the United States has decreased by about half during 1999-2008 period. 

# Load required source file
source(getworkingdata.R)
  
# Load NEI data
NEI <- getNEI()

#  Create Plot-Data
NEI.us <- aggregate(Emissions ~ year, NEI, sum)

#  Create Plot 1

png('plot1.png', width=480, height=480)
barplot(height=NEI.us$Emissions
        , names.arg=NEI.us$year
        , xlab="Years"
        , ylab=expression("Total Emissions [Tons] PM"[2.5])
        , main=expression("Total Emissions By Year / USA")
        , col="aquamarine3")
lines(NEI.us$Emission, col="blue")
points(NEI.us$Emission, col="blue")

dev.off()