library(shiny)
library(randomForest)
library(shinythemes)
library(caret)
library(tidyverse)
library(rsconnect)

df <- read.csv("data/filtered_data.csv")
forest_model <- readRDS("forest_model.rds")

ui <- fluidPage(
  titlePanel("Wine Quality Prediction"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("citric_acid", "Citric Acid (mg):",
                  min = min(df$citric.acid),
                  max = max(df$citric.acid),
                  value = 0.4),
      sliderInput("residual_sugar", "Residual Sugar (mg):",
                  min = min(df$residual.sugar),
                  max = max(df$residual.sugar),
                  value = 4),
      sliderInput("density", "Density:",
                  min = min(df$density),
                  max = max(df$density),
                  value = 1),
      sliderInput("pH", "pH:",
                  min = min(df$pH),
                  max = max(df$pH),
                  value = 3),
      sliderInput("alcohol", "Alcohol (%):",
                  min = min(df$alcohol),
                  max = max(df$alcohol),
                  value = 10),
    ),
    mainPanel(
      h2(tableOutput("prediction"))
    )
  )
)

server <- function(input, output) {

  output$prediction <- renderTable({
    user_data <- data.frame("citric acid" = input$citric_acid,
                            "residual sugar" = input$residual_sugar,
                            "density" = input$density,
                            "pH" = input$pH,
                            "alcohol" = input$alcohol)

    normalize <- function(x, na.rm = TRUE) {
      return((x - min(x)) / (max(x) - min(x)))
    }
    scaled_data <- as.data.frame(normalize(user_data))
    prediction <- predict(forest_model, scaled_data)

    # Convert back to original scale
    original_pred = (prediction * (max(df$quality) - min(df$quality))) + min(df$quality)

    result <- ifelse(original_pred > 5.2, "High", "Low")

    data.frame("Wine_quality_index" = original_pred,
              "Wine_quality" = result
    )
  })
}

shinyApp(ui = ui, server = server)
