# pkgbuild

<!-- badges: start -->
[![R-CMD-check](https://github.com/r-lib/pkgbuild/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/r-lib/pkgbuild/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/r-lib/pkgbuild/branch/main/graph/badge.svg)](https://app.codecov.io/gh/r-lib/pkgbuild?branch=main)
<!-- badges: end -->

The goal of pkgbuild is to make it easy to build packages with compiled code. It provides tools to configure your R session, and check that everything is working ok. If you are using RStudio, it also helps you trigger automatic install of the build tools.

## Installation

You can install pkgbuild from github with:

``` r
# install.packages("devtools")
devtools::install_github("r-lib/pkgbuild")
```

## Example

``` r
# Check that you have the build tools installed
pkgbuild::check_build_tools(debug = TRUE)

# Build a package
pkgbuild::build("/path/to/my/package")

# Run your own code in an environment guaranteed to
# have build tools available
pkgbuild::with_build_tools(my_code)
```

## Configuration

### Options

* `pkg.build_stop_for_warnings` if it is set to `TRUE`, then pkgbuild will stop
  for `R CMD build` errors. It takes precedence over the
  `PKG_BUILD_STOP_FOR_WARNINGS` environment variable.

### Environment variables

* `PKG_BUILD_STOP_FOR_WARNINGS` if it is set to `true`, then pkgbuild will stop
  for `R CMD build` errors. The `pkg.build_stop_for_warnings` option takes
  precedence over this environment variable.

## Code of Conduct

Please note that the pkgbuild project is released with a
[Contributor Code of Conduct](https://r-lib.github.io/pkgbuild/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
