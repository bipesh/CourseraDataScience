#plot3.R

#Question
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

#Answer
# Three of the types (NONPOINT, NON-ROAD, ONROAD) have shown consistent decrease in emission for the period. 
# Type ONROAD increased from period 1999-2005 and reduced again from 2005-2008 coming down to the emission
# level of 1999

# Load required source file
source(getworkingdata.R)

# Load NEI data
NEI <- getNEI()

#  Create Plot-Data
NEI.bwi <- subset(NEI, fips == "24510")
NEI.bwi <- aggregate(Emissions ~ year+type, NEI.bwi, sum)


#  Create Plot - Using ggplot2 package
png('plot3.png', width=480, height=480)
qplot(year
      , Emissions
      , data = NEI.bwi
      , group = NEI.bwi$type
      , color = NEI.bwi$type
      , geom = c("point", "line")
      , ylab = expression("Total Emissions [Tons] , PM"[2.5])
      , xlab = "Year", main = "Total Emissions By Type / Baltimore, Maryland")

dev.off()