#' Temporarily set debugging compilation flags.
#'
#' @param code to execute.
#' @param CFLAGS flags for compiling C code
#' @param CXXFLAGS flags for compiling C++ code
#' @param FFLAGS flags for compiling Fortran code.
#' @param FCFLAGS flags for Fortran 9x code.
#' @inheritParams withr::with_envvar
#' @inheritParams compiler_flags
#' @family debugging flags
#' @export
#' @examples
#' flags <- names(compiler_flags(TRUE))
#' with_debug(Sys.getenv(flags))
#'
#' \dontrun{
#' install("mypkg")
#' with_debug(install("mypkg"))
#' }
with_debug <- function(code, CFLAGS = NULL, CXXFLAGS = NULL,
                       FFLAGS = NULL, FCFLAGS = NULL, debug = TRUE) {

  defaults <- compiler_flags(debug = debug)
  flags <- c(
    CFLAGS = CFLAGS, CXXFLAGS = CXXFLAGS,
    FFLAGS = FFLAGS, FCFLAGS = FCFLAGS
  )

  flags <- unlist(utils::modifyList(as.list(defaults), as.list(flags)))

  withr::with_makevars(flags, code)
}
