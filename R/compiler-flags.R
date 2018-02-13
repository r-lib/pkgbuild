#' Default compiler flags used by devtools.
#'
#' These default flags enforce good coding practice by ensuring that
#' \env{CFLAGS} and \env{CXXFLAGS} are set to `-Wall -pedantic`.
#' These tests are run by cran and are generally considered to be good practice.
#'
#' By default [compile_dll()] is run with `compiler_flags(TRUE)`,
#' and check with `compiler_flags(FALSE)`.  If you want to avoid the
#' possible performance penalty from the debug flags, install the package.
#'
#' @param debug If `TRUE` adds `-g -O0` to all flags
#'   (Adding \env{FFLAGS} and \env{FCFLAGS}
#' @family debugging flags
#' @export
#' @examples
#' compiler_flags()
#' compiler_flags(TRUE)
compiler_flags <- function(debug = FALSE) {
  res <-
    if (Sys.info()[["sysname"]] == "SunOS") {
    c(
      CFLAGS   = "-g",
      CXXFLAGS = "-g",
      CXX11FLAGS = "-g"
    )
  } else if (debug) {
    c(
      CFLAGS   = "-UNDEBUG -Wall -pedantic -g -O0",
      CXXFLAGS = "-UNDEBUG -Wall -pedantic -g -O0",
      CXX11FLAGS = "-UNDEBUG -Wall -pedantic -g -O0",
      FFLAGS   = "-g -O0",
      FCFLAGS  = "-g -O0"
    )
  } else {
    c(
      CFLAGS   = "-Wall -pedantic",
      CXXFLAGS = "-Wall -pedantic",
      CXX11FLAGS = "-Wall -pedantic"
    )
  }

  if (crayon::has_color() && has_compiler_colored_diagnostics()) {
    res[c("CFLAGS", "CXXFLAGS", "CXX11FLAGS")] <-
      paste(res[c("CFLAGS", "CXXFLAGS", "CXX11FLAGS")], "-fdiagnostics-color=always")
  }
  res
}

has_compiler_colored_diagnostics <- function() {
  if (cache_exists("has_compiler_colored_diagnostics")) {
    return(cache_get("has_compiler_colored_diagnostics"))
  }

  # We cannot use the existing has_compiler setting, because it may not have
  # run with -fdiagnostics-color=always
  if (cache_exists("has_compiler")) {
    old <- cache_get("has_compiler")
    cache_remove("has_compiler")
    on.exit(cache_set("has_compiler", old))
  } else {
    on.exit(cache_remove("has_compiler"))
  }

  res <- withr::with_makevars(c(CFLAGS = "-fdiagnostics-color=always"), has_compiler())

  cache_set("has_compiler_colored_diagnostics", res)
  res
}
