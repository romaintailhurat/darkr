test_that("Evaluation is done right", {
  expression <- "a:= (3 + 2) * 4;"
  res <- vtl_eval(expression)
  expect_equal(res, 20)
})

test_that("Datasets - filter", {
  # FIXME in order to pass this test :
  # https://github.com/InseeFr/Trevas/blob/master/vtl-engine/src/test/java/fr/insee/vtl/engine/visitors/ClauseVisitorTest.java#L28
  # we need to be able to give roles to components, for example with:
  # df_to_ds(df, c(<column_name> = <role>))
  df <- mock_df_naw()
  dataset <- df_to_ds(df)
  engine <- get_engine()
  context <- engine$getContext()
  SC <- rJava::J("javax/script/ScriptContext")
  context$setAttribute("ds1", dataset, SC$ENGINE_SCOPE)
  filtered_dataset <- engine$eval("ds := ds1[filter age = weigth];")
})
