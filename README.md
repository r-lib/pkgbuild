# pkgbuild

<!-- badges: start -->
[![R build status](https://github.com/r-lib/pkgbuild/workflows/R-CMD-check/badge.svg)](https://github.com/r-lib/pkgbuild/actions)
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
