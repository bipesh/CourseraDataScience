library(shiny)

shinyUI(
  navbarPage("Air Pollution Case Study",
    tabPanel("Plots by Region",
    # Sidebar with a slider input for number of bins
      sidebarPanel(
        radioButtons("region", "Pollution Region:", c("US"="us","Baltimore"="bwi","LA County"="lac"))
      ),
      # Show a plot of the generated distribution
      mainPanel(
        tabsetPanel(
          tabPanel(p(icon("bar-chart"), "Overall Air Pollution"),
                     plotOutput("emissionByRegion")
            
          ),
          tabPanel(p(icon("line-chart"), "Air Pollution by Type"),
                     plotOutput("emissionByType")
          ),
          tabPanel(p(icon("bar-chart"), "Emission By Coal"),
                   plotOutput("emissionByCoal")
          ),
          tabPanel(p(icon("bar-chart"), "Emission By Vehicle"),
                   plotOutput("emissionByVehicle")
          )
        )
      )
    ),
    tabPanel("About",
             mainPanel(
               includeMarkdown("include.md")
             )
    )
  )
)
