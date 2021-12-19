#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#code by JATIN DHALL
#20BCE0832
library(shiny)
library(shinydashboard) 
library(DT) 
library(dplyr)
library(ggplot2)
library(broom)
library(lmtest)
library(ggplot2) 
library("tm") 
library("SnowballC") 
library("wordcloud") 
library("RColorBrewer") 



#Importing the dataset into the code
df <- read.csv("C:/Users/Jatin Dhall/Desktop/Desktop File/VIT/VIT/SEM 3/DATA VIZ/LAB/LABFAT/coursea_data.csv")
head(df)
#Creating dataframe for Q1(Table)
table_cols <- data.frame(
    course_title = df$course_title,
    course_rating = df$course_rating,
    course_students_enrolled = df$course_students_enrolled)
head(table_cols)

#Q2]
#Finding the organisation names and their counts
org_courses_count = count(df, vars = course_organization)
org_names = org_courses_count$vars
org_count = org_courses_count$n
org_names
org_count


# Define UI for application that draws a histogram
ui <- fluidPage(
    dashboardPage( 
        dashboardHeader(title="Jatin Dhall 20BCE0832 DA"), 
        dashboardSidebar(disable = TRUE), 
        dashboardBody( 
            fluidRow(box( 
                title = "Table(Jatin Dhall)", 
                solidHeader = TRUE, 
                collapsible = TRUE, 
                DT::dataTableOutput("table"),
                width = 12
            )),
            fluidRow(
                box(
                    title = "Bar chart(Jatin Dhall)", 
                    solidHeader = TRUE, 
                    collapsible = TRUE,
                    plotOutput("bar",height = 500),
                    width = 12
                ) 
            ),
            fluidRow(
                box(
                    title = "Linear Regression Plot(Jatin Dhall)",
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    plotOutput("regplot"),
                    width = 12
                )
            ),
            fluidRow(
                box( 
                    title = "Tag cloud of the inferences(Jatin Dhall)", 
                    solidHeader = TRUE, 
                    collapsible = TRUE, 
                    plotOutput("inferences") 
                ),
            )
            
        ) 
    ) 
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$table = DT::renderDataTable({ 
        table_cols
    })
    
    output$bar <- renderPlot({
        barplot(org_count,names.arg=org_names,xlab="",ylab="No. of courses offered",col="blue",
                main="No. of courses vs Organisation Bar Chart",las=2)
    })
    y <- df$course_rating
    x <- df$course_students_enrolled
    fit <- lm(y ~ x)
    predict <- data.frame(predict(fit,df),y)
    model <- augment(fit)
    output$regplot <- renderPlot({
        ggplot(data = df, aes(x = x, y = y)) + 
            geom_point(color='blue') +
            geom_smooth(method = "lm", se = FALSE) +
            geom_line(color='red',data = predicted, aes(x=x, y=y))
    })
    
    output$inferences <- renderPlot({ 
        filePath <- "C:/Users/Jatin Dhall/Desktop/Desktop File/VIT/VIT/SEM 3/DATA VIZ/LAB/LABFAT/Inference.txt.txt"
        text <- readLines(filePath) 
        
        # Load the data as a corpus
        docs <- Corpus(VectorSource(text)) 
        
        inspect(docs) 
        
        toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " 
", x)) 
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
                  main = "Tag Cloud with Inference",colors=brewer.pal(8, 
                                                                      "Dark2")) 
        
    }) 
    
}

# Run the application 
shinyApp(ui = ui, server = server)
