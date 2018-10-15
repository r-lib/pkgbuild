# Call Rcpp::compileAttributes() for packages that link to Rcpp.
# Assumes Rcpp is installed
compile_rcpp_attributes <- function(path = ".") {
  path <- pkg_path(path)

  if (pkg_links_to_rcpp(path)) {
    unlink(file.path(path, c("R/RcppExports.R", "src/RcppExports.cpp")))
    Rcpp::compileAttributes(path)
  }
}

#' Test if a package path is linking to Rcpp
#' @inheritParams build
#' @export
#' @keywords internal
pkg_links_to_rcpp <- function(path) {
  path <- pkg_path(path)

  deps <- desc::desc_get_deps(file.path(path, "DESCRIPTION"))

  any(deps$type == "LinkingTo" & deps$package == "Rcpp")
}
