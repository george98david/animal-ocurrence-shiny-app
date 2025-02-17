#
# This is a Shiny web application. You can run the application by clicking
# Autor -> David Basualdo
#
#-------------------------------------------------------------------------
source("server.R")
source("ui.R")

# Run the application 
shinyApp(ui = ui, server = server)
