
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Demonstrating Central Limit Theorem"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
        radioButtons("dist", "Distribution type:",
                     c("Uniform" = "unif",
                       "Triangle" = "triangle",
                       "Log-normal" = "lnorm",
                       "Exponential" = "exp")),
        sliderInput("trials",
                  "Number of sample set:",
                  min = 1,
                  max = 50,
                  value = 5,
                  step = 1),
      sliderInput("samplesize",
                  "Sample size:",
                  min = 1000,
                  max = 50000,
                  value = 2000,
                  step = 50),
      
     numericInput("binsize", "How many bins",
                  value=50, min= 10, max=250, step=5),
     checkboxInput("show_kde", "Show/hide Approximate Normal PDF", value=TRUE),
     
     submitButton("Submit")
     
      ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      p("If you average a sufficient number of random numbers drawn from any
        kind of probability distribution, the Central Limit Theorem states
        that the probability distribution of the averaged numbes will follow
        a Normal (Gaussian) distribution.")
    )
  )
))
