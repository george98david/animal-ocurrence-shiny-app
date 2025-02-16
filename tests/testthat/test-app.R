library(shinytest2)
library(testthat)

# Test that the application loads correctly
test_that("Application loads correctly", {
  app <- AppDriver$new()
  
  expect_no_error(app$expect_screenshot())

  expect_true(app$find_element("#filter1")$is_displayed())
  expect_true(app$find_element("#outDtAnimalPoland")$is_displayed())
  
  app$stop()
})

# Test that the species filter works correctly
test_that("Species filter works correctly", {
  app <- AppDriver$new()
  
  # Select a value from the species pickerInput
  app$set_inputs(filter1 = "SELECT ALL")
  Sys.sleep(1)
  expect_true(nrow(app$get_value("outDtAnimalPoland")) > 0)
  
  app$stop()
})

# Test that selecting a row updates the UI
test_that("Selecting a row updates the UI", {
  app <- AppDriver$new()
  
  app$set_inputs(outDtAnimalPoland_rows_selected = 1)
  Sys.sleep(1)
  
  expect_true(app$find_element("#outputSpecies")$is_displayed())
  expect_true(app$find_element("#outTaxonomy")$is_displayed())
  expect_true(app$find_element("#outLocation")$is_displayed())
  
  app$stop()
})

# Test that the map updates correctly after selection
test_that("Map updates correctly after selection", {
  app <- AppDriver$new()
  
  app$set_inputs(outDtAnimalPoland_rows_selected = 1)
  Sys.sleep(1)

  expect_true(app$find_element("#mapSpecies")$is_displayed())
  
  app$stop()
})

# Test that the timeline plot updates correctly
test_that("Timeline plot updates correctly", {
  app <- AppDriver$new()

  app$set_inputs(outDtAnimalPoland_rows_selected = 1)
  Sys.sleep(1)

  expect_true(app$find_element("#plotTimeline")$is_displayed())
  
  app$stop()
})
