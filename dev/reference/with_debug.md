# Temporarily set debugging compilation flags.

Temporarily set debugging compilation flags.

## Usage

``` r
with_debug(
  code,
  CFLAGS = NULL,
  CXXFLAGS = NULL,
  FFLAGS = NULL,
  FCFLAGS = NULL,
  debug = TRUE
)
```

## Arguments

- code:

  to execute.

- CFLAGS:

  flags for compiling C code

- CXXFLAGS:

  flags for compiling C++ code

- FFLAGS:

  flags for compiling Fortran code.

- FCFLAGS:

  flags for Fortran 9x code.

- debug:

  If `TRUE` adds `-g -O0` to all flags (Adding `FFLAGS` and `FCFLAGS`)

## See also

Other debugging flags:
[`compiler_flags()`](https://pkgbuild.r-lib.org/dev/reference/compiler_flags.md)

## Examples

``` r
flags <- names(compiler_flags(TRUE))
with_debug(Sys.getenv(flags))
#>     CFLAGS   CXXFLAGS CXX11FLAGS CXX14FLAGS CXX17FLAGS CXX20FLAGS 
#>         ""         ""         ""         ""         ""         "" 
#>     FFLAGS    FCFLAGS 
#>         ""         "" 
if (FALSE) { # \dontrun{
install("mypkg")
with_debug(install("mypkg"))
} # }
```
