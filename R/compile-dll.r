#' Compile a .dll/.so from source.
#'
#' \code{compile_dll} performs a fake R CMD install so code that
#' works here should work with a regular install (and vice versa).
#' During compilation, debug flags are set with
#' \code{\link{compiler_flags}(TRUE)}.
#'
#' The build system normally only recompiles the files that were
#' changed since the last build. However if a header or makefile has
#' changed, the whole source is recompiled from scratch. Furthermore,
#' if the `devtools.clean.compile.subdir.changes` global option is set
#' to `TRUE`, any change in subdirectories trigger a complete
#' recompilation.
#'
#' @return The names of the DLL, invisibly.
#'
#' @note If this is used to compile code that uses Rcpp, you will need to
#'   add the following line to your \code{Makevars} file so that it
#'   knows where to find the Rcpp headers:
#'   \code{PKG_CPPFLAGS=`$(R_HOME)/bin/Rscript -e 'Rcpp:::CxxFlags()'`}
#'
#' @inheritParams build
#' @seealso \code{\link{clean_dll}} to delete the compiled files.
#' @export
compile_dll <- function(path = ".", quiet = FALSE) {
  path <- pkg_path(path)

  if (!needs_compile(path))
    return(invisible())

  check_build_tools()
  compile_rcpp_attributes(path)

  # Mock install the package to generate the DLL
  if (!quiet)
    message("Re-compiling ", pkg_name(path))

  install_dir <- tempfile("devtools_install_")
  dir.create(install_dir)

  withr::with_envvar(compiler_flags(TRUE), action = "prefix", {
    install_min(
      path,
      dest = install_dir,
      components = "libs",
      args = if (needs_clean(path)) "--preclean",
      quiet = quiet
    )
  })

  invisible(dll_path(file.path(install_dir, pkg_name(path))))
}

#' Remove compiled objects from /src/ directory
#'
#' Invisibly returns the names of the deleted files.
#'
#' @inheritParams build
#' @seealso \code{\link{compile_dll}}
#' @export
clean_dll <- function(path = ".") {
  path <- pkg_path(path)

  # Clean out the /src/ directory and children:
  # * individual object files
  # * overall package definition file
  # * symbols.rds (added when run inside R CMD check)
  pattern <- sprintf(
    "\\.(o|sl|so|dylib|a|dll)$|(%s\\.def)$|^symbols.rds$",
    pkg_name(path)
  )
  files <- dir(
    file.path(path, "src"),
    pattern = pattern,
    full.names = TRUE,
    recursive = TRUE
  )
  unlink(files)

  invisible(files)
}

# Returns the full path and name of the DLL file
dll_path <- function(path = ".") {
  name <- paste(pkg_name(path), .Platform$dynlib.ext, sep = "")
  file.path(path, "src", name)
}

mtime <- function(x) {
  x <- x[file.exists(x)]
  if (length(x) == 0) return(NULL)
  max(file.info(x)$mtime)
}

# List all source files in the package
sources <- function(path = ".") {
  srcdir <- file.path(path, "src")
  dir(srcdir, "\\.(c.*|f)$", recursive = TRUE, full.names = TRUE)
}

# List all header files in the package
headers <- function(path = ".") {
  incldir <- file.path(path, "inst", "include")
  srcdir <- file.path(path, "src")

  c(
    dir(srcdir, "^Makevars.*$", recursive = TRUE, full.names = TRUE),
    dir(srcdir, "\\.h.*$", recursive = TRUE, full.names = TRUE),
    dir(incldir, "\\.h.*$", recursive = TRUE, full.names = TRUE)
  )
}

# Does the package need recompiling?
# (i.e. is there a source or header file newer than the dll)
needs_compile <- function(path = ".") {
  files <- c(sources(path), headers(path))
  files_need_compile(files, path)
}
files_need_compile <- function(files, path) {
  source <- mtime(files)
  # no source files, so doesn't need compile
  if (is.null(source)) return(FALSE)

  dll <- mtime(dll_path(path))
  # no dll, so needs compile
  if (is.null(dll)) return(TRUE)

  source > dll
}

# Does the package need a clean compile?
# (i.e. is there a header or Makevars newer than the dll)
needs_clean <- function(path = ".") {
  if (needs_subdir_clean(path)) {
    return(TRUE)
  }

  headers <- mtime(headers(path))
  # no headers, so never needs clean compile
  if (is.null(headers)) {
    return(FALSE)
  }

  dll <- mtime(dll_path(path))
  # no dll, so needs compile
  if (is.null(dll)) {
    return(TRUE)
  }

  headers > dll
}

needs_subdir_clean <- function(path) {
  if (!identical(getOption("devtools.clean.compile.subdir.changes"), TRUE)) {
    return(FALSE)
  }

  srcdir <- file.path(path, "src")
  subdirs <- list.dirs(srcdir, recursive = FALSE)
  files <- dir(subdirs, "\\.(c.*|f)$", recursive = TRUE, full.names = TRUE)

  files_need_compile(files, path)
}

install_min <- function(path = ".", dest, components = NULL, args = NULL, quiet = FALSE) {
  stopifnot(is.character(dest), length(dest) == 1, file.exists(dest))

  poss <- c("R", "data", "help", "demo", "inst", "docs", "exec", "libs")
  if (!is.null(components)) {
    components <- match.arg(components, poss, several.ok = TRUE)
  }
  no <- setdiff(poss, components)
  no_args <- paste0("--no-", no)

  rcmd_build_tools(
    "INSTALL",
    c(
      path,
      paste("--library=", dest, sep = ""),
      no_args,
      "--no-multiarch",
      "--no-test-load",
      args
    ),
    show = !quiet,
    echo = !quiet,
    fail_on_status = TRUE
  )

  invisible(file.path(dest, pkg_name(path)))
}
