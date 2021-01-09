library(tidyverse)
library(ggrepel)
df <- read_csv('protein_sources.csv')

scatter <- ggplot(data = df,mapping = aes(x=Calories_100g, y = Protein_100g, color = Type)) +
  geom_point() +
  geom_text_repel(mapping = aes(label=Food), size = 3) +
  theme_minimal() +
  labs(title = "Protein vs Calories",
       subtitle = "Cooked weights used, except for nuts and seeds",
       caption = "@carsonfong | Data Source: https://ndb.nal.usda.gov/ndb/",
       y = "Protein (g) in 100g of Food",
       x = "Calories in 100g of Food")

scatter

# compare pound for pound
df_2 <- df %>%
  mutate(prot_per_100cal = Protein_100g / Calories_100g * 100) %>%
  arrange(prot_per_100cal)

bar <- ggplot(data = df_2, mapping = aes(x = reorder(Food,prot_per_100cal),y = prot_per_100cal, fill = Type)) +
  geom_col() +
  coord_flip() +
  labs(title = "Protein per 100 Calories",
       caption = "@carsonfong | Data Source: https://ndb.nal.usda.gov/ndb/",
       y = "Protein (g) per 100 calories"
       ) +
  theme_minimal() +
  theme(
    axis.title.y = element_blank()
  )

bar

# save plots
ggsave(filename = "protein_scatter.png",
       plot = scatter,
       width = 7, height = 4, units = "in")

ggsave(filename = "protein_bar.png",
       plot = bar,
       width = 7, height = 4, units = "in")
