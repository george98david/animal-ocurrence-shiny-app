source("./ui-Components/header.R")
source("./ui-Components/body.R")
source("./ui-Components/sidebar.R")
source("./ui-Components/controlbar.R")

ui <- 
  dashboardPage(
    title = "Dashboard", 
    skin = "green",
    header = header,
    sidebar = sidebar,
    body = body
  )