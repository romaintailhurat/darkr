.onLoad <- function(libname, pkgname) {
  packageStartupMessage("Loading Trevas engine JAR.")
  rJava::.jpackage(pkgname, lib.loc = libname)
}

