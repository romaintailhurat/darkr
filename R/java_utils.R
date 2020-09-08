#' This module provides functions helping with Java calls

JAVA_FQN <- list(
  "Lang" = list(
    "String" = "java/lang/String",
    "Double" = "java/lang/Double",
    "Long" = "java/lang/Long"
  ),
  "VTL" = list(
    "Dataset" = "fr/insee/vtl/model/Dataset",
    "InMemoryDataset" = "fr/insee/vtl/model/InMemoryDataset"
  )

)

#' Create a `Map` from a vector of arguments to the `of` static method.
#'
#' @param args_vector A vector of argument
#' @return A Java Map
#' @usage
#'   map_of(c("name", "Hadrien"))
#'   map_of(row_to_map_args(c("NAME", "AGE"), c("Hadrien", 34)))
map_of <- function(args_vector) {
  do.call(
    rJava::J("java/util/Map")$of,
    as.list(args_vector)
  )
}

#' Create a `List` from a vector of arguments using the `of` static method.
#'
#' @param args_vector A vector of argument
#' @return A Java List
list_of <- function(...) {
  if(length(list(...)) == 1) {
    if(is.list(...)) {
      do.call(
        rJava::J("java/util/List")$of,
        ...
      )
    } else {
      do.call(
        rJava::J("java/util/List")$of,
        list(...)
      )
    }
  } else  {
    do.call(
      rJava::J("java/util/List")$of,
      list(...)
    )
  }
}

#' Provided with a list of keys (names of a row) and a list of values (from the row),
#' this function return a vector that will be arguments to `map_of`.
#' @usage
#'   row_to_map_args(c("NAME", "AGE"), c("Hadrien", 34))
#'   # "NAME"    "Hadrien" "AGE"     "34"
row_to_map_args <- function(names, values) {
  map_args <- unlist(
    mapply(list, names, values, SIMPLIFY = FALSE)
  )
  names(map_args) <- NULL
  map_args
}


create_component <- function(name, klass, role) {
  Component <- rJava::J("fr/insee/vtl/model/Dataset$Component")
  rJava::new(Component, name, klass, role)
}

create_in_memory_dataset <- function(data, components) {
  rJava::new(rJava::J(JAVA_FQN$VTL$InMemoryDataset), data, components)
}
