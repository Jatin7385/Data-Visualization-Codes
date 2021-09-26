#Histograms in R
#CODE BY JATIN DHALL
#Using mtcars Dataset
library(ggplot2)
qplot(
  hp,
  geom = "histogram",
  binwidth = 25,#The number range is broken into bins of 25
  color = I("black"),#Color of the borders
  xlab = "HorsePower",#Xlabel
  ylab = "Number of Cars",#Ylabel
  alpha = I(0),#Removes the fill color completely
  main = "Histogram")#Title of the histogram