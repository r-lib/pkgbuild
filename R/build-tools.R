#' Are build tools are available?
#'
#' `has_build_tools` returns a logical, `check_build_tools` throws
#' an error. `with_build_tools` checks that build tools are available,
#' then runs `code` in an correctly staged environment.
#' If run interactively from RStudio, and the build tools are not
#' available these functions will trigger an automated install.
#'
#' Errors like `running command
#' '"C:/PROGRA~1/R/R-34~1.2/bin/x64/R" CMD config CC' had status 127`
#' indicate the code expected Rtools to be on the system PATH. You can
#' then verify you have rtools installed with `has_build_tools()` and
#' temporarily add Rtools to the PATH `with_build_tools({ code })`.
#'
#' It is possible to add Rtools to your system PATH manually; you can use
#' [rtools_path()] to show the installed location. However because this
#' requires manual updating when a new version of Rtools is installed and the
#' binaries in Rtools may conflict with existing binaries elsewhere on the PATH it
#' is better practice to use `with_build_tools()` as needed.
#' @inheritParams has_rtools
#' @export
#' @seealso has_rtools
#' @examples
#' has_build_tools(debug = TRUE)
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

#' @rdname has_build_tools
#' @inheritParams withr::local_path
#' @export
local_build_tools <- function(debug = FALSE, required = TRUE, .local_envir = parent.frame()) {
  if (required)
    check_build_tools(debug = debug)

  if (has_rtools()) {
    withr::local_path(rtools_path(), .local_envir = .local_envir)
  }
}
