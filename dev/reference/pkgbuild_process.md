# Build package in the background

This R6 class is a counterpart of the
[`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) function,
and represents a background process that builds an R package.

## Usage

    bp <- pkgbuild_process$new(path = ".", dest_path = NULL,
             binary = FALSE, vignettes = TRUE, manual = FALSE, args = NULL)
    bp$get_dest_path()

Other methods are inherited from
[callr::rcmd_process](https://callr.r-lib.org/reference/rcmd_process.html)
and
[`processx::process`](http://processx.r-lib.org/reference/process.md).

## Arguments

See the corresponding arguments of
[`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md).

## Details

Most methods are inherited from
[callr::rcmd_process](https://callr.r-lib.org/reference/rcmd_process.html)
and
[`processx::process`](http://processx.r-lib.org/reference/process.md).

`bp$get_dest_path()` returns the path to the built package.

## Examples

    ## Here we are just waiting, but in a more realistic example, you
    ## would probably run some other code instead...
    bp <- pkgbuild_process$new("mypackage", dest_path = tempdir())
    bp$is_alive()
    bp$get_pid()
    bp$wait()
    bp$read_all_output_lines()
    bp$read_all_error_lines()
    bp$get_exit_status()
    bp$get_dest_path()
