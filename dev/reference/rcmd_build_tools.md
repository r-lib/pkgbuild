# Call R CMD 'command' with build tools active

This is a wrapper around
[`callr::rcmd_safe()`](https://callr.r-lib.org/reference/rcmd.html) that
checks that you have build tools available, and on Windows,
automatically sets the path to include Rtools.

## Usage

``` r
rcmd_build_tools(..., env = character(), required = TRUE, quiet = FALSE)
```

## Arguments

- ...:

  Parameters passed on to `rcmd_safe`.

- env:

  Additional environment variables to set. The defaults from
  [`callr::rcmd_safe_env()`](https://callr.r-lib.org/reference/rcmd_safe_env.html)
  are always set.

- required:

  If `TRUE`, and build tools are not available, will throw an error.
  Otherwise will attempt to run `code` without them.

- quiet:

  if `TRUE` suppresses output from this function.

## Examples

``` r
# These env vars are always set
callr::rcmd_safe_env()
#>             CYGWIN            R_TESTS          R_BROWSER 
#> "nodosfilewarning"                 ""            "false" 
#>        R_PDFVIEWER 
#>            "false" 

if (has_build_tools()) {
  rcmd_build_tools("CONFIG", "CC")$stdout
  rcmd_build_tools("CC", "--version")$stdout
}
#> ── R CMD CONFIG ───────────────────────────────────────────────────────
#> /opt/R/4.6.1/lib/R/bin/Rcmd: 64: exec: CONFIG: not found
#> ── R CMD CC ───────────────────────────────────────────────────────────
#> /opt/R/4.6.1/lib/R/bin/Rcmd: 64: exec: CC: not found
#> [1] "/opt/R/4.6.1/lib/R/bin/Rcmd: 64: exec: CC: not found\n"
```
