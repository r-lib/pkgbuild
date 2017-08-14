#' Are build tools are available?
#'
#' `has_build_tools` returns a logical, `check_build_tools` throws
#' an error. `with_build_tools` checks that build tools are available,
#' then runs `code` in an correctly staged environment.
#' If run interactively from RStudio, and the build tools are not
#' available these functions will trigger an automated install.
#'
#' @inheritParams has_rtools
#' @export
#' @examples
#' has_build_tools()
#' check_build_tools()
has_build_tools <- function(debug = FALSE) {
  check <- getOption("buildtools.check", NULL)
  if (!is.null(check)) {
    check("Building R package from source")
  } else if (is_windows()) {
    has_rtools(debug = debug)
  } else {
    has_compiler(debug = debug)
  }
}

#' @export
#' @rdname has_build_tools
check_build_tools <- function(debug = FALSE) {
  if (!has_build_tools(debug = debug))
    stop("Could not find tools necessary to compile a package", call. = FALSE)

  invisible(TRUE)
}

#' @export
#' @rdname has_build_tools
#' @param code Code to rerun in environment where build tools are guaranteed to
#'   exist.
#' @param required If `TRUE`, and build tools are not available,
#'   will throw an error. Otherwise will attempt to run `code` without
#'   them.
with_build_tools <- function(code, debug = FALSE, required = TRUE) {
  if (required)
    check_build_tools(debug = debug)

  if (has_rtools()) {
    withr::with_path(rtools_path(), code)
  } else {
    code
  }
}
