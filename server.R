server <- function(input, output, session){
  
  dataSpeciesPoland <- 
    reactive({
      dfAnimalPoland
    })
  output$outDtAnimalPoland <-
    renderDT({
      datatable(
        dataSpeciesPoland(),
        extensions = list('Scroller' = NULL),
        escape = F,
        selection = "single",
        class = 'cell-border stripe',
        options = list(
          pageLength   = 10,
          autoWidth    = F,
          scroller     = T,
          scrollX      = T,
          dom          = 'ti',
          deferRender  = T,
          scrollY      = 500
        )
      ) %>%
        formatStyle(
          'gbifID',
          fontWeight = 'bold'
        )
    })
  
  output$outSummary <-
    renderUI({
        fluidRow(
          column(
            width = 12,
            fluidRow(
              shinydashboard::box(
                width = 8,
                status = "success",
                withSpinner(DT::DTOutput("outDtAnimalPoland"))
              ),
              shinydashboard::box(
                width = 4,
                status = "success",
                title = "Summary",
                uiOutput("imgSpecies")
              )
            )
          )
        )
    })
  
  output$imgSpecies <- renderUI({
    req(input$outDtAnimalPoland_rows_selected)
    
    idOccurr <- dfAnimalPoland$id[input$outDtAnimalPoland_rows_selected]
    urlImg <-
      dfSpeciesPolandImg %>% 
        filter(gbifID == idOccurr) %>%
        select(identifier) %>% pull()
    
    if(length(urlImg) == 0){
      urlImg <- "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPUvFfPPOkbPc_TFDcRBsSysBhmgZWhLGtPw&s"
    }
    
    tags$img(
      src = urlImg[1], 
      width = "100%", 
      style = "display: block; margin: auto;"
    )
  })
}