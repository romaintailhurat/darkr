test_that("Evaluation is done right", {
  expression <- "a:= (3 + 2) * 4;"
  res <- vtl_eval(expression)
  expect_equal(res, 20)
})
