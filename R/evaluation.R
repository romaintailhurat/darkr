#' This module provide evaluation functions for VTL expressions
#' @author Romain Tailhurat

set_context <- function(context, obj) {
  SC <- rJava::J("javax/script/ScriptContext")
  context$setAttribute(
    deparse(substitute(obj)),
    obj,
    SC$ENGINE_SCOPE
    )
  context
}

vtl_eval <- function(vtl_expression, bindings = NULL) {
  engine <- get_engine()
  # TODO for now, we only support one binding
  if (!is.null(bindings)) {
    context <- engine$getContext()
    SC <- rJava::J("javax/script/ScriptContext")
    context$setAttribute(deparse(substitute(bindings)), bindings, SC$ENGINE_SCOPE)
  }
  engine$eval(vtl_expression)
}
