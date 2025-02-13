#
# global.R
#
# Autor -> David Basualdo
# Creation Date: 12-02-2025
#-------------------------------------------------------------------------

get_pol_animals_ocurrence <- 
  function(){
    pathDataset <- "./data/0000263-250212154643175/occurrence.txt"
    pathColumns <- "./data/columns_selection.csv"
    
    dfSps <- read.delim(pathDataset, sep = "\t", header = T)
    dfCol <- read.csv(pathColumns)
    
    #dfSps <-  dfSps %>% select(where(~any(!is.na(.)))) ###Was Used to filter valid Cols and then selected manually the needed cols
    
    r <- 
      dfSps %>%
        select(dfCol[,1]) %>%
        mutate(across(everything(), ~ replace(., is.null(.) | . == "", NA))) %>%
        mutate(
          id = gbifID,
          gbifID = '<a href="{occurrenceID}" target="_blank">{gbifID}</a>' %>% glue()
        ) %>%
        select(-occurrenceID)
    
    return(r)
  }

get_pol_species_ocurrence_img <-
  function(){
    pathDataset <- "./data/0000263-250212154643175/multimedia.txt"
    dfSps <- read.delim(pathDataset, sep = "\t", header = T)
    
    r <- 
      dfSps %>%
        select(
          gbifID,
          identifier
        )
    
    return(r)
  }
