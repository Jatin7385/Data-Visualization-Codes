#PieChart in R
#CODE BY JATIN DHALL
#Using the mtcars dataset
#To create a pie chart, we first need to create a bar chart
library(ggplot2)
attach(mtcars)
barp<-ggplot(mtcars,aes(x=1,y=sort(carb),fill=sort(carb)))+geom_bar(stat="identity")#To create the stacked barplot
barp<-barp + coord_polar(theta="y")#Converts the stacked bar chart to piechart
barp<-barp + theme(
  axis.line = element_blank(),
  axis.text.x = element_blank(),
  axis.text.y = element_blank(),
  axis.ticks = element_blank(),
  axis.title.y = element_blank(),
  panel.background = element_blank())+
  labs(y = "Carburetors")
print(barp)