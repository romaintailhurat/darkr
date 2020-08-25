test_that("Creating a list of components from a dataframe", {
  df <- mock_df()
  cmps_list <- df_to_component_list(df)

  expect_equal(cmps_list$size(), 3)
})

test_that("Can create a list of data from a df", {
  df <- mock_df()
  extracted_data <- df_to_data(df)

  expect_equal(extracted_data$size(), 2)
})

test_that("Can create a dataset from a dataframe", {
  df <- mock_df()
  ds <- df_to_ds(df)

  expect_equal(
    ds$getClass()$toString(),
    "class fr.insee.vtl.model.InMemoryDataset"
  )
})
