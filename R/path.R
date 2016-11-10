get_path <- function() {
  strsplit(Sys.getenv("PATH"), .Platform$path.sep)[[1]]
}

set_path <- function(path) {
  path <- normalizePath(path, mustWork = FALSE)

  old <- get_path()
  path <- paste(path, collapse = .Platform$path.sep)
  Sys.setenv(PATH = path)
  invisible(old)
}

add_path <- function(path, after = Inf) {
  set_path(append(get_path(), path, after))
}
