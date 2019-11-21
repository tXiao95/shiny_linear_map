library(shiny)

ui <- pageWithSidebar(
  
  # App title ----
  headerPanel("Visual Display of 2D Linear Map"),
  
  # Sidebar panel for inputs ----
  sidebarPanel(), 
  
  # Main panel for displaying outputs ----
  mainPanel()
)

server <- function(input, output) {
  
}

shinyApp(ui, server)