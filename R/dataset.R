#' Check if parameter is an non emtpy dataframe
#' @param df a dataframe
check_df <- function(df) {
  if (!is.data.frame(df)) {
    stop("The parameter should be a dataframe.")
  }
  if (is.null(dim(df))) {
    stop("The dataframe must not be empty.")
  }
}

#' Check if parameter is a valid dataset
#' @param ds a dataset
check_ds <- function(ds) {
  ds_type <- typeof(ds)
  if(ds_type != "S4") {
    msg <- paste("The parameter type is not correct:", ds_type, "instead of S4")
    stop(msg)
  }

  if(ds@jclass != JAVA_FQN$VTL$InMemoryDataset) {
    msg <- paste("The parameter should be of class", JAVA_FQN$VTL$InMemoryDataset, "not", ds@jclass)
    stop(msg)
  }
}

#' Transform a dataframe into a Java dataset.
#' This is the core feature of `darkr`: providing a bridge to the Java
#' representation of a VTL dataset in Trevas
#' @param df a dataframe
#' @export
df_to_ds <- function(df) {
  check_df(df)
  data <- df_to_data(df)
  components <- df_to_component_list(df)
  ds <- create_in_memory_dataset(data, components)
}

#' Transform a Trevas Java dataset into a dataframe.
#' @param ds a dataset
#' @export
ds_to_df <- function(ds) {
  check_ds(ds)
  columns <- list()
  ds_struct <- ds$getDataStructure()
  ds_struct_array <- ds_struct$toArray()
  data_points <- ds$getDataPoints()
  dp_array <- data_points$toArray()
  for (i in 1:length(ds_struct_array)) {
    current_component <- ds_struct_array[[i]]
    type <- current_component$getType() # TODO use it to type the dataframe columns
    col_vals <- c()
    for (j in 1:length(dp_array)) {
      row <- dp_array[[j]]
      ar <- row$toArray()
      col_vals <- c(col_vals, ar[[i]]$toString())
    }
    columns[[ current_component$getName() ]] <- col_vals
  }
  return(as.data.frame(columns))
}

df_to_component_list <- function(df) {
  check_df(df)
  role_enum <- rJava::J(JAVA_FQN$VTL$Dataset)$Role
  components_list <- lapply(names(df), function(col_name) {
    if(col_name %in% c("id", "name")) {
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
  check_df(df)
  rows_list <- sapply(as.data.frame(t(df)), function(row) {
    typed_row <- sapply(row, function(element) {
      # Checking if we can parse an element as a numeric
      if(!is.na(as.numeric(element))) {
        rJava::.jnew(JAVA_FQN$Lang$Long, element)
      } else {
        rJava::.jnew(JAVA_FQN$Lang$String, element)
      }
    })
    list_of(typed_row)
  })
  list_of(rows_list)
}

#' Map some R types to Java base classes.
#' @param rtype a vector type from R
to_java_type <- function(rtype) {
  type <- NULL
  if (rtype == "character") {
    type <- rJava::J(JAVA_FQN$Lang$String)$class
  }
  if (rtype == "double" | rtype == "numeric") {
    type <- rJava::J(JAVA_FQN$Lang$Long)$class
  }
  # FIXME handle other R types (as Object ?)
  type
}

to_rtype <- function(java_type) {
  type <- NULL
  if (java_type == "Java-Object{class java.lang.String}") {
    type <- "character"
  }
  type
}
