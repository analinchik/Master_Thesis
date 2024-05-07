df1 <- data.frame(num = c(1,1,2,2))
df2 <- data.frame(num = c(1,1,1,2,2,2))


ggplot() +
  geom_bar(data = df1, aes(x = num, fill = 'Non-Phospho', weight = ), alpha = 0.5) + 
  geom_bar(data = df2, aes(x = num, fill = 'Phospho'), alpha = 0.5)+
  labs(x = 'Mean half-life (hours)', y = 'Density')+
  scale_fill_manual(values = c('Non-Phospho' = "#5DB7B1", 'Phospho' = '#FB8500')) +
  theme_classic() +
  theme(legend.position = "none")

ggplot() +
  geom_histogram(data = df1, aes(x = num, fill = 'Non-Phospho'), alpha = 0.5) + 
  geom_histogram(data = df2, aes(x = num, fill = 'Phospho'), alpha = 0.5)+
  labs(x = 'Mean half-life (hours)', y = 'Density')+
  scale_fill_manual(values = c('Non-Phospho' = "#5DB7B1", 'Phospho' = '#FB8500')) +
  theme_classic() +
  theme(legend.position = "none")

ggplot() +
  geom_density(data = df1, aes(x = num, fill = 'Non-Phospho'), alpha = 0.5) + 
  geom_density(data = df2, aes(x = num, fill = 'Phospho'), alpha = 0.5)+
  labs(x = 'Mean half-life (hours)', y = 'Density')+
  scale_fill_manual(values = c('Non-Phospho' = "#5DB7B1", 'Phospho' = '#FB8500')) +
  theme_classic() +
  theme(legend.position = "none")


ggplot() +
  geom_density(data = df1, aes(x = num, fill = 'Non-Phospho'), alpha = 0.5) +
  geom_density(data = df2, aes(x = num, fill = 'Phospho'), alpha = 0.5) +
  labs(x = 'Number', y = 'Density') +
  scale_fill_manual(values = c('Non-Phospho' = "#5DB7B1", 'Phospho' = '#FB8500')) +
  theme_classic() +
  theme(legend.position = "bottom")







df1_aggregated <- df1 %>%
  group_by(LeadProt) %>%
  summarise(total_count = sum(norm_counts))

# Aggregating normalized counts for df2
df2_aggregated <- df2 %>%
  group_by(LeadProt) %>%
  summarise(total_count = sum(norm_counts))

# Merging the two datasets
merged_data <- merge(df1_aggregated, df2_aggregated, by = "LeadProt", suffixes = c("_df1", "_df2"))


# Calculating fold change

merged_data <- merged_data %>%
  mutate(mean_count_df1 = total_count_df1 / sum(df1$norm_count),
         mean_count_df2 = total_count_df2 / sum(df2$norm_count)) %>%
  mutate(fold_change = mean_count_df1 / mean_count_df2)

# Defining enriched proteins in df1
enriched_in_df1 <- merged_data %>%
  filter(fold_change >= 2)

# Defining enriched proteins in df2
enriched_in_df2 <- merged_data %>%
  filter(fold_change <= 0.5) # Fold change of less than 1/2 indicates enrichment in df2

enriched_in_df1 <- inner_join(enriched_in_df1, leadprot_uniprot, by = 'LeadProt') 
enriched_in_df1 <- inner_join(enriched_in_df1, short_lived_proteins_hl, by = 'LeadProt')


enriched_in_df2 <- inner_join(enriched_in_df2, leadprot_uniprot, by = 'LeadProt') 
enriched_in_df2 <- inner_join(enriched_in_df2, short_lived_proteins_hl, by = 'LeadProt')


