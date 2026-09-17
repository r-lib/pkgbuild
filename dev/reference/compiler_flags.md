# Default compiler flags used by devtools.

These default flags enforce good coding practice by ensuring that
`CFLAGS` and `CXXFLAGS` are set to `-Wall -pedantic`. These tests are
run by cran and are generally considered to be good practice.

## Usage

``` r
compiler_flags(debug = FALSE)
```

## Arguments

- debug:

  If `TRUE` adds `-g -O0` to all flags (Adding `FFLAGS` and `FCFLAGS`)

## Details

By default
[`compile_dll()`](https://pkgbuild.r-lib.org/dev/reference/compile_dll.md)
is run with `compiler_flags(TRUE)`, and check with
`compiler_flags(FALSE)`. If you want to avoid the possible performance
penalty from the debug flags, install the package.

## See also

Other debugging flags:
[`with_debug()`](https://pkgbuild.r-lib.org/dev/reference/with_debug.md)

## Examples

``` r
compiler_flags()
#>                                       CFLAGS 
#> "-Wall -pedantic -fdiagnostics-color=always" 
#>                                     CXXFLAGS 
#> "-Wall -pedantic -fdiagnostics-color=always" 
#>                                   CXX11FLAGS 
#> "-Wall -pedantic -fdiagnostics-color=always" 
#>                                   CXX14FLAGS 
#> "-Wall -pedantic -fdiagnostics-color=always" 
#>                                   CXX17FLAGS 
#> "-Wall -pedantic -fdiagnostics-color=always" 
#>                                   CXX20FLAGS 
#> "-Wall -pedantic -fdiagnostics-color=always" 
compiler_flags(TRUE)
#>                                                       CFLAGS 
#> "-UNDEBUG -Wall -pedantic -g -O0 -fdiagnostics-color=always" 
#>                                                     CXXFLAGS 
#> "-UNDEBUG -Wall -pedantic -g -O0 -fdiagnostics-color=always" 
#>                                                   CXX11FLAGS 
#> "-UNDEBUG -Wall -pedantic -g -O0 -fdiagnostics-color=always" 
#>                                                   CXX14FLAGS 
#> "-UNDEBUG -Wall -pedantic -g -O0 -fdiagnostics-color=always" 
#>                                                   CXX17FLAGS 
#> "-UNDEBUG -Wall -pedantic -g -O0 -fdiagnostics-color=always" 
#>                                                   CXX20FLAGS 
#> "-UNDEBUG -Wall -pedantic -g -O0 -fdiagnostics-color=always" 
#>                                                       FFLAGS 
#>                                                     "-g -O0" 
#>                                                      FCFLAGS 
#>                                                     "-g -O0" 
```
