
human_df <- read.csv(file = "/Users/anastasialinchik/Desktop/Thesis/DATA/Human-separateProjects.csv", header = T)

# Load the iris dataset
data(iris)
plot(iris)
# Selecting only numeric variables for clustering
iris_numeric <- iris[, 1:4]

# Set the seed for reproducibility
set.seed(123)

# Perform k-means clustering with k=3
kmeans_result <- kmeans(iris_numeric, centers = 3)

# Print the cluster centers
print(kmeans_result$centers)

# Print the cluster assignments for each observation
print(kmeans_result$cluster)

# Plot the clusters
plot(iris_numeric, col = kmeans_result$cluster)

# Add cluster centers to the plot
points(kmeans_result$centers, col = 1:3, pch = 8, cex = 2)
