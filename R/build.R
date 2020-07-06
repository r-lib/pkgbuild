#' Build package
#'
#' Building converts a package source directory into a single bundled file.
#' If `binary = FALSE` this creates a `tar.gz` package that can
#' be installed on any platform, provided they have a full development
#' environment (although packages without source code can typically be
#' installed out of the box). If `binary = TRUE`, the package will have
#' a platform specific extension (e.g. `.zip` for windows), and will
#' only be installable on the current platform, but no development
#' environment is needed.
#'
#' @param path Path to a package, or within a package.
#' @param dest_path path in which to produce package.  If `NULL`, defaults to
#'   the parent directory of the package.
#' @param binary Produce a binary (`--binary`) or source (
#'   `--no-manual --no-resave-data`) version of the package.
#' @param vignettes,manual For source packages: if `FALSE`, don't build PDF
#'   vignettes (`--no-build-vignettes`) or manual (`--no-manual`).
#' @param args An optional character vector of additional command
#'   line arguments to be passed to `R CMD build` if `binary = FALSE`,
#'   or `R CMD install` if `binary = TRUE`.
#' @param quiet if `TRUE` suppresses output from this function.
#' @param needs_compilation Usually only needed if the packages has
#'   C/C++/Fortran code. By default this is autodetected.
#' @param compile_attributes if `TRUE` and the package uses Rcpp, call
#'   [Rcpp::compileAttributes()] before building the package. It is ignored
#'   if package does not need compilation.
#' @param register_routines if `TRUE` and the package does not use Rcpp, call
#'   register routines with
#'   `tools::package_native_routine_registration_skeleton()` before building
#'   the package. It is ignored if package does not need compilation.
#' @param clean_doc If `TRUE`, clean the files in `inst/doc` before building
#'   the package. If `NULL` and interactive, ask to remove the
#'   files prior to cleaning. In most cases cleaning the files is the correct
#'   behavior to avoid stale vignette outputs in the built package.
#' @export
#' @return a string giving the location (including file name) of the built
#'  package
build <- function(path = ".", dest_path = NULL, binary = FALSE, vignettes = TRUE,
                  manual = FALSE, clean_doc = NULL, args = NULL, quiet = FALSE,
                  needs_compilation = pkg_has_src(path), compile_attributes = FALSE,
                  register_routines = FALSE) {

  options <- build_setup(path, dest_path, binary, vignettes, manual, clean_doc, args,
                         needs_compilation, compile_attributes, register_routines, quiet)
  on.exit(unlink(options$out_dir, recursive = TRUE), add = TRUE)

  withr::with_temp_libpaths(
    rcmd_build_tools(
      options$cmd,
      c(options$path, options$args),
      wd = options$out_dir,
      fail_on_status = TRUE,
      required = FALSE, # already checked in setup
      quiet = quiet
    )
  )

  out_file <- dir(options$out_dir)
  file.copy(
    file.path(options$out_dir, out_file), options$dest_path,
    overwrite = TRUE)
  file.path(options$dest_path, out_file)
}

build_setup <- function(path, dest_path, binary, vignettes, manual, clean_doc, args,
                        needs_compilation, compile_attributes, register_routines, quiet) {

  if (!file.exists(path)) {
    stop("`path` must exist", call. = FALSE)
  }
  if (!is_dir(path)) {
    if (!binary) stop("`binary` must be TRUE for package files", call. = FALSE)
    if (compile_attributes) {
      stop("`compile_attributes` must be FALSE for package files", call. = FALSE)
    }
    if (register_routines) {
      stop("`register_routines` must be FALSE for package files", call. = FALSE)
    }
  } else {
    path <- pkg_path(path)
  }

  if (is.null(dest_path)) {
    dest_path <- dirname(path)
  }

  if (needs_compilation) {
    update_registration(path, compile_attributes, register_routines, quiet)
  }

  if (binary) {
    build_setup_binary(path, dest_path, args, needs_compilation)
  } else {
    build_setup_source(path, dest_path, vignettes, manual, clean_doc, args,
                       needs_compilation)
  }
}

build_setup_binary <- function(path, dest_path, args, needs_compilation) {

  if (needs_compilation) {
    check_build_tools(quiet = TRUE)
  }

  # Build in temporary directory and then copy to final location
  out_dir <- tempfile()
  dir.create(out_dir)

  list(
    cmd = "INSTALL",
    path = normalizePath(path),
    args = c("--build", args),
    out_dir = out_dir,
    dest_path = dest_path
  )
}

build_setup_source <- function(path, dest_path, vignettes, manual, clean_doc,
                               args, needs_compilation) {

  if (!("--resave-data" %in% args)) {
    args <- c(args, "--no-resave-data")
  }

  if (manual && !has_latex()) {
    message("pdflatex not found! Not building PDF manual.")
    manual <- FALSE
  }

  if (needs_compilation && (vignettes || manual)) {
    check_build_tools(quiet = TRUE)
  }

  if (!manual) {
    args <- c(args, "--no-manual")
  }

  if (!vignettes) {
    args <- c(args, "--no-build-vignettes")
  } else if (is.null(clean_doc) || isTRUE(clean_doc)) {
    doc_dir <- file.path(path, "inst", "doc")
    if (dir.exists(doc_dir)) {
      if (is.null(clean_doc) && interactive()) {
        message("Building the package will delete...\n  '", doc_dir, "'\nAre you sure?")
        res <- utils::menu(c("Yes", "No"))
        if (res == 2) {
          return()
        }
      }
      unlink(doc_dir, recursive = TRUE)
    }
  }

  # Build in temporary directory and then copy to final location
  out_dir <- tempfile()
  dir.create(out_dir)

  list(
    cmd = "build",
    path = normalizePath(path),
    args = args,
    out_dir = out_dir,
    dest_path = dest_path
  )
}
