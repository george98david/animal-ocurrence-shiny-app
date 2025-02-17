source("ui-components/header.R")
source("ui-components/body.R")
source("ui-components/sidebar.R")
source("ui-components/controlbar.R")

ui <- 
  dashboardPage(
    title = "Dashboard", 
    skin = "green",
    header = header,
    sidebar = sidebar,
    body = body
  )