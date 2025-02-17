# 📊 My Shiny Application

An interactive application for visualizing observed species on a map using data from the Global Biodiversity Information Facility (GBIF).

## 📖 Description
This application provides a comprehensive view of species occurrences based on biodiversity data from GBIF. Users can explore the distribution of observed species through an interactive map and analyze trends over time. The dataset can be downloaded from the official GBIF website, ensuring up-to-date and reliable information. Additionally, a timeline graph is generated to display the number of individuals observed per day, offering insights into biodiversity patterns.

## 🚀 Features
- Interactive species occurrence map, powered by leaflet visual package.
- Dynamic data visualization
- Interactive species name and scientific filtering
- Graphs and tables
- Maps 
- Timeline graph showing the number of individuals seen per day

## 🛠 Requirements
- R "R version 4.2.2"
- RStudio
- `renv` for dependency management

## 📥 Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/george98david/animal-ocurrence-shiny-app.git
   cd .../local/animal-ocurrence-shiny-app
   ```
2. Restore dependencies using `renv`:
   ```r
   install.packages("renv")
   renv::restore()
   ```
3. Run the application:
   ```r
   shiny::runApp("app.R")
   ```

## 📡 Deployment
You can find a preview on this link:

## 🛠 Workflows and GitHub Actions
This project includes automated unit tests that run on each push to the repository. The tests ensure that core functionalities of the Shiny app work correctly. The following tests are implemented:

- **Application loads correctly**: Ensures the app initializes without errors and key UI elements are displayed.
- **Species filter works correctly**: Tests that selecting different species updates the data accordingly.
- **Selecting a row updates the UI**: Verifies that selecting an observation updates related output elements.
- **Map updates correctly after selection**: Ensures that selecting a row correctly updates the displayed map.
- **Timeline plot updates correctly**: Tests that selecting an observation updates the timeline plot.

These tests are implemented using `shinytest2` and `testthat` within the GitHub Actions workflow as part of the CI/CD pipelines.

## 📌 Contributions
David Basualdo: jorgedavid.basualdo@gmail.com
