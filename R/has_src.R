#' Does a source package have `src/` directory?
#'
#' If it does, you definitely need build tools.
#'
#' @param path Path to package (or directory within package).
#' @export
pkg_has_src <- function(path = ".") {
  src_path <- file.path(pkg_path(path), "src")
  file.exists(src_path)
}
