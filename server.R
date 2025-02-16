server <- function(input, output, session){
  
  dataSpeciesPoland <- 
    reactive({
      req(input$filter1)
      dfAnimalPoland %>%
        {
          data = .
          if(input$filter1 != "SELECT ALL"){
            data %>%
              filter(vernacularName %in% sub(" /.*", "", input$filter1))
          }else{
            data 
          }
        }
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
                width = 6, height = "40em",
                status = "success",
                withSpinner(DT::DTOutput("outDtAnimalPoland"))
              ),
              shinydashboard::box(
                width = 6, height = "40em",
                status = "success",
                title = "Summary",
                style = "text-align: center;",
                tabsetPanel(
                  tabPanel("👀 Overview", uiOutput("outTabOverview")),
                  tabPanel("📊 Timeline", plotlyOutput("plotTimeline"))
                ),
              )
            )
          )
        )
      
    })
  
  output$plotTimeline <- renderPlotly({
    req(input$outDtAnimalPoland_rows_selected)
    vernName <- dataSpeciesPoland()$vernacularName[input$outDtAnimalPoland_rows_selected]
    
    dataSpeciesPoland() %>%
      filter(vernacularName == vernName) %>%
      plot_ly() %>%
      add_segments(
        x = ~eventDatetime, xend = ~eventDatetime, 
        y = 0, yend = ~individualCount,
        line = list(
          dash = "dot", 
          color = 'gray', 
          width = 1
        )
      ) %>%
      add_trace(
        x = ~eventDatetime, y = ~individualCount, 
        type = 'scatter', mode = 'markers',
        marker = list(
          size = 8, 
          color = '#008602'
        )
      ) %>%
      layout(
        xaxis = list(
          title = "Date", 
          showgrid = F,
          rangeslider = list(visible = T)
        ),
        yaxis = list(
          title = "Individual Count", 
          showgrid = T, 
          zeroline = T, 
          zerolinecolor = "grey", 
          zerolinewidth = 1, 
          titlefont = list(
            size = 14,
            tickformat=',d'
          )
        ),
        plot_bgcolor = "#fdf6fb",
        showlegend = F
      ) %>%
      config(
        scrollZoom = T,
        displayModeBar = F
      )
  })
  
  output$outPickerSpcName <- renderUI({
    choices <-
      dfAnimalPoland[,.(count = .N, sum = sum(individualCount)) ,by = c("vernacularName", "scientificName")][order(-count)] %>%
        mutate(Species_Features = "{vernacularName} / {scientificName} / Occurrences: {count}, Ind Count: {sum}" %>% glue() %>% as.character()) %>%
        select(Species_Features)
    choices <- rbind(data.table(Species_Features = "SELECT ALL"), choices) 

    shinyWidgets::pickerInput(
      inputId = "filter1",
      label = NULL,
      selected = NULL,
      choices = choices,
      multiple = F,
      options = list(
        `actions-box` = T,
        `live-search` = T,
        `style` = "btn-success"
      )
    )
  })
  
  output$outTabOverview <- renderUI({
    tags$div(
      uiOutput("outputSpecies"),
      uiOutput("outTaxonomy"),
      fluidRow(
        column(
          width = 6,
          uiOutput("imgSpecies")
        ),
        column(
          width = 6,
          tags$div(
            style = 
              "
                          width: 250px; height: 250px;
                          display: block; 
                          margin: auto; 
                          border: 6px solid black; background-color: black;
                          object-fit: contain;
                        ",
            leafletOutput("mapSpecies", width = "100%", height = "100%")
          )
        )
      ),
      uiOutput("outLocation")
    )
  })
  
  output$outputSpecies <- renderUI({
    req(input$outDtAnimalPoland_rows_selected)
    vernName <- dataSpeciesPoland()$vernacularName[input$outDtAnimalPoland_rows_selected]
    sciName <- dataSpeciesPoland()$scientificName[input$outDtAnimalPoland_rows_selected]
      tags$div(
        tags$h2(vernName, style = "font-weight: bold; margin-bottom: -10px;"),
        tags$h5(sciName, style = "font-style: italic;")
      )
    
  })
  
  output$outTaxonomy <- renderUI({
    taxonomy <- dataSpeciesPoland()$taxonomy[input$outDtAnimalPoland_rows_selected]
    if(length(taxonomy) != 0){
      style <- "display: block; margin-bottom: 20px; font-family: helvetica;"
      
    }else{
      taxonomy <- "NO TAXONOMY SELECTION"
      style <- "display: block; margin-bottom: 20px; color: red; font-family: helvetica;"
    }
    
    tags$b(taxonomy, style = style)
  })
  
  output$outLocation <- renderUI({
    location <- dataSpeciesPoland()$location[input$outDtAnimalPoland_rows_selected]
    if(length(location) != 0){
      style <- "display: block; margin-top: 20px; font-family: helvetica;"
      
    }else{
      location <- "NO LOCATION SELECTED"
      style <- "display: block; margin-top: 20px; color: red; font-family: helvetica;"
    }
    
    tags$b(location, style = style)
  })
  
  output$imgSpecies <- renderUI({
      idOccurr <- dataSpeciesPoland()$id[input$outDtAnimalPoland_rows_selected]
      if(length(idOccurr) != 0){
        urlImg <-
          dfSpeciesPolandImg %>% 
          filter(gbifID == idOccurr) %>%
          select(identifier) %>% pull()
        if(length(urlImg) == 0){
          urlImg <- "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPUvFfPPOkbPc_TFDcRBsSysBhmgZWhLGtPw&s"
        }
      }else{
        urlImg <- "please_bull.jpg"
      }
    
    tags$img(
      src = urlImg[1],
      style = "
        width: 250px; height: 250px; 
        display: block; 
        margin: auto; 
        border: 6px solid black; background-color: black;
        object-fit: contain;
      "
    )
  })
  
  output$mapSpecies <- renderLeaflet({
    latitud <- dataSpeciesPoland()$decimalLatitude[input$outDtAnimalPoland_rows_selected]
    longitude <- dataSpeciesPoland()$decimalLongitude[input$outDtAnimalPoland_rows_selected]
    
    vernName <- dataSpeciesPoland()$vernacularName[input$outDtAnimalPoland_rows_selected]
  
    leaflet(
      options = leafletOptions(attributionControl = F)
    ) %>% 
    addTiles() %>%
    {
      map <- .
      zoom <- 4
      
      if(length(latitud) != 0){
        dataLatLong <-
          dataSpeciesPoland() %>%
          filter(vernacularName == vernName)
        
        map <-  
          map %>% 
          addMarkers(longitude, latitud) %>%
          addCircleMarkers(
            data = dataLatLong,
            lat = ~decimalLatitude,
            lng = ~decimalLongitude,
            label = ~lapply(
              "
                ocurrence: {id}<br>
                date: {eventDatetime}<br>
                ind_count: {individualCount}<br>
                coordinates: ({decimalLatitude}, {decimalLongitude})
              " %>% glue(),HTML),
            layerId = ~id,
            #popup = ~location,  
            color = "red", 
            radius = 2,
            fillOpacity = 0.3,
            labelOptions = labelOptions(
              style = list(
                "font-weight" = "bold",
                "color" = "white",
                "background-color" = "#419848",
                "padding" = "5px"
              ),
              textsize = "8px",
              direction = "auto"
            ),
          ) %>%
          setView(lat = latitud, lng = longitude, zoom = 6)
      }else{
        map <-
          map %>%
          setView(lat = 52, lng = 20, zoom = 4)
      }
      map %>% 
        addProviderTiles("Esri.WorldStreetMap")
    }
  })
  
  observeEvent(dataSpeciesPoland(), {
    req(nrow(dataSpeciesPoland()) > 0)
    
    isolate({
      if(input$filter1 != "SELECT ALL"){
        dataTableProxy("outDtAnimalPoland") %>% selectRows(1)
      }
    })
  }, ignoreInit = TRUE)
  
  observeEvent(input$mapSpecies_marker_click, {
    req(input$mapSpecies_marker_click$id)

    selRow <- which(dataSpeciesPoland()$id == input$mapSpecies_marker_click$id)
    
    dataTableProxy("outDtAnimalPoland") %>% selectRows(selRow)
  })
}