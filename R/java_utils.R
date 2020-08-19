#' This module provides functions helping with Java calls

#' Create a `Map` from a vector of arguments to the `of` static method
#' @param args_vector A vector of argument
#' @return A Java Map
#' @usage create_map(c("name", "Hadrien"))
create_map <- function(args_vector) {
  do.call(
    J("java/util/Map")$of,
    as.list(args_vector)
  )
}
