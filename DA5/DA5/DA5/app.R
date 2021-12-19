#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#CODE BY JATIN DHALL 20BCE0832
library(shiny)
library(ggplot2)
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library(DT)
library(shinydashboard)

# Define UI for application that draws a histogram
ui <- fluidPage(
    dashboardPage(
        dashboardHeader(title="Jatin Dhall 20BCE0832 DA"),
        dashboardSidebar(disable = TRUE),
        dashboardBody(
            box(
                title = "Daily confirmed Cases in Brazil and India(Jatin Dhall)",
                solidHeader = TRUE,
                collapsible = TRUE,
                plotOutput("dailyConfirmedCases")
                ),
           box(
               title = "Daily Deaths in Brazil and India(Jatin Dhall)",
               solidHeader = TRUE,
               collapsible = TRUE,
               plotOutput("dailyDeaths")
               ),
           box(
               title = "Tag cloud of the inferences(Jatin Dhall)",
               solidHeader = TRUE,
               collapsible = TRUE,
               plotOutput("inferences")
               ),
           box(
               title = "Table containing  daily death per million population and daily confirmed cases per 
million population for India and Brazil(Jatin Dhall)",
               solidHeader = TRUE,
               collapsible = TRUE,
               DT::dataTableOutput("table")
               )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    df <- read.csv("C:\\Users\\Jatin Dhall\\Desktop\\Desktop File\\VIT\\VIT\\SEM 3\\DATA VIZ\\LAB\\DA5\\covid-data-india-brazil.csv")
    print(head(df))
    
    output$dailyConfirmedCases <- renderPlot({
        # draw the histogram with the specified number of bins
        ggplot(df, aes(date, y = new_cases, fill = location)) +
            geom_bar(stat = "identity") +
            ggtitle("Daily Confirmed Cases vs Date Stacked bar chart(Jatin Dhall)")
    })
    output$dailyDeaths <- renderPlot({
        
        ggplot(df, aes(date, y = new_deaths, fill = location)) +
            geom_bar(stat = "identity") +
            ggtitle("Daily Deaths vs Date Stacked bar chart(Jatin Dhall)")
    })
    
    output$inferences <- renderPlot({
        filePath <- "C:/Users/Jatin Dhall/Desktop/Desktop File/VIT/VIT/SEM 3/DATA VIZ/LAB/DA5/inferences.txt"
        text <- readLines(filePath)
        
        # Load the data as a corpus
        docs <- Corpus(VectorSource(text))
        
        inspect(docs)
        
        toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
        docs <- tm_map(docs, toSpace, "/")
        docs <- tm_map(docs, toSpace, "@")
        docs <- tm_map(docs, toSpace, "\\|")
        
        # Convert the text to lower case
        docs <- tm_map(docs, content_transformer(tolower))
        # Remove numbers
        docs <- tm_map(docs, removeNumbers)
        # Remove english common stopwords
        docs <- tm_map(docs, removeWords, stopwords("english"))
        # Remove punctuations
        docs <- tm_map(docs, removePunctuation)
        # Eliminate extra white spaces
        docs <- tm_map(docs, stripWhitespace)
        # Text stemming
        # docs <- tm_map(docs, stemDocument)
        
        dtm <- TermDocumentMatrix(docs)
        m <- as.matrix(dtm)
        v <- sort(rowSums(m),decreasing=TRUE)
        d <- data.frame(word = names(v),freq=v)
        head(d, 10)
        
        set.seed(1234)
        wordcloud(words = d$word, freq = d$freq, min.freq = 1,
                  max.words=200, random.order=FALSE, rot.per=0.35, 
                  main = "Tag Cloud with Inference",colors=brewer.pal(8, "Dark2"))
        
    })
    #Death and Confirmed Cases per million in a table
    date <- df$date
    dailycases <- df$new_cases/1000000
    dailydeaths <- df$new_deaths/1000000
    
    df1 <-data.frame (date,dailycases,dailydeaths)
    
    output$table = DT::renderDataTable({
        df1
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
