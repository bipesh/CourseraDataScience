#plot2.R

# Question
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
# plot answering this question.

#Answer
# Overall emissions form PM2.5 has decreased in the Baltimore City from 1999-2008. 
# There is a spike from period 2002-2005 and decrease again resulting in less emissions
# than beginning of the overall period.

# Load required source file
source(getworkingdata.R)

# Load NEI data
NEI <- getNEI()

#  Create Plot-Data
NEI.bwi <- subset(NEI, fips == "24510")
NEI.bwi <- aggregate(Emissions ~ year, NEI.bwi, sum)

#  Create Plot 2
png('plot2.png', width=480, height=480)
barplot(height=NEI.bwi$Emissions
        , names.arg=NEI.bwi$year
        , xlab="Years"
        , ylab=expression("Total Emissions [Tons] PM"[2.5])
        , main=expression("Total Emissions By Year / Baltimore, Maryland")
        , col="aquamarine3")
lines(NEI.bwi$Emission, col="blue")
points(NEI.bwi$Emission, col="blue")

dev.off()
