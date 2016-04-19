#plot5.R

#Question
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

#Answer
# Emissions from Motor Vehicle sources have reduced by more than half during 1999-2008 period in Baltimore City

# Load required source file
source(getworkingdata.R)

# Load NEI, SCC data
NEI <- getNEI()
SCC <- getSCC()

# Create Data
# Filtering SCC for Vehicle Emission
SCC.veh <- grep("vehicle", SCC$Short.Name, ignore.case = TRUE)
SCC.veh <- SCC[SCC.veh, ]
SCC.vehscc <- as.character(SCC.veh$SCC)

# Filtering vehicle emission data for Baltimore
NEI.bwi <- subset(NEI, fips == "24510")
NEI.bwiscc <- as.character(NEI.bwi$SCC)
NEI.bwiveh<- NEI.bwi[NEI.bwiscc %in% SCC.vehscc, ]
NEI.bwiveh <- aggregate(Emissions ~ year, NEI.bwiveh, sum)

# Creating Plot
png('plot5.png', width=480, height=480)
barplot(height=NEI.bwiveh$Emissions
        , names.arg=NEI.bwiveh$year
        , xlab="Years"
        , ylab=expression("Total Motor Vehicl Emissions [Tons] PM"[2.5])
        , main=expression("Total Motor Vehicle Emissions By Year / Baltimore, Maryland")
        , col="aquamarine3")
lines(NEI.bwiveh$Emission, col="blue")
points(NEI.bwiveh$Emission, col="blue")

# Closing Plotting Device
dev.off()
