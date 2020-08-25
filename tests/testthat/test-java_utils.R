test_that("Instantiate InMemoryDataset", {
  role_enum <- rJava::J(JAVA_FQN$VTL$Dataset)$Role
  data <- list_of(
    list_of("Hadrien", "33"),
    list_of("Nico", "35")
  )
  components <- list_of(
      create_component(
        "name", rJava::J("java/lang/String")$class, role_enum$MEASURE
      ),
      create_component(
        "age", rJava::J("java/lang/Double")$class, role_enum$MEASURE
      )
    )
  ds <- create_in_memory_dataset(data, components)
  expect_equal(ds$getClass()$toString(), "class fr.insee.vtl.model.InMemoryDataset")
})
