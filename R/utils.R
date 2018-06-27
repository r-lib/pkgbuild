dir.exists <- function(x) {
  res <- file.exists(x) & file.info(x)$isdir
  stats::setNames(res, x)
}

pkg_path <- function(path = ".") {
  rprojroot::find_root("DESCRIPTION", path)
}

pkg_name <- function(path = ".") {
  desc::desc_get("Package", pkg_path(path))[[1]]
}

gcc_arch <- function() {
  if (Sys.getenv("R_ARCH") == "/i386") "32" else "64"
}

is_windows <- function() {
  .Platform$OS.type == "windows"
}

is_dir <- function(x) {
  isTRUE(file.info(x)$isdir)
}
