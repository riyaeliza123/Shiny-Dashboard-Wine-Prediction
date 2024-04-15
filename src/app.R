library(shiny)

df <- read.csv("data/filtered/filtered_data.csv")
forest_model <- readRDS("model/forest_model.rds")

ui <- fluidPage(
  titlePanel("Wine Quality Prediction"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("citric_acid", "Citric Acid:",
                  min = min(df$citric.acid),
                  max = max(df$citric.acid),
                  value = 0.4),
      sliderInput("residual_sugar", "Residual Sugar:",
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
      sliderInput("alcohol", "Alcohol",
                  min = min(df$alcohol),
                  max = max(df$alcohol),
                  value = 10),
    ),
    mainPanel(
      textOutput("prediction")
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

    data.frame('Wine Quality Prediction' = prediction)
  })

}

shinyApp(ui = ui, server = server)
