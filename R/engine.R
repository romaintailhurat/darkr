#' This is the main entry point to the API.
#' @author Romain Tailhurat

#' Provides a simple way to create a VTL script engine.
#' @return a script engine
get_engine <- function() {
  #FIXME is there a way to properly cache the cal to the engine factory
  #FIXME or cache the engine ifself?
  script_engine_factory <- rJava::.jnew(class = "fr/insee/vtl/engine/VtlScriptEngineFactory")
  engine <- script_engine_factory$getScriptEngine()
}


