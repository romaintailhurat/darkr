mock_df <- function() {
  data.frame(
    id = c("1", "2"),
    name = c("Hadrien", "Nico"),
    age = c("33", "34")
  )
}

mock_df_naw <- function() {
  data.frame(
    name = c("Hadrien", "Nico"),
    age = c(33, 35),
    weight = c(40, 35)
  )
}

cat_comp <- function(component) {
  cat(
    "Component name:", component$getName(),
    "/ Component type:", component$getType()$toString(),
    "/ Component role:", component$getRole()$toString()
  )
}

cat_datapoints_vector <- function(data_points_vec) {
  for (i in 1:data_points_vec@dimension) {
    element <- data_points_vec[[i]]
    cat(
      "Element", i, ":", element$toString(),
      "->", element$getClass()$toString(), "\n"
    )
  }
}
