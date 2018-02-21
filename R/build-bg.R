
#' Build package in the background
#'
#' This R6 class is a counterpart of the [build()] function, and
#' represents a background process that builds an R package.
#'
#' @section Usage:
#' ```
#' bp <- rcmdbuild_process$new(path = ".", dest_path = NULL,
#'          binary = FALSE, vignettes = TRUE, manual = FALSE, args = NULL)
#' bp$get_dest_path()
#' ```
#'
#' Other methods are inherited from [callr::rcmd_process] and
#' [processx::process].
#'
#' @section Arguments:
#' See the corresponding arguments of [build()].
#'
#' @section Details:
#' Most methods are inherited from [callr::rcmd_process] and
#' [processx::process].
#'
#' `bp$get_dest_path()` returns the path to the built package.
#'
#' @section Examples:
#' ```
#' ## Here we are just waiting, but in a more realistic example, you
#' ## would probably run some other code instead...
#' bp <- rcmdbuild_process$new("mypackage", dest_path = tempdir())
#' bp$is_alive()
#' bp$get_pid()
#' bp$wait()
#' bp$read_all_output_lines()
#' bp$read_all_error_lines()
#' bp$get_exit_status()
#' bp$get_dest_path()
#' ```
#'
#' @importFrom R6 R6Class
#' @name rcmdbuild_process
NULL

#' @export

rcmdbuild_process <- R6Class(
  "rcmdbuild_process",
  inherit = callr::rcmd_process,

  public = list(

    initialize = function(path = ".", dest_path = NULL, binary = FALSE,
                          vignettes = TRUE, manual = FALSE, args = NULL)
      rcb_init(self, private, super, path, dest_path, binary, vignettes,
               manual, args),

    finalize = function() {
      tryCatch(unlink(private$makevars_file), error = function(x) x)
    },

    get_dest_path = function() private$dest_path,

    kill = function(...) {
      ret <- super$kill(...)
      tryCatch(unlink(private$makevars_file), error = function(x) x)
      ret
    }
  ),

  private = list(
    path = NULL,
    dest_path = NULL,
    makevars_file = NULL
  )
)

#' @importFrom callr rcmd_process rcmd_process_options

rcb_init <- function(self, private, super, path, dest_path, binary,
                     vignettes, manual, args) {

  options <- build_setup(path, dest_path, binary, vignettes, manual, args)

  private$path <- options$path
  private$dest_path <- options$dest_path

  ## Build tools already checked in setup

  options <- rcmd_process_options(
    cmd = options$cmd,
    cmdargs = c(options$path, options$args),
    wd = options$out_dir
  )

  ## We cannot use withr::with_makevars directly, because that removes
  ## Makevars when exiting
  flags <- compiler_flags(FALSE)
  private$makevars_file <- tempfile()
  withr::with_envvar(c(R_MAKEVARS_USER = private$makevars_file), {
    withr::set_makevars(flags, new_path = private$makevars_file)
    super$initialize(options)
  })

  invisible(self)
}
