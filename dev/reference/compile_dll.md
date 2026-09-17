# Compile a .dll/.so from source.

`compile_dll` performs a fake R CMD install so code that works here
should work with a regular install (and vice versa). During compilation,
debug flags are set with
[`compiler_flags`](https://pkgbuild.r-lib.org/dev/reference/compiler_flags.md)`(TRUE)`.

## Usage

``` r
compile_dll(
  path = ".",
  force = FALSE,
  compile_attributes = pkg_links_to_cpp11(path) || pkg_links_to_rcpp(path),
  register_routines = FALSE,
  quiet = FALSE,
  debug = TRUE
)
```

## Arguments

- path:

  Path to a package, or within a package.

- force:

  If `TRUE`, for compilation even if
  [`needs_compile()`](https://pkgbuild.r-lib.org/dev/reference/needs_compile.md)
  is `FALSE`.

- compile_attributes:

  if `TRUE` and the package uses Rcpp, call
  [`Rcpp::compileAttributes()`](https://rdrr.io/pkg/Rcpp/man/compileAttributes.html)
  before building the package. It is ignored if package does not need
  compilation.

- register_routines:

  if `TRUE` and the package does not use Rcpp, call register routines
  with
  [`tools::package_native_routine_registration_skeleton()`](https://rdrr.io/r/tools/package_native_routine_registration_skeleton.html)
  before building the package. It is ignored if package does not need
  compilation.

- quiet:

  if `TRUE` suppresses output from this function.

- debug:

  If `TRUE`, and if no user Makevars is found, then the build runs
  without optimisation (`-O0`) and with debug symbols (`-g`). See
  [`compiler_flags()`](https://pkgbuild.r-lib.org/dev/reference/compiler_flags.md)
  for details. If you have a user Makevars (e.g., `~/.R/Makevars`) then
  this argument is ignored.

## Details

Invisibly returns the names of the DLL.

### Configuration

#### Options

- `pkg.build_extra_flags`: set this to `FALSE` to to opt out from adding
  debug compiler flags in `compile_dll()`. Takes precedence over the
  `PKG_BUILD_EXTRA_FLAGS` environment variable. Possible values:

  - `TRUE`: add extra flags,

  - `FALSE`: do not add extra flags,

  - `"missing"`: add extra flags if the user does not have a
    `$HOME/.R/Makevars` file.

#### Environment variables

- `PKG_BUILD_EXTRA_FLAGS`: set this to `false` to to opt out from adding
  debug compiler flags in `compile_dll()`. The `pkg.build_extra_flags`
  option takes precedence over this environment variable. Possible
  values:

  - `"true"`: add extra flags,

  - `"false"`: do not add extra flags,

  - `"missing"`: add extra flags if the user does not have a
    `$HOME/.R/Makevars` file.

## Note

If this is used to compile code that uses Rcpp, you will need to add the
following line to your `Makevars` file so that it knows where to find
the Rcpp headers:

    PKG_CPPFLAGS=`$(R_HOME)/bin/Rscript -e 'Rcpp:::CxxFlags()'`

## See also

[`clean_dll()`](https://pkgbuild.r-lib.org/dev/reference/clean_dll.md)
to delete the compiled files.
