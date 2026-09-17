# Is Rtools installed?

To build binary packages on windows, Rtools (found at
<https://CRAN.R-project.org/bin/windows/Rtools/>) needs to be on the
path. The default installation process does not add it, so this script
finds it (looking first on the path, then in the registry). It also
checks that the version of rtools matches the version of R.
`has_rtools()` determines if Rtools is installed, caching the results.
Afterward, run `rtools_path()` to find out where it's installed.

## Usage

``` r
rtools_path()

has_rtools(debug = FALSE)

check_rtools(debug = FALSE)
```

## Arguments

- debug:

  If `TRUE`, will print out extra information useful for debugging. If
  `FALSE`, it will use result cached from a previous run.

## Value

Either a visible `TRUE` if rtools is found, or an invisible `FALSE` with
a diagnostic [`message()`](https://rdrr.io/r/base/message.html). As a
side-effect the internal package variable `rtools_path` is updated to
the paths to rtools binaries.

## Acknowledgements

This code borrows heavily from RStudio's code for finding Rtools. Thanks
JJ!

## Examples

``` r
has_rtools()
#> [1] FALSE
```
