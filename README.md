# pkgbuild

[![Travis-CI Build Status](https://travis-ci.org/r-lib/pkgbuild.svg?branch=master)](https://travis-ci.org/r-lib/pkgbuild)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/r-lib/pkgbuild?branch=master&svg=true)](https://ci.appveyor.com/project/hadley/pkgbuild)
[![Coverage status](https://codecov.io/gh/r-lib/pkgbuild/branch/master/graph/badge.svg)](https://codecov.io/github/r-lib/pkgbuild?branch=master)

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

# Run your own code in an environment guarnteed to 
# have build tools available
pkgbuild::with_build_tools(my_code)
```
