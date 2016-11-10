# pkgbuild

[![Travis-CI Build Status](https://travis-ci.org/r-pkgs/pkgbuild.svg?branch=master)](https://travis-ci.org/r-pkgs/pkgbuild)
[![Coverage Status](https://img.shields.io/codecov/c/github/r-pkgs/pkgbuild/master.svg)](https://codecov.io/github/r-pkgs/pkgbuild?branch=master)

The goal of pkgbuild is to make it easy to build packages with compiled code. It provides tools to configure your R session, and check that everything is working ok. If you are using RStudio, it also helps you trigger automatical install of the build tools.

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

# Run your own code in an environment guarnteed to 
# have build tools available
pkgbuild::with_build_tools(my_code)
```
