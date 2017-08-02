#' Build package
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
#' @param path Path to a package, or within a package.
#' @param dest_path path in which to produce package.  If \code{NULL}, defaults to
#'   the parent directory of the package.
#' @param binary Produce a binary (\code{--binary}) or source (
#'   \code{--no-manual --no-resave-data}) version of the package.
#' @param vignettes,manual For source packages: if \code{FALSE}, don't build PDF
#'   vignettes (\code{--no-build-vignettes}) or manual (\code{--no-manual}).
#' @param args An optional character vector of additional command
#'   line arguments to be passed to \code{R CMD build} if \code{binary = FALSE},
#'   or \code{R CMD install} if \code{binary = TRUE}.
#' @param quiet if \code{TRUE} suppresses output from this function.
#' @param remove_remotes if \code{TRUE} removes Remotes field from
#' \code{DESCRIPTION}
#' @export
#' @return a string giving the location (including file name) of the built
#'  package
build <- function(path = ".", dest_path = NULL, binary = FALSE, vignettes = TRUE,
                  manual = FALSE, args = NULL, quiet = FALSE,
                  remove_remotes = FALSE) {

  path <- pkg_path(path)
  if (is.null(dest_path)) {
    dest_path <- dirname(path)
  }

  if (pkg_has_src(path))
    check_build_tools()

  compile_rcpp_attributes(path)

  if (binary) {
    args <- c("--build", args)
    cmd <- "INSTALL"
  } else {
    args <- c(args, "--no-resave-data")

    if (manual && !has_latex()) {
      message("pdflatex not found! Not building PDF manual.")
      manual <- FALSE
    }

    if (!manual) {
      args <- c(args, "--no-manual")
    }

    if (!vignettes) {
      args <- c(args, "--no-build-vignettes")
    }

    cmd <- "build"
  }

  # Build in temporary directory and then copy to final location
  out_dir <- tempfile()
  dir.create(out_dir)
  on.exit(unlink(out_dir))

  path <- normalizePath(path)
  if (remove_remotes) {
    dcf_file <- file.path(path, "DESCRIPTION")
    dcf_con <- file(dcf_file)
    dcf = read.dcf(dcf_con, all = TRUE)
    close(dcf_con)
    dcf = as.data.frame(
      dcf,
      stringsAsFactors = FALSE)
    xdcf = dcf
    on.exit({
      write.dcf(x = xdcf, file = dcf_file)
    })
    dcf$Remotes = NULL
    write.dcf(x = dcf, file = dcf_file)
  }

  withr::with_temp_libpaths(
    rcmd_build_tools(
      cmd,
      c(path, args),
      wd = out_dir,
      show = !quiet,
      echo = !quiet,
      fail_on_status = TRUE,
      required = FALSE # already checked above
    )
  )

  out_file <- dir(out_dir)
  file.copy(file.path(out_dir, out_file), dest_path, overwrite = TRUE)
  file.path(dest_path, out_file)
}
