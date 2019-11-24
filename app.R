library(data.table)
library(ggplot2)
library(shiny)

ui <- fluidPage(
  titlePanel("Visual 2D of Linear Transformation"), 
  
  # Entries of the 2x2 matrix, arrange din matrix format. 
  sidebarLayout(
    sidebarPanel(
      splitLayout(
        numericInput(inputId="11", label = "(1,1)", value = 1), 
        numericInput(inputId="12", label = "(1,2)", value = 0)
      ), 
      splitLayout(
        numericInput(inputId="21", label = "(2,1)", value = 0), 
        numericInput(inputId="22", label = "(2,2)", value = 1)
      )
    ), 
    mainPanel(
      plotOutput("finalPlot")
    )
  )
)

# Data frame of points to plot
df <- data.table(x = c(0,1), y = c(0,1))

server <- function(input, output){
  createMatrix <- reactive({
    matrix(c(input$`11`, input$`21`, input$`12`, input$`22`), nrow = 2)
  })
  
  output$finalPlot <- renderPlot({
    # Plot points of end of vector and origin
    new_vector <- createMatrix() %*% c(1,1)
    df <- rbind(df, data.table(x = new_vector[1], y = new_vector[2]))
    ggplot(df) +
      geom_point(aes(x,y), size = 2) + 
      geom_segment(aes(x = 0, y = 0, xend = 1, yend = 1),size=1) + 
      geom_segment(aes(x = 0, y = 0, xend = new_vector[1], yend = new_vector[2]), size = 1, col = "red") + 
      coord_cartesian(xlim = c(-10,10), ylim = c(-10,10)) + 
      theme_bw() + 
      geom_hline(yintercept = 0) + 
      geom_vline(xintercept = 0)
      
  })
}

shinyApp(ui, server)