# pkgbuild

[![Travis-CI Build Status](https://travis-ci.org/r-pkgs/pkgbuild.svg?branch=master)](https://travis-ci.org/r-pkgs/pkgbuild)

The goal of pkgbuild is to make it easy to build packages with compiled code. It provides tool to configure your R session, and check that everything is working ok. If you are using RStudio, it also helps you trigger automatical install of the build tools.

## Installation

You can install pkgbuild from github with:

``` r
# install.packages("devtools")
devtools::install_github("hadley/pkgbuild")
```

## Example

``` r
# Check that you have the build tools installed
pkgbuild::check_build_tools(debug = TRUE)

# Build a package
pkgbuild::build("/path/to/my/package")
```
