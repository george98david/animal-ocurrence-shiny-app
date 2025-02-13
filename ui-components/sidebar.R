sidebar <-  
  shinydashboard::dashboardSidebar(
    #useShinyjs(),
    sidebarMenu(
      id = "sidebarMenu",
      menuItem(
        "Summary", 
        tabName = "tabSummary"
      )
    )
  )