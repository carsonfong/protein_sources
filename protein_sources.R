library(tidyverse)
df <- read_csv('protein_sources.csv')

scatter <- ggplot(data = df,mapping = aes(x=Calories_100g, y = Protein_100g)) +
  geom_point()

scatter
