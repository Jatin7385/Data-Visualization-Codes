#BOX PLOTS IN R
#CODE BY JATIN DHALL

#A box plot summarizes the distribution of sorted numerical data

#Using a seed() function which sets the starting number used to 
#generate a sequence of random numbers- it ensures that you get the 
#same result if you start with the same seed each time you run the same process.

set.seed(1234)

#Creating two sets of data each with 200 samples
#Using the rnorm() function thatgenerates a vector of normally distributed random numbers
set_a <- rnorm(200,mean = 1, sd = 2)
set_b <- rnorm(200, mean = 0, sd = 1)

#Create the data frame
df <- data.frame(label = factor(rep(c("A","B"), each = 200)),  value = c(set_a,set_b))
head(df)
tail(df)

#Using the ggplot2 and plotly packages
#Loading the libraries
library(ggplot2)
library(plotly)

ggplot(df, aes(x = label,y = value)) + geom_boxplot()

ggplotly()


#NOW USING THE MTCARS DATASET FOR THE BOXPLOT
summary(mtcars)
attach(mtcars)
#qplot(factor(cyl),mpg,data=mtcars,geom="boxplot")
cars <- ggplot(mtcars, aes(factor(cyl),mpg))
cars + geom_boxplot()