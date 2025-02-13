bodySummary <-
  tabItem(
    tabName = "tabSummary",
    uiOutput("outSummary")
  )

body <-
  dashboardBody(
    #useShinyjs(),
    tabItems(
      bodySummary
    )
  )