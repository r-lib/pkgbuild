pkg_path <- function(path = ".") {
  rprojroot::find_root("DESCRIPTION", path)
}

pkg_name <- function(path = ".") {
  desc::desc_get("Package", pkg_path(path))[[1]]
}
