#' Is a compiler available?
#'
#' \code{has_devel} returns \code{TRUE} or \code{FALSE}. \code{check_devel}
#' throws an error if you don't developer tools installed. Implementation
#' based on a suggestion by Simon Urbanek.
#'
#' @export
#' @inheritParams has_rtools
#' @examples
#' has_compiler()
#' check_compiler()
has_compiler <- function(debug = FALSE) {
  foo_path <- file.path(tempdir(), "foo.c")
  cat("void foo(int *bar) { *bar=1; }\n", file = foo_path)
  on.exit(unlink(foo_path))

  tryCatch({
    RCMD("SHLIB", "foo.c", quiet = !debug, wd = tempdir())

    dylib <- file.path(tempdir(), paste0("foo", .Platform$dynlib.ext))
    on.exit(unlink(dylib), add = TRUE)

    dll <- dyn.load(dylib)
    on.exit(dyn.unload(dylib), add = TRUE)

    .C(dll$foo, 0L)[[1]] == 1L
  }, error = function(e) {
    FALSE
  })
}

#' @export
#' @rdname has_compiler
check_compiler <- function(debug = FALSE) {
  if (!has_compiler(debug))
    stop("Failed to compile C code", call. = FALSE)

  TRUE
}

#' @export
#' @rdname has_compiler
#' @usage NULL
has_devel <- check_compiler

# The checking code looks for the objects in the package namespace, so defining
# dll here removes the following NOTE
# Registration problem:
#   Evaluating 'dll$foo' during check gives error
# 'object 'dll' not found':
#    .C(dll$foo, 0L)
# See https://github.com/wch/r-source/blob/d4e8fc9832f35f3c63f2201e7a35fbded5b5e14c/src/library/tools/R/QC.R#L1950-L1980
# Setting the class is needed to avoid a note about returning the wrong class.
# The local object is found first in the actual call, so current behavior is
# unchanged.
dll <- list(foo = structure(list(), class = "NativeSymbolInfo"))
