#' This module provides functions helping with Java calls

JAVA_FQDN <- list(
  "Lang" = list(
    "String" = "java/lang/String",
    "Double" = "java/lang/Double"
  ),
  "VTL" = list(
    "Dataset" = "fr/insee/vtl/model/Dataset"
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
    J("java/util/Map")$of,
    as.list(args_vector)
  )
}

#' Create a `List` from a vector of arguments using the `of` static method.
#'
#' @param args_vector A vector of argument
#' @return A Java Map
list_of <- function(args_vector) {
  do.call(
    J("java/util/List")$of,
    as.list(args_vector)
  )
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
