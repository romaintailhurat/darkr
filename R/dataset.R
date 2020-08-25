check_df <- function(df) {
  if (!is.data.frame(df)) {
    stop("The parameter should be a dataframe.")
  }
  if (is.null(dim(df))) {
    stop("The dataframe must not be empty.")
  }
}

df_to_ds <- function(df) {
  check_df(df)

  data <- df_to_data(df)
  components <- df_to_component_list(df)
  ds <- create_in_memory_dataset(data, components)
}

df_to_component_list <- function(df) {
  check_df(df)
  role_enum <- rJava::J(JAVA_FQN$VTL$Dataset)$Role
  components_list <- lapply(names(df), function(col_name) {
    if(col_name == "id") {
      create_component(col_name, rJava::J(JAVA_FQN$Lang$String)$class, role_enum$IDENTIFIER)
    } else {
      k <- class(df[[ col_name ]])
      klass <- to_java_type(k)
      create_component(col_name, klass, role_enum$MEASURE)
    }
  })
  list_of(components_list)
}

df_to_data <- function(df) {
  rows_list <- sapply(as.data.frame(t(df)), function(row) list_of(row))
  list_of(rows_list)
}

to_java_type <- function(rtype) {
  if (rtype == "character") {
    type <- rJava::J(JAVA_FQN$Lang$String)$class
  }
  if (rtype == "double" | rtype == "numeric") {
    type <- rJava::J(JAVA_FQN$Lang$Double)$class
  }
  type
}
