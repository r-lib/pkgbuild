#' Are build tools are available?
#'
#' \code{has_build_tools} returns a logical, \code{check_build_tools} throws
#' an error. If run interactively from RStudio, and the built-tools are not
#' available either function will trigger an automated install.
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
    has_rtools(cache = !debug, debug = debug)
  } else {
    has_devel(debug = debug)
  }
}

#' @export
#' @rdname has_build_tools
check_build_tools <- function(debug = FALSE) {
  if (!has_build_tools(debug = debug))
    stop("Could not find tools necessary to compile a package", call. = FALSE)

  invisible(TRUE)
}
