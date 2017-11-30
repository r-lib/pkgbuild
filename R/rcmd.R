#' Call R CMD <command> with build tools active
#'
#' This is a wrapper around [callr::rcmd_safe()] that checks
#' that you have build tools available, and on Windows, automatically sets
#' the path to include Rtools.
#'
#' @param ... Parameters passed on to `rcmd_safe`.
#' @param env Additional environment variables to set. The defaults from
#'   [callr::rcmd_safe_env()] are always set.
#' @inheritParams with_build_tools
#' @export
#' @examples
#' # These env vars are always set
#' callr::rcmd_safe_env()
#'
#' if (has_build_tools()) {
#'   rcmd_build_tools("CONFIG", "CC")$stdout
#'   rcmd_build_tools("CC", "--version")$stdout
#' }
rcmd_build_tools <- function(..., env = character(), required = TRUE) {
  env <- c(callr::rcmd_safe_env(), env)

  with_build_tools(
    callr::rcmd_safe(..., env = env, spinner = FALSE),
    required = required
  )
}
