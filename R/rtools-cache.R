
# Need to check for existence so load_all doesn't override known rtools location
if (!exists("rtools_env")) {
  rtools_env <- new.env()
  rtools_env$path <- NULL
}

#' @export
#' @rdname has_rtools
rtools_path <- function() {
 rtools_env$path
}

rtools_path_is_set <- function() {
  !is.null(rtools_env$path)
}

rtools_path_set <- function(rtools) {
  stopifnot(is.rtools(rtools))
  path <- file.path(rtools$path, version_info[[rtools$version]]$path)

  # If using gcc49 and _without_ a valid BINPREF already set
  if (using_gcc49() && is.null(rtools$valid_binpref)) {
    Sys.setenv(BINPREF = file.path(rtools$path, "mingw_$(WIN)", "bin", "/"))
  }

  old <- rtools_env$path
  rtools_env$path <- path
  invisible(old)
}

using_gcc49 <- function() {
  isTRUE(sub("^gcc[^[:digit:]]+", "", Sys.getenv("R_COMPILED_BY")) >= "4.9.3")
}
