#Linear Regression using R
#CODE BY JATIN DHALL
#Using mtcars dataset
#Linear regression in 2d is a way to find the line of best fit.
#It is a mathematical approach to fitting a linear function to a set of data
ggplot(mtcars,aes(x = mpg,y = wt)) + 
       geom_point(shape = 19) +
       geom_smooth(method = "lm",se = FALSE , color = "red")
#lm produces the linear model we see on the graph
#se = TRUE displays the confidence interval on the graph

ggplot(mtcars,aes(x = mpg, y = wt, color = cylFactor)) + 
       geom_point(shape = 19) + 
       geom_smooth(method = "lm",se = TRUE, color = "red") + 
       xlab("Miles per Gallon") +
       ylab("Weight") +
       labs(colour = "Cylinders") + 
       ggtitle("Linear Regression")

#FOR GAUSSIAN REGRESSION:
ggplot(mtcars,aes(x = mpg, y = wt, color = cylFactor)) + 
  geom_point(shape = 19) + 
  geom_smooth(method = "auto",se = TRUE, color = "red") + 
  xlab("Miles per Gallon") +
  ylab("Weight") +
  labs(colour = "Cylinders") + 
  ggtitle("Gaussian Regression")