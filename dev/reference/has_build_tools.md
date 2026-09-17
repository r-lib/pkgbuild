# Are build tools are available?

`has_build_tools` returns a logical, `check_build_tools` throws an
error. `with_build_tools` checks that build tools are available, then
runs `code` in an correctly staged environment. If run interactively
from RStudio, and the build tools are not available these functions will
trigger an automated install.

## Usage

``` r
has_build_tools(debug = FALSE)

check_build_tools(debug = FALSE, quiet = FALSE)

with_build_tools(code, debug = FALSE, required = TRUE)

local_build_tools(
  debug = FALSE,
  required = TRUE,
  .local_envir = parent.frame()
)
```

## Arguments

- debug:

  If `TRUE`, will print out extra information useful for debugging. If
  `FALSE`, it will use result cached from a previous run.

- quiet:

  if `TRUE` suppresses output from this function.

- code:

  Code to rerun in environment where build tools are guaranteed to
  exist.

- required:

  If `TRUE`, and build tools are not available, will throw an error.
  Otherwise will attempt to run `code` without them.

- .local_envir:

  The environment to use for scoping.

## Details

Errors like
`running command '"C:/PROGRA~1/R/R-34~1.2/bin/x64/R" CMD config CC' had status 127`
indicate the code expected Rtools to be on the system PATH. You can then
verify you have rtools installed with `has_build_tools()` and
temporarily add Rtools to the PATH `with_build_tools({ code })`.

It is possible to add Rtools to your system PATH manually; you can use
[`rtools_path()`](https://pkgbuild.r-lib.org/dev/reference/has_rtools.md)
to show the installed location. However because this requires manual
updating when a new version of Rtools is installed and the binaries in
Rtools may conflict with existing binaries elsewhere on the PATH it is
better practice to use `with_build_tools()` as needed.

## See also

has_rtools

## Examples

``` r
has_build_tools(debug = TRUE)
#> Trying to compile a simple C file
#> Running /opt/R/4.6.1/lib/R/bin/R CMD SHLIB foo.c
#> using C compiler: ‘gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0’
#> gcc -std=gnu2x -I"/opt/R/4.6.1/lib/R/include" -DNDEBUG   -I/usr/local/include    -fpic  -g -O2  -c foo.c -o foo.o
#> gcc -std=gnu2x -shared -L/opt/R/4.6.1/lib/R/lib -L/usr/local/lib -o foo.so foo.o -L/opt/R/4.6.1/lib/R/lib -lR
#> 
#> [1] TRUE
check_build_tools()
#> Your system is ready to build packages!
```
