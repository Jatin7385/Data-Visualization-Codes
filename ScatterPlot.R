#Scatter Plot using R
#CODE BY JATIN DHALL
library(ggplot2)
attach(mtcars)
#qplot(mpg,wt,data = mtcars)
#ggplot(mtcars,aes(x=mpg,y=wt)) + geom_point(shape = 19)
cylFactor<-factor(cyl)
#ggplot(mtcars,aes(x=mpg,y=wt,shape=cylFactor)) + geom_point()
#ggplot(mtcars,aes(x=mpg,y=wt,shape=cylFactor,color = cylFactor)) + geom_point()
#ggplot(mtcars,aes(x=mpg,y=wt,color=cyl)) + geom_point()
ggplot(mtcars,aes(x=mpg,y=wt,color=cylFactor)) + geom_point()+labs(color = "Cylinders") + 
                  xlab("Miles per Gallon") +
                  ylab('Weight') +
                  ggtitle("Scatterplot")