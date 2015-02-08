library(quantmod)

shinyServer(function(input, output) {
    
    # Obtain the data from Yahoo. Use reactive expression, to reduce the number of times to access Yahoo data.
    dataInput <- reactive({  
        getSymbols(input$symb, src = "yahoo", 
                   from=input$dates[1],
                   to=input$dates[2],
                   auto.assign=F                   
        )  
    })
            
    output$plot <- renderPlot({        
        # Given the symbol, retrieve the name of the stock.
        stock_name <- getQuote(input$symb, what=yahooQF("Name"))[,2]
        
        chartSeries(Ad(dataInput()), theme = chartTheme("white"), 
                    type="line", name=paste(stock_name), show.grid=T)
        
        ma_periods <- 0  # Variable to hold the input parameter to addSMA().
        
        if(input$ma20) ma_periods <- c(ma_periods, 20)
        if(input$ma50) ma_periods <- c(ma_periods, 50)
        if(input$ma100) ma_periods <- c(ma_periods, 100)   
        if(input$ma200) ma_periods <- c(ma_periods, 200)  
        
        # This workaround needed because multiple sequential calls to addSMA() in shiny, results in only the last call being run.
        if(length(ma_periods) > 1) addSMA(n=ma_periods[2:length(ma_periods)], on=1, with.col = Ad, overlay = T)
    })
})