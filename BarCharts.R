#BAR CHARTS USING R
#CODE BY JATIN 
#Using the mtcars dataset
#Using qplot for bar charts
mtcars
attach(mtcars)
library(ggplot2)
qplot(
  cyl,
  geom = "bar",
  fill = I("blue"),
  colour = I("red"),
  xlab = "Cylinders",
  ylab = "Number of Vehicles",
  main = "Cylinders in mtcars Dataset")
