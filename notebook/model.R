# Using an old notebook : https://www.kaggle.com/code/riyaelizashaju/wine-quality-random-forest/notebook

library(randomForest)
library(caret)

df <- read.csv("data/filtered/filtered_data.csv")
df_temp <- df[, !(names(df) %in% c("Id", "X"))]
head(df_temp)

# Data preprocessing - coverting all values to numbers between 0 and 1
normalize <- function(x, na.rm = TRUE) {
    return((x- min(x)) /(max(x)-min(x)))
}

df_temp_scaled <- as.data.frame(normalize(df_temp))
head(df_temp_scaled)

# Split data into features and labels
label <- df_temp_scaled$quality
features <- df_temp_scaled[, !(names(df_temp_scaled) %in% c("quality"))]

# Split data into training and test sets
set.seed(123)  # For reproducibility
train_indices <- createDataPartition(label, p = 0.8, list = FALSE)
X_train <- features[train_indices, ]
y_train <- label[train_indices]
X_test <- features[-train_indices, ]
y_test <- label[-train_indices]

# Build the random forest model
forest_model <- randomForest(x = X_train, y = y_train, ntree = 100, random_state = 1)

# Make predictions
pred_rf <- predict(forest_model, X_test)
head(pred_rf)

# Evaluate the model
print(mean((y_test - pred_rf)^2))
print(mean(abs(y_test - pred_rf)))

# Save the model
saveRDS(forest_model, file = "model/forest_model.rds")
