?iris
iris

#Kmeans clustering
install.packages("ggfortify")
library("ggfortify")
summary(iris)
head(iris)
data <- iris[ , c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")] 
data
kmean <- kmeans(data, 2)
kmean$centers
autoplot(kmean, data, frame = TRUE)

#Hierarchical clustering
install.packages("dplyr")
library(dplyr)

# Summary of dataset in package
head(mtcars)

# Finding distance matrix
distance_mat <- dist(mtcars, method = 'euclidean')
distance_mat

# Fitting Hierarchical clustering Model to training dataset
set.seed(240)  # Setting seed
Hierar_cl <- hclust(distance_mat, method = "average")
Hierar_cl

# Plotting dendrogram
plot(Hierar_cl)

# Choosing no. of clusters
# Cutting tree by height
abline(h = 110, col = "green")
