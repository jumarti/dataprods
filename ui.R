library(shiny) 
shinyUI(pageWithSidebar(
  headerPanel("Predict your child's height"), 
  sidebarPanel(
    numericInput('parent_height', 'Your height', 170, min=1, step=0.1),
    radioButtons('units', "Units", 
                 c("centimeters", "inches"))
    ),
  mainPanel(
    p("This predcition comes from a Linear Model Fit over Galton's parents-height data"),
    p("Input your height, making sure of using the right units."),
    p("The linear model fit prediction with a plot is shown."),
    h3('Prediction'),
    textOutput('result'),
    plotOutput('plot')
    
    
  ) 
))