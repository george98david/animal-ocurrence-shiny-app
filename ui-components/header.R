header <-
  dashboardHeader(
    title = tagList(
      span(class = "logo-lg", "GBIF Dashboard"),
      span(class = "logo-mini", icon("leaf"))
    ),
    leftUi = tagList(
      tags$head(
        tags$style(HTML("
          .navbar-custom-menu .shiny-input-container {
            margin: 0px; 
            padding: 0px;
          }
          .form-group .selectpicker, .air-datepicker {
            height: 30px !important;
            font-size: 12px !important;
            padding: 5px !important;
          }
          .dropdown-menu.inner {
            font-size: 12px !important;
          }
        "))
      ),
      uiOutput("outPickerSpcName")
    ),
    tags$li(
      class = "dropdown",
      tags$script(src = "https://kit.fontawesome.com/<you>.js"),
      tags$style(""
      )
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