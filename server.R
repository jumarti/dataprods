library(shiny) 
library(ggplot2)
library(UsingR)
data_cm <- data.frame(
  child=galton$child*(1/0.393701),
  parent=galton$parent*(1/0.393701))
mod <- lm(child~parent, data=galton)
shinyServer(
  function(input, output) {
        
    child <- reactive({
      units <- input$units
      parent <- input$parent_height
      if (units == 'centimeters')
        parent <- parent*0.393701
      child <- predict(mod, data.frame(parent=parent))
      if (units == 'centimeters')
        child <- child*(1/0.393701)
    
      round(child, 1)

    })
    

    output$result <- renderText({
      paste("Your height of ", 
            input$parent_height, " ", input$units,
            " predicts a height of ",
            child(), " ", input$units, 
            " for your child"
            )  
    })
    
    output$plot <- renderPlot({
      parent <- input$parent_height
      if (input$units == 'centimeters'){
        g <- ggplot(data=data_cm, aes(x=parent, y=child))
      }
      else{
        g <- ggplot(data=galton, aes(x=parent, y=child))
      }
        
        
      g <- g + geom_smooth(method="lm")
      g <- g + geom_vline(xintercept=parent)
      g <- g + geom_hline(yintercept=child())
      g
      
    })
    

    
    
  } 

  )