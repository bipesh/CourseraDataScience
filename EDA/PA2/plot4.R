#plot4.R

#Question
#Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?

#Answer
# Emissions from coal combustion-related sources reduced by about 40% during 1999-2008  period across the United States

# Load required source file
source(getworkingdata.R)

# Load NEI, SCC data
NEI <- getNEI()
SCC <- getSCC()

#  Create Data
SCC.coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCC.coal <- SCC[SCC.coal, ]
SCC.coalscc <- as.character(SCC.coal$SCC)

NEI.scc <- as.character(NEI$SCC)
NEI.coal <- NEI[NEI.scc %in% SCC.coalscc, ]
NEI.coal <- aggregate(Emissions ~ year, NEI.coal, sum)

#  Create Plot
png('plot4.png', width=480, height=480)
barplot(height=NEI.coal$Emissions
        , names.arg=NEI.coal$year
        , xlab="Years"
        , ylab=expression("Total Coal Emissions [Tons] PM"[2.5])
        , main=expression("Total Coal Emissions By Year / USA")
        , col="aquamarine3")
lines(NEI.coal$Emission, col="blue")
points(NEI.coal$Emission, col="blue")

dev.off()


