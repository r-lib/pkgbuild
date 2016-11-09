#' Build package.
#'
#' Building converts a package source directory into a single bundled file.
#' If \code{binary = FALSE} this creates a \code{tar.gz} package that can
#' be installed on any platform, provided they have a full development
#' environment (although packages without source code can typically be
#' install out of the box). If \code{binary = TRUE}, the package will have
#' a platform specific extension (e.g. \code{.zip} for windows), and will
#' only be installable on the current platform, but no development
#' environment is needed.
#'
#' @param pkg package description, can be path or package name.  See
#'   \code{\link{as.package}} for more information
#' @param path path in which to produce package.  If \code{NULL}, defaults to
#'   the parent directory of the package.
#' @param binary Produce a binary (\code{--binary}) or source (
#'   \code{--no-manual --no-resave-data}) version of the package.
#' @param vignettes,manual For source packages: if \code{FALSE}, don't build PDF
#'   vignettes (\code{--no-build-vignettes}) or manual (\code{--no-manual}).
#' @param args An optional character vector of additional command
#'   line arguments to be passed to \code{R CMD build} if \code{binary = FALSE},
#'   or \code{R CMD install} if \code{binary = TRUE}.
#' @param quiet if \code{TRUE} suppresses output from this function.
#' @export
#' @family build functions
#' @return a string giving the location (including file name) of the built
#'  package
build <- function(pkg = ".", path = NULL, binary = FALSE, vignettes = TRUE,
                  manual = FALSE, args = NULL, quiet = FALSE) {
  pkg <- as.package(pkg)
  if (is.null(path)) {
    path <- dirname(pkg$path)
  }

  check_build_tools(pkg)
  compile_rcpp_attributes(pkg)

  if (binary) {
    args <- c("--build", args)
    cmd <- "INSTALL"

    if (.Platform$OS.type == "windows") {
      ext <- ".zip"
    } else if (grepl("darwin", R.version$os)) {
      ext <- ".tgz"
    } else {
      ext <- paste0("_R_", Sys.getenv("R_PLATFORM"), ".tar.gz")
    }
  } else {
    args <- c(args, "--no-resave-data")

    if (manual && !has_latex(verbose = TRUE)) {
      manual <- FALSE
    }

    if (!manual) {
      args <- c(args, "--no-manual")
    }

    if (!vignettes) {
      args <- c(args, "--no-build-vignettes")
    }

    cmd <- "build"

    ext <- ".tar.gz"
  }

  # Run in temporary library to ensure that default library doesn't get
  # contaminated
  withr::with_temp_libpaths(
    callr::rcmd_safe(cmd, c(shQuote(pkg$path), args))
  )

  targz <- paste0(pkg$package, "_", pkg$version, ext)
  file.path(path, targz)
}


