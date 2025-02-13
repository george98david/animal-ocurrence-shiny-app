header <-
  dashboardHeader(
    tags$li(
      class = "dropdown",
      tags$script(src = "https://kit.fontawesome.com/<you>.js"),
      tags$style("")
    )
  )

header$children[[2]]$children <-  
  tags$a(
    tags$img(
      src    = 'https://www.gbif.org/img/full_logo_white.svg',
      height = '50',
      width  = '150'
    )
  )