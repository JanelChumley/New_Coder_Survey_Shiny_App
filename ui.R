require("jsonlite")
require("RCurl")
require("dplyr")
require("tidyr")
require("ggplot2")
require("ggthemes")
library("shiny")

shinyUI(fluidPage(
        sliderInput("age", "Age of New Coder: ", min = 15, max = 60, value = 25),
        mainPanel(
          tabsetPanel(
            tabPanel("Bar Graph", plotOutput("plot")), 
            tabPanel("Summary", verbatimTextOutput("summary"))
))))

