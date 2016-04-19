
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

#Load helper functions
source("getworkingdata.R",local=TRUE)

# Load NEI, SCC data
NEI <- getNEI()
SCC <- getSCC()

#SCC data
SCC.veh <- grep("vehicle", SCC$Short.Name, ignore.case = TRUE)
SCC.veh <- SCC[SCC.veh, ]
SCC.vehscc <- as.character(SCC.veh$SCC)

SCC.coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCC.coal <- SCC[SCC.coal, ]
SCC.coalscc <- as.character(SCC.coal$SCC)

#  US Pollution Data
NEI.usYear <- aggregate(Emissions ~ year, NEI, sum)
NEI.usType <- aggregate(Emissions ~ year+type, NEI, sum)

NEI.scc <- as.character(NEI$SCC)

#US Coal
NEI.coal <- NEI[NEI.scc %in% SCC.coalscc, ]
NEI.coal <- aggregate(Emissions ~ year, NEI.coal, sum)

#US Vehicle
NEI.veh <- NEI[NEI.scc %in% SCC.vehscc, ]
NEI.veh <- aggregate(Emissions ~ year, NEI.veh, sum)


#  BWI Pollution Data
NEI.bwi <- subset(NEI, fips == "24510")
NEI.bwiYear <- aggregate(Emissions ~ year, NEI.bwi, sum)
NEI.bwiType <- aggregate(Emissions ~ year+type, NEI.bwi, sum)
NEI.bwiscc <- as.character(NEI.bwi$SCC)

#BWI Coal
NEI.bwicoal<- NEI.bwi[NEI.bwiscc %in% SCC.coalscc, ]
NEI.bwicoal <- aggregate(Emissions ~ year, NEI.bwicoal, sum)

#BWI Vehicle
NEI.bwiveh<- NEI.bwi[NEI.bwiscc %in% SCC.vehscc, ]
NEI.bwiveh <- aggregate(Emissions ~ year, NEI.bwiveh, sum)

# LA County Pollution Data
NEI.lac <- subset(NEI, fips == "06037")
NEI.lacYear <- aggregate(Emissions ~ year, NEI.lac, sum)
NEI.lacType <- aggregate(Emissions ~ year+type, NEI.lac, sum)

NEI.lacscc <- as.character(NEI.lac$SCC)

#LAC Coal
NEI.laccoal<- NEI.bwi[NEI.lacscc %in% SCC.coalscc, ]
NEI.laccoal <- aggregate(Emissions ~ year, NEI.laccoal, sum)

#LAC Vehicle
NEI.lacveh<- NEI.bwi[NEI.lacscc %in% SCC.vehscc, ]
NEI.lacveh <- aggregate(Emissions ~ year, NEI.lacveh, sum)


shinyServer(function(input, output) {
  
  output$emissionByRegion <- renderPlot({
    
    if(input$region=="us") {
      #  Create Plot for US
      counts<-c(NEI.usYear$Emission)
      barplot(NEI.usYear$Emission
              , names.arg=NEI.usYear$year
              , xlab="Years"
              , ylab=expression("Total Emissions [Tons] PM"[2.5])
              , main=expression("Total Emissions By Year / USA")
              , col="aquamarine3")
    } else if(input$region=="bwi") {
      #  Create Plot for BWI
      barplot(height=NEI.bwiYear$Emissions
              , names.arg=NEI.bwiYear$year
              , xlab="Years"
              , ylab=expression("Total Emissions [Tons] PM"[2.5])
              , main=expression("Total Emissions By Year / Baltimore, Maryland")
              , col="aquamarine3")
    } else if(input$region=="lac") {
      #  Create Plot for LAC
      barplot(height=NEI.lacYear$Emissions
              , names.arg=NEI.lacYear$year
              , xlab="Years"
              , ylab=expression("Total Emissions [Tons] PM"[2.5])
              , main=expression("Total Emissions By Year / LA County")
              , col="aquamarine3")
    }    
  })

  output$emissionByType <- renderPlot({
    
    if(input$region=="us") {
      #  Create Plot for US
      qplot(year
            , Emissions
            , data = NEI.usType
            , group = NEI.usType$type
            , color = NEI.usType$type
            , geom = c("point", "line")
            , ylab = expression("Total Emissions [Tons] , PM"[2.5])
            , xlab = "Year", main = "Total Emissions By Type / USA")
    } else if(input$region=="bwi") {
      #  Create Plot for BWI
      qplot(year
            , Emissions
            , data = NEI.bwiType
            , group = NEI.bwiType$type
            , color = NEI.bwiType$type
            , geom = c("point", "line")
            , ylab = expression("Total Emissions [Tons] , PM"[2.5])
            , xlab = "Year", main = "Total Emissions By Type / Baltimore, Maryland")
    } else if(input$region=="lac") {
      #  Create Plot for LAC
      qplot(year
            , Emissions
            , data = NEI.lacType
            , group = NEI.lacType$type
            , color = NEI.lacType$type
            , geom = c("point", "line")
            , ylab = expression("Total Emissions [Tons] , PM"[2.5])
            , xlab = "Year", main = "Total Emissions By Type / LA County")
    }    
  })

  output$emissionByCoal <- renderPlot({

    if(input$region=="us") {
      #  Create Plot for US
      barplot(height=NEI.coal$Emissions
              , names.arg=NEI.coal$year
              , xlab="Years"
              , ylab=expression("Total Coal Emissions [Tons] PM"[2.5])
              , main=expression("Total Coal Emissions By Year / USA")
              , col="aquamarine3")
    } else if(input$region=="bwi") {
      #  Create Plot for BWI
      barplot(height=NEI.bwicoal$Emissions
              , names.arg=NEI.bwicoal$year
              , xlab="Years"
              , ylab=expression("Total Coal Emissions [Tons] PM"[2.5])
              , main=expression("Total Coal Emissions By Year / Baltimore, Maryland")
              , col="aquamarine3")
      } else if(input$region=="lac") {
      #  Create Plot for LAC
        barplot(height=NEI.laccoal$Emissions
                , names.arg=NEI.laccoal$year
                , xlab="Years"
                , ylab=expression("Total Coal Emissions [Tons] PM"[2.5])
                , main=expression("Total Coal Emissions By Year / Los Angeles County")
                , col="aquamarine3")
    }    
  })
  
  output$emissionByVehicle <- renderPlot({
    if(input$region=="us") {
      #  Create Plot for US
      barplot(height=NEI.veh$Emissions
              , names.arg=NEI.veh$year
              , xlab="Years"
              , ylab=expression("Total Veh Emissions [Tons] PM"[2.5])
              , main=expression("Total Veh Emissions By Year / USA")
              , col="aquamarine3")
    } else if(input$region=="bwi") {
      barplot(height=NEI.bwiveh$Emissions
              , names.arg=NEI.bwiveh$year
              , xlab="Years"
              , ylab=expression("Total Vehicle Emissions [Tons] PM"[2.5])
              , main=expression("Total Vehicle Emissions By Year / Baltimore, Maryland")
              , col="aquamarine3")
    } else if(input$region=="lac") {
      #  Create Plot for LAC
      barplot(height=NEI.lacveh$Emissions
              , names.arg=NEI.lacveh$year
              , xlab="Years"
              , ylab=expression("Total Vehicle Emissions [Tons] PM"[2.5])
              , main=expression("Total Vehicle Emissions By Year / Los Angeles County")
              , col="aquamarine3")
      }
  })
})
