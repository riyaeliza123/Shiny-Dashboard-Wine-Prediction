# Wine quality prediction

**Link to the dashboard**: https://0wsp08-riya-eliza.shinyapps.io/WineQualityPrediction/

## About
This Shiny dashboard provides a prediction of wine quality based on user inputs for various wine attributes. It takes into account citric acid level, residual sugar, density, pH, and alcohol level to predict the quality of the wine on a scale between 5 and 6. The dashboard then classifies the quality as either high or low based on a threshold of 5.2.

## Motivation

The motivation behind this dashboard is to provide a simple and interactive tool for users to explore how different wine attributes can affect the perceived quality of wine. By allowing users to input these attributes, the dashboard provides immediate feedback on the predicted quality, helping users gain insights into what makes a wine high or low quality based on these specific attributes.

## App description
This Shiny app is a user-friendly dashboard where users can input values for citric acid level, residual sugar, density, pH, and alcohol level to predict the quality of wine. The app uses a random forest model to make predictions and then classifies the quality as either high or low based on a threshold value. Users can quickly see how changing these input values affects the predicted quality of the wine.

![alt text](https://github.com/riyaeliza123/Shiny-Dashboard-Wine-Prediction/blob/main/img/prototypes/V4.png)

## Manual installation steps
(If you wish to run it locally)

1.**Clone the repository**:
```
git clone https://github.com/riyaeliza123/Shiny-Dashboard-Wine-Prediction.git
```

2.**Install the environment**:
```
conda env create --name 532_ind_proj_riya --file=environment.yml
```

3.**Activate the environment**:
```
conda activate 532_ind_proj_riya
```
4.**Run the app**:
```
library(shiny)
runApp("app.R")
```
5.**Access the app**:
Once the app is running, you can access it by opening a web browser and navigating to the address provided in the R console. By default, it should be something like `http://127.0.0.1:port/`.
