# Is a compiler available?

These functions check if a small C file can be compiled, linked, loaded
and executed.

`has_compiler()` and `has_devel()` return `TRUE` or `FALSE`.
`check_compiler()` and `check_devel()` throw an error if you don't have
developer tools installed. If the `"pkgbuild.has_compiler"` option is
set to `TRUE` or `FALSE`, no check is carried out, and the value of the
option is used.

The implementation is based on a suggestion by Simon Urbanek. End-users
(particularly those on Windows) should generally run
[`check_build_tools()`](https://pkgbuild.r-lib.org/dev/reference/has_build_tools.md)
rather than `check_compiler()`.

## Usage

``` r
has_compiler(debug = FALSE)

check_compiler(debug = FALSE)
```

## Arguments

- debug:

  If `TRUE`, will print out extra information useful for debugging. If
  `FALSE`, it will use result cached from a previous run.

## See also

[`check_build_tools()`](https://pkgbuild.r-lib.org/dev/reference/has_build_tools.md)

## Examples

``` r
has_compiler()
#> [1] TRUE
check_compiler()
#> [1] TRUE

with_build_tools(has_compiler())
#> [1] TRUE
```
