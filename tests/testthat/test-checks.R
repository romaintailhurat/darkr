test_that("Checking dataset", {
  garbage <- NULL
  expect_error(check_ds(garbage), "The parameter type is not correct: NULL instead of S4")
  random_df <- data.frame(A = sample(1:100, 10))
  expect_error(check_ds(random_df), "The parameter type is not correct: list instead of S4")
  java_string <- rJava::.jnew(class = JAVA_FQN$Lang$String, "test")
  expect_error(
    check_ds(java_string),
    "The parameter should be of class fr/insee/vtl/model/InMemoryDataset not java/lang/String"
    )
})
