# Build package

Building converts a package source directory into a single bundled file.
If `binary = FALSE` this creates a `tar.gz` package that can be
installed on any platform, provided they have a full development
environment (although packages without source code can typically be
installed out of the box). If `binary = TRUE`, the package will have a
platform specific extension (e.g. `.zip` for windows), and will only be
installable on the current platform, but no development environment is
needed.

## Usage

``` r
build(
  path = ".",
  dest_path = NULL,
  binary = FALSE,
  vignettes = TRUE,
  manual = FALSE,
  clean_doc = NULL,
  args = NULL,
  quiet = FALSE,
  needs_compilation = pkg_has_src(path),
  compile_attributes = FALSE,
  register_routines = FALSE
)
```

## Arguments

- path:

  Path to a package, or within a package.

- dest_path:

  path in which to produce package. If it is an existing directory, then
  the output file is placed in `dest_path` and named according to the
  current R conversions (e.g. `.zip` for Windows binary packages, `.tgz`
  for macOS binary packages, etc). If it is an existing file, then it
  will be overwritten. If `dest_path` does not exist, then it is used as
  a file name. If `NULL`, it defaults to the parent directory of the
  package.

- binary:

  Produce a binary (`--binary`) or source (
  `--no-manual --no-resave-data`) version of the package.

- vignettes, manual:

  For source packages: if `FALSE`, don't build PDF vignettes
  (`--no-build-vignettes`) or manual (`--no-manual`).

- clean_doc:

  If `TRUE`, clean the existing documents by deleting the entire
  `inst/doc` directory before building the package. If `FALSE`, leave
  `inst/doc` untouched. If `NULL` (the default), first the
  `Config/build/clean-inst-doc` entry in `DESCRIPTION` is used if
  present, otherwise if the session is interactive the user is prompted
  for what to do, if non-interactive the directory is deleted. In most
  cases cleaning the files is the correct behavior to avoid stale
  vignette outputs in the built package.

- args:

  An optional character vector of additional command line arguments to
  be passed to `R CMD build` if `binary = FALSE`, or `R CMD install` if
  `binary = TRUE`.

- quiet:

  if `TRUE` suppresses output from this function.

- needs_compilation:

  Usually only needed if the packages has C/C++/Fortran code. By default
  this is autodetected.

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

## Value

a string giving the location (including file name) of the built package

## Details

### Configuration

#### `DESCRIPTION` entries

- `Config/build/clean-inst-doc` can be set to `FALSE` to avoid cleaning
  up `inst/doc` when building a source package. Set it to `TRUE` to
  force a cleanup. See the `clean_doc` argument.

- `Config/build/copy-method` can be used to avoid copying large
  directories in `R CMD build`. It works by copying (or linking) the
  files of the package to a temporary directory, leaving out the
  (possibly large) files that are not part of the package. Possible
  values:

  - `none`: pkgbuild does not copy the package tree. This is the
    default.

  - `copy`: the package files are copied to a temporary directory before
    ` R CMD build`.

  - `link`: the package files are symbolic linked to a temporary
    directory before `R CMD build`. Windows does not have symbolic
    links, so on Windows this is equivalent to `copy`.

  You can also use the `pkg.build_copy_method` option or the
  `PKG_BUILD_COPY_METHOD` environment variable to set the copy method.
  The option is consulted first, then the `DESCRIPTION` entry, then the
  environment variable.

- `Config/build/extra-sources` can be used to define extra source files
  for pkgbuild to decide whether a package DLL needs to be recompiled in
  [`needs_compile()`](https://pkgbuild.r-lib.org/dev/reference/needs_compile.md).
  The syntax is a comma separated list of file names, or globs. (See
  [`utils::glob2rx()`](https://rdrr.io/r/utils/glob2rx.html).) E.g.
  `src/rust/src/*.rs` or `configure*`.

- `Config/build/bootstrap` can be set to `TRUE` to run
  `Rscript bootstrap.R` in the source directory prior to running
  subsequent build steps.

- `Config/build/never-clean` can be set to `TRUE` to never add
  `--preclean` to `R CMD INSTALL`, e.g., when header files have changed.
  This helps avoiding rebuilds that can take long for very large C/C++
  codebases and can lead to build failures if object files are out of
  sync with header files. Control the dependencies between object files
  and header files by adding `include file.d` to `Makevars` for each
  `file.c` or `file.cpp` source file.

#### Options

- `pkg.build_copy_method`: use this option to avoid copying large
  directories when building a package. See possible values above, at the
  `Config/build/copy-method` `DESCRIPTION` entry.

- `pkg.build_stop_for_warnings`: if it is set to `TRUE`, then pkgbuild
  will stop for `R CMD build` errors. It takes precedence over the
  `PKG_BUILD_STOP_FOR_WARNINGS` environment variable.

#### Environment variables

- `PKG_BUILD_COLOR_DIAGNOSTICS`: set it to `false` to opt out of colored
  compiler diagnostics. Set it to `true` to force colored compiler
  diagnostics.

- `PKG_BUILD_COPY_METHOD`: use this environment variable to avoid
  copying large directories when building a package. See possible values
  above, at the `Config/build/copy-method` `DESCRIPTION` entry.

will stop for `R CMD build` errors. The `pkg.build_stop_for_warnings`
option takes precedence over this environment variable.
