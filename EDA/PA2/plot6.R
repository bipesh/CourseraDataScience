#plot6.R

#Question
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

#Answer
#Los Angeles County has greater changes over time in motor vehicle emissions.

# Load required source file
source(getworkingdata.R)

# Load NEI, SCC data
NEI <- getNEI()
SCC <- getSCC()

#  Create Plot Data 
SCC.veh <- grep("vehicle", SCC$Short.Name, ignore.case = TRUE)
SCC.veh <- SCC[SCC.veh, ]
SCC.vehscc <- as.character(SCC.veh$SCC)

#generate dataset for Vehicle Emissions for Baltimore and LA
# aggregated by year
NEI.bwila <- subset(NEI, fips == "24510" | fips == "06037")
NEI.bwilascc <- as.character(NEI.bwila$SCC)
NEI.bwilaveh <- NEI.bwila[NEI.bwilascc %in% SCC.vehscc,]
NEI.bwilaveh <- aggregate(Emissions ~ year+fips, NEI.bwilaveh, sum)

# adding new column for city name
NEI.bwilaveh$city <- rep(NA, nrow(NEI.bwilaveh))
NEI.bwilaveh[NEI.bwilaveh$fips == "06037", ][, "city"] <- "Los Angles County"
NEI.bwilaveh[NEI.bwilaveh$fips == "24510", ][, "city"] <- "Baltimore City"

#  Create Plot
png('plot6.png', width=480, height=480)
qplot(year
      , Emissions
      , data = NEI.bwilaveh
      , group = NEI.bwilaveh$city
      , color = NEI.bwilaveh$city
      , geom = c("point", "line")
      , ylab = expression("Total Emissions [Tons] , PM"[2.5])
      , xlab = "Years"
      , main = "Vehicle Emission / Baltimore Vs LA County")

dev.off()