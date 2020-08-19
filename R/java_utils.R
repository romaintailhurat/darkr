#' This module provides functions helping with Java calls

#' Create a `Map` from a vector of arguments to the `of` static method
#' @param args_vector A vector of argument
#' @return A Java Map
#' @usage
#'   create_map(c("name", "Hadrien"))
#'   create_map(row_to_map_args(c("NAME", "AGE"), c("Hadrien", 34)))
create_map <- function(args_vector) {
  do.call(
    J("java/util/Map")$of,
    as.list(args_vector)
  )
}

#'
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
