#' This is the main entry point to the API.
#' @author Romain Tailhurat

#' Provides a simple way to create a VTL script engine.
#' @return a script engine
get_engine <- function() {
  script_engine_factory <- rJava::.jnew(class = "fr/insee/vtl/engine/VtlScriptEngineFactory")
  script_engine_factory$getScriptEngine()
}


