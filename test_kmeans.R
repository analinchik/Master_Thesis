

# Load the packages
library(factoextra)
library(cluster)


# Example data (using the 'mtcars' dataset)
data <- mtcars

# Optionally, normalize the data
data <- scale(data)


# Calculate the total within-cluster sum of squares for different numbers of clusters
wss <- function(k) {
  kmeans(data, k, nstart = 10)$tot.withinss
}

# Compute and plot the WSS for k = 1 to 10
k.values <- 1:10
wss.values <- sapply(k.values, wss)

plot(k.values, wss.values, type = "b", pch = 19, frame = FALSE,
     xlab = "Number of clusters (k)",
     ylab = "Total within-cluster sum of squares")


# Set the number of clusters
num_clusters <- 3

# Perform k-means clustering
kmeans_result <- kmeans(data, centers = num_clusters, nstart = 25)

# View the results
print(kmeans_result)

# Using factoextra to visualize clusters
fviz_cluster(kmeans_result, data = data)

pca_result <- prcomp(data, scale = TRUE)
plot(pca_result)  # Scree plot to visualize importance of components

evaluate_feature_importance <- function(data, feature) {
  temp_data <- data[, -which(names(data) == feature), drop = FALSE]
  km <- kmeans(temp_data, centers = 3, nstart = 25)
  return(km$$tot.withinss)
}

feature_scores <- sapply(names(data), function(f) evaluate_feature_importance(data, f))
names(feature_scores) <- names(data)
feature_scores  # Lower score may indicate higher importance if removing a feature increases WCSS

pairs(data)  # Visual inspection of pair-wise scatter plots

library(caret)
control <- rfeControl(functions = rfFuncs, method = "cv", number = 10)
results <- rfe(data[, -target_column], data[, target_column], sizes=c(1:ncol(data)), rfeControl=control)
print(results)

set.seed(123)  # For reproducibility
final_km <- kmeans(data_selected, centers = 3, nstart = 50)
fviz_cluster(final_km, data = data_selected)
