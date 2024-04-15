library(tidyverse)

data <- read_csv("data/raw/wine_quality.csv")

selected_data <- data %>% 
    select(Id, "citric acid", "residual sugar", "density", "pH", "alcohol", "quality") %>%
    column_to_rownames(var = "Id")

write.csv(selected_data, "data/filtered/filtered_data.csv")
