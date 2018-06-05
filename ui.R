#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict Species of Iris with Edgar Anderson's Iris Data"),
  
  # Sidebar with different inputs 
  sidebarLayout(
    sidebarPanel(
      h3("Draw a Plot"),
      selectInput("xvar", h5("Select x variable"), 
                  choices = list("Sepal.Length" = "Sepal.Length",
                                 "Sepal.Width" = "Sepal.Width",
                                 "Petal.Length" = "Petal.Length",
                                 "Petal.Width" = "Petal.Width"),
                  selected = "Sepal.Length"),
      selectInput("yvar", h5("Select y variable"), 
                  choices = list("Sepal.Length" = "Sepal.Length",
                                 "Sepal.Width" = "Sepal.Width",
                                 "Petal.Length" = "Petal.Length",
                                 "Petal.Width" = "Petal.Width"),
                  selected = "Sepal.Width"),
      h3("Run Prediction Model"),
      numericInput("seed", h5("Select a seed number"),
                   value = 1),
      radioButtons("inTrain", h5("Percentage of Data in Traing Set"), 
                   choices = list("60%" = 0.6, "70%" = 0.7,
                                  "80%" = 0.8), selected = 0.6),
      radioButtons("model", h5("Choose a Prediction Model"), 
                   choices = list("k-nearest Neighbors" = "knn", "Decision Tree" = "rpart",
                                  "Random Forest" = "rf"), selected = "knn"),
      h3("Make New Iris Observation"),
      sliderInput("SLength", h5("Sepal.Length"), min = 4, max = 8, 
                  value = 5.8, step = 0.1),
      sliderInput("SWidth", h5("Sepal.Width"), min = 2, max = 5, 
                  value = 3, step = 0.1),
      sliderInput("PLength", h5("Petal.Length"), min = 1, max = 7, 
                  value = 4.3, step = 0.1),
      sliderInput("PWidth", h5("Petal.With"), min = 0.1, max = 3, 
                  value = 1.3, step = 0.1)
    ),
    
    mainPanel(
      plotOutput("plot"),
      br(),
      h4("Access Performance of the Model on Testing Set"),
      tableOutput("table"),
      h5(strong("Accuracy:")),
      textOutput("text1"),
      h5(strong("Kappa:")),
      textOutput("text2"),
      br(),
      h4("Based on the chosen Prediction Model, the Species of New Iris Observation is"),
      strong(textOutput("text3"))
    )
  )
))
