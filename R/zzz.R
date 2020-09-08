.onLoad <- function(libname, pkgname) {
  cat("Loading Trevas engine JAR \n")
  rJava::.jpackage(pkgname, lib.loc = libname)
}

