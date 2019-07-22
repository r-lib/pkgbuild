#' Is latex installed?
#'
#' Checks for presence of pdflatex on path.
#'
#' @export
has_latex <- function() {
  nzchar(Sys.which("pdflatex"))
}

#' @export
#' @rdname has_latex
check_latex <- function() {
  if (!has_latex())
    throw(new_build_error("LaTeX not installed (pdflatex not found)"))

  TRUE
}
