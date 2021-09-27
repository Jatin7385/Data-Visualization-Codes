#Radar Charts in R
#CODE BY JATIN DHALL
#Using mtcars dataset

#INSTALLATION OF LIBRARIES
#devtools::install_github("ricardo-bion/ggradar", 
#                        dependencies = TRUE)
#Loading the libraries
library(ggplot2)
library(ggradar)
library(dplyr) #Pipe operation. It takes the output from one function and provides it to another function
library(scales)#For labelling axes and legends

attach(mtcars)
# %>% is a pipe operator

#Select out dataset
mtcars %>%
  #attributes rownames to a variable
  add_rownames(var = "group") %>%
  #assign each variable -- car names -- to their related variables
  mutate_each(funs(rescale), -group) %>%
  #Select which data to plot
  head(3) %>% select(1:10) ->mtcars_radar

options(warn = -1) #To suppress the warnings
#ggradar(mtcars_radar)

#To increase the size of the radar plot
IRkernel::set_plot_options(width=950,height=600,units='px')
ggradar(mtcars_radar)