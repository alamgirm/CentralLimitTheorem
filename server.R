
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    dist <- switch(input$dist, 
                   unif=runif, 
                   triangle=rltriangle,
                   lnorm = rlnorm,
                   exp = rexp)
    x    <- input$trials
    n <- input$samplesize
    bins <- input$binsize
    shKDE <- input$show_kde
    
    #generate random numbers of given dist, and sample size
    RN <- matrix(dist(x*n), nrow=x, ncol=n)
    #calculate mean
    RM <- x*colMeans(RN)
    
    # draw the histogram with the specified number of bins
     h <- hist(RM, breaks = bins, col = 'darkgray', border = 'white', freq = FALSE,
         main=paste("Normalized histogram of ", x, input$dist, " distributions"))
 
    #KDE
    if(shKDE == TRUE) {
        smm <- mean(RM)
        ssd <- sd(RM)
        x <- h$breaks
        y <- dnorm(x=x, mean=smm, sd=ssd)
        par(lwd=2)
        lines(x, y, col='green')
        xlpos <- smm
        xlpos <- xlpos + xlpos*10/100
        ylpos <- max(y)
        ylpos <- ylpos + ylpos*7/100
        #legend(100,0.01, paste(xlpos, ylpos))
        legend(xlpos, ylpos, paste("Mean=", format(smm, digits = 3), "SD=", format(ssd,digits=3)))
    }
  })

})
