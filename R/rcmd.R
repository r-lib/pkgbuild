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
#' @inheritParams build
#' @export
#' @examples
#' # These env vars are always set
#' callr::rcmd_safe_env()
#'
#' if (has_build_tools()) {
#'   rcmd_build_tools("CONFIG", "CC")$stdout
#'   rcmd_build_tools("CC", "--version")$stdout
#' }
rcmd_build_tools <- function(..., env = character(), required = TRUE, quiet = FALSE) {
  env <- c(callr::rcmd_safe_env(), env)

  res <- with_build_tools(
    callr::rcmd_safe(..., env = env, spinner = FALSE, show = FALSE,
      echo = FALSE, block_callback = block_callback(quiet)),
    required = required
  )

  msg_for_long_paths(res)

  invisible(res)
}

msg_for_long_paths <- function(output) {
  if (is_windows() &&
      any(grepl("over-long path length", output$stderr))) {
    message(
      "\nIt seems that this package contains files with very long paths.\n",
      "This is not supported on most Windows versions. Please contact the\n",
      "package authors and tell them about this. See this GitHub issue\n",
      "for more details: https://github.com/r-lib/remotes/issues/84\n")
  }
}
}
