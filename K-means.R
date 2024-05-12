# Load the packages
library(factoextra)
library(cluster)

df <- data %>% dplyr::select("Uniprot_entry_name", "sum_nuc_young", "sum_nuc_old", "sum_cyto_young", "sum_cyto_old",  "score", "mean_hl_hours", "mean_mt", "Ratio_Above_0.5")
rows <- df$Uniprot_entry_name
df <- data.frame(df, row.names = rows)
df <- df %>% select(-Uniprot_entry_name)

# Optionally, normalize the data
df <- scale(df)

distance <- get_dist(df)
fviz_dist(distance, gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))

# Calculate the total within-cluster sum of squares for different numbers of clusters
wss <- function(k) {
  kmeans(df, k, nstart = 10)$tot.withinss
}

# Compute and plot the WSS for k = 1 to 10
k.values <- 1:20
wss.values <- sapply(k.values, wss)

plot(k.values, wss.values, type = "b", pch = 19, frame = FALSE,
     xlab = "Number of clusters (k)",
     ylab = "Total within-cluster sum of squares")

# Set the number of clusters
num_clusters <- 15

# Perform k-means clustering
kmeans_result <- kmeans(df, centers = num_clusters, nstart = 25)

# View the results
print(kmeans_result)


# Using factoextra to visualize clusters
fviz_cluster(kmeans_result, data = df)
