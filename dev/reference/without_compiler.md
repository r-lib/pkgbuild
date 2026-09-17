# Tools for testing pkgbuild

`with_compiler` temporarily disables code compilation by setting `CC`,
`CXX`, makevars to `test`. `without_cache` resets the cache before and
after running `code`.

## Usage

``` r
without_compiler(code)

without_cache(code)

without_latex(code)

with_latex(code)
```

## Arguments

- code:

  Code to execute with broken compilers
