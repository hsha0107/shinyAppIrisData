#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)
library(reshape2)
library(e1071)
library(randomForest)

# Define server logic to perform operations
shinyServer(function(input, output) {
  output$plot <- renderPlot({
    if(input$xvar==input$yvar){
      g <- ggplot(NULL, aes(iris$Species, iris[[input$xvar]]))
      g <- g + geom_boxplot(data = iris, aes(color=Species), size = 0.25)
      g + labs(title =" boxplot", x = "Species", y = input$xvar)
    }
    else{
      g <- ggplot(NULL, aes(iris[[input$xvar]], iris[[input$yvar]]))
      g <- g + geom_point(data = iris, aes(color=Species), size = 2.5)
      g + labs(title =" scatterplot", x = input$xvar, y = input$yvar)
    }
  })
  PredFunction <- reactive({
    set.seed(input$seed)
    intrain <- createDataPartition(iris$Species, p = as.numeric(input$inTrain), list = F)    
    Training <- iris[intrain, ]
    Testing <- iris[-intrain, ]
    Model <- train(Species~., data = Training, method = input$model)
    Pred <- predict(Model, Testing)
    newIris <- data.frame("Sepal.Length" = input$SLength, "Sepal.Width" = input$SWidth,
                          "Petal.Length" = input$PLength, "Petal.Width" = input$PWidth)
    newPred <- predict(Model, newIris)
    list(confusionMatrix(Pred, Testing$Species), newPred)
  })
  output$table <- renderTable({
    predTable <- data.frame(PredFunction()[[1]]$table)
    predTable$Reference <- paste("true.", predTable$Reference, sep = "")
    dcast(predTable, Prediction ~ Reference)
  })
  output$text1 <- renderText({
    PredFunction()[[1]]$overall[1]
  })
  output$text2 <- renderText({
    PredFunction()[[1]]$overall[2]
  })
  output$text3 <- renderText({
    as.character(PredFunction()[[2]])
  })
})
