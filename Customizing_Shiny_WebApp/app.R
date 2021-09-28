#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- fluidPage(
    #Input Functions() which is a Slider here.Other options are
        #checkboxInput(), numericInput() and textInput()
    #Output Functions() which is a Histogram here
    sliderInput(inputId = "num",
                label = "Select a number",
                value = 20, min = 1, max = 50),
    plotOutput(outputId = "hist")
    
)

server <- function(input,output)
{
    output$hist <- renderPlot({hist(rnorm(input$num))})
    
}

# Run the application 
shinyApp(ui = ui, server = server)
