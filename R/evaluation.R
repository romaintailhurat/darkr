#' This module provide evaluation functions for VTL expressions
#' @author Romain Tailhurat

vtl_eval <- function(vtl_expression) {
  engine <- get_engine()
  engine$eval(vtl_expression)
}
