#' Call R CMD <command> with build tools active
#'
#' This is a wrapper around \code{\link[callr]{rcmd_safe}} that checks
#' that you have build tools available, and on Windows, automatically sets
#' the path to include Rtools.
#'
#' @param ... Parameters passed on to \code{rcmd_safe}.
#' @inheritParams rcmd_build_tools
#' @export
#' @examples
#' if (has_build_tools()) {
#'   rcmd_build_tools("CONFIG", "CC")$stdout
#'   rcmd_build_tools("CC", "--version")$stdout
#' }
rcmd_build_tools <- function(..., required = TRUE) {
  with_build_tools(callr::rcmd_safe(...), required = required)
}
