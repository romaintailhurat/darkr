#' This module provide evaluation functions for VTL expressions
#' @author Romain Tailhurat

#' Helper to add an object to the engine context.
#' @param context an engine context
#' @param obj an object, for example a dataset
set_context <- function(context, obj) {
  SC <- rJava::J("javax/script/ScriptContext")
  context$setAttribute(
    deparse(substitute(obj)),
    obj,
    SC$ENGINE_SCOPE
    )
  context
}

#' Evaluate a VTL expression, with bindings if necessary;
#' @param vtl_expression a string being a valid VTL expression
#' @param bindings the provided bindings
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
