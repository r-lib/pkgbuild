has_latex <- function(verbose = FALSE) {
  has <- nzchar(Sys.which("pdflatex"))
  if (!has && verbose) {
    message("pdflatex not found! Not building PDF manual or vignettes.\n",
            "If you are planning to release this package, please run a check with ",
            "manual and vignettes beforehand.\n")
  }
  has
}
