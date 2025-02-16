#
# global.R
#
# Autor -> David Basualdo
# Creation Date: 12-02-2025
#-------------------------------------------------------------------------

library(shiny)

library(shinydashboard)
library(shinydashboardPlus)
library(shinycssloaders)

library(data.table)
library(DT)
library(dplyr)
library(dtplyr)
library(glue)
library(bslib)
library(leaflet)
library(bit64)
library(plotly)

#STATIC GLOBAL DATA (DOESN´T CHANGE OVER TIME) 
source("./R/etl/etl-pipelines.R")

dfAnimalPoland <- get_pol_animals_ocurrence()
dfSpeciesPolandImg <- get_pol_species_ocurrence_img()
