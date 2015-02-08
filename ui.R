library(shiny)

shinyUI(fluidPage(
  titlePanel("Stock Moving Average Application"),

  HTML("This application takes in a stock symbol and a date range. It retrieves the daily prices from Yahoo Finance, and plots a chart of the adjusted closing prices. The checkboxes allow you to calculate the moving averages of the price, and overlay them on the price chart. This can potentially help you to identify stocks which are possibly undervalued."),
  br(), br(),
  HTML("<span style=\"color:blue; font-style:italic\"> Note: The chart on the right panel below may take up to 5-10 seconds to load, because data is being retrieved from Yahoo. <br/> Also, if the application appears greyed out, please refresh your browser, as this means that a timeout has occurred.</span>"),
  br(),br(),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Key in a stock symbol (eg: AAPL, GS, KO). Use valid symbols from Yahoo Finance."),
    
      textInput("symb", "Symbol", "KO"),
    
      dateRangeInput("dates", 
        "Date range",
        start = "2014-01-01", 
        end = as.character(Sys.Date())),
         
      br(),
            
      checkboxInput("ma20", "20-day Moving Average", value=T),
      checkboxInput("ma50", "50-day Moving Average", value=F),
      checkboxInput("ma100", "100-day Moving Average", value=F),
      checkboxInput("ma200", "200-day Moving Average", value=F)
    ),
    
    mainPanel(plotOutput("plot", height = 600))
  )
))