

test_that("Evaluation is done right", {
  expression <- "a:= (3 + 2) * 4;"
  res <- vtl_eval(expression)
  expect_equal(res, 20)
})

test_that("Datasets, drop operation", {
  df <- mock_df_naw()
  ds <- df_to_ds(df)
  res <- vtl_eval("res := ds[ drop age ];", ds)
  expect_equal(
    res$getClass()$toString(),
    "class fr.insee.vtl.model.InMemoryDataset"
    )
  expect_equal(
    length(res$getDataStructure()$toArray()),
    2
  )
  expect_equal(
    res$getDataStructure()$toArray()[[1]]$getName(),
    "name"
  )
  expect_equal(
    res$getDataStructure()$toArray()[[2]]$getName(),
    "weight"
  )
})
