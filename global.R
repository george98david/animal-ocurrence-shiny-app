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

#STATIC GLOBAL DATA (DOESN´T CHANGES OVER TIME) 
source("./functions/etl-pipelines.R")

dfAnimalPoland <- get_pol_animals_ocurrence()
dfSpeciesPolandImg <- get_pol_species_ocurrence_img()
