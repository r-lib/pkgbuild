# Changelog

## pkgbuild (development version)

- [`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) no
  longer fails with an unrelated error when you answer “No” to the
  interactive prompt about deleting `inst/doc`. `inst/doc` is now kept
  and the build continues, and the prompt says what “Yes” and “No” do
  ([@taekop](https://github.com/taekop),
  [\#186](https://github.com/r-lib/pkgbuild/issues/186)).

- The documentation for the `clean_doc` argument of
  [`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) now
  fully describes the behavior for `TRUE`, `FALSE`, and `NULL`,
  including the non-interactive case
  ([@jimhester](https://github.com/jimhester),
  [\#187](https://github.com/r-lib/pkgbuild/issues/187)).

- [`needs_compile()`](https://pkgbuild.r-lib.org/dev/reference/needs_compile.md)
  now ignores `.gcov` code coverage files.

## pkgbuild 1.4.8

CRAN release: 2025-05-26

- New `Config/build/never-clean` `DESCRIPTION` option to avoid adding
  `--preclean` to `R CMD INSTALL` (e.g., when header files have changed)
  ([@krlmlr](https://github.com/krlmlr),
  [\#204](https://github.com/r-lib/pkgbuild/issues/204)).

- [`has_rtools()`](https://pkgbuild.r-lib.org/dev/reference/has_rtools.md)
  & co. now work correctly on aarch64 Windows, when
  `RTOOLS45_AARCH64_HOME` is not set
  ([@remlapmot](https://github.com/remlapmot),
  [\#203](https://github.com/r-lib/pkgbuild/issues/203)).

- `pkg_build()` and `pkgbuild_process` now work corrently when building
  binary packages from non-standard file names
  ([\#208](https://github.com/r-lib/pkgbuild/issues/208)).

## pkgbuild 1.4.7

CRAN release: 2025-03-24

- pkgbuild now supports R 4.5.x and Rtools45.

- [`has_build_tools()`](https://pkgbuild.r-lib.org/dev/reference/has_build_tools.md)
  (and related functions) now do not explicitly check for Rtools on
  Windows and R 4.3.0 and later, but rather they try to compile a simple
  package, like on Unix, for
  [\#199](https://github.com/r-lib/pkgbuild/issues/199).

## pkgbuild 1.4.6

CRAN release: 2025-01-16

- No changes.

## pkgbuild 1.4.5

CRAN release: 2024-10-28

- pkgbuild now does a better job at finding Rtools 4.3 and 4.4 if they
  were not installed from an installer.

- pkgbuild now detects Rtools correctly from the Windows registry again
  for Rtools 4.3 and 4.4

## pkgbuild 1.4.4

CRAN release: 2024-03-17

- pkgbuild now supports R 4.4.x and Rtools44
  ([\#183](https://github.com/r-lib/pkgbuild/issues/183)).

## pkgbuild 1.4.3

CRAN release: 2023-12-10

- pkgbuild now does not need the crayon, rprojroot and prettyunits
  packages.

## pkgbuild 1.4.2

CRAN release: 2023-06-26

- Running `bootstrap.R` now works with `pkgbuild_process`, so it also
  works from pak (<https://github.com/r-lib/pak/issues/508>).

## pkgbuild 1.4.1

CRAN release: 2023-06-14

- New `Config/build/extra-sources` `DESCRIPTION` option to make pkgbuild
  aware of extra source files to consider in
  [`needs_compile()`](https://pkgbuild.r-lib.org/dev/reference/needs_compile.md).

- New `Config/build/bootstrap` `DESCRIPTION` option. Set it to `TRUE` to
  run `Rscript bootstrap.R` in the package root prior to building the
  source package ([\#157](https://github.com/r-lib/pkgbuild/issues/157),
  [@paleolimbot](https://github.com/paleolimbot)).

- pkgbuild now supports Rtools43.

- pkgbuild now always *appends* its extra compiler flags to the ones
  that already exist in the system and/or user `Makevars` files
  ([\#156](https://github.com/r-lib/pkgbuild/issues/156)).

## pkgbuild 1.4.0

CRAN release: 2022-11-27

- pkgbuild can now avoid copying large package directories when building
  a source package. See the `PKG_BUILD_COPY_METHOD` environment variable
  in [`?build`](https://pkgbuild.r-lib.org/dev/reference/build.md) or
  the package README
  ([\#59](https://github.com/r-lib/pkgbuild/issues/59)).

  This is currently an experimental feature, and feedback is
  appreciated.

- `R CMD build` warnings can now be turned into errors, by setting the
  `pkg.build_stop_for_warnings` option to `TRUE` or by setting the
  `PKG_BUILD_STOP_FOR_WARNINGS` environment variable to `true`
  ([\#114](https://github.com/r-lib/pkgbuild/issues/114)).

- `need_compile()` now knows about Rust source code files,
  i.e. `Cargo.toml` and `*.rs`
  ([\#115](https://github.com/r-lib/pkgbuild/issues/115)).

- Now
  [`pkgbuild::build()`](https://pkgbuild.r-lib.org/dev/reference/build.md)
  will not clean up `inst/doc` by default if the
  `Config/build/clean-inst-doc` entry in `DESCRIPTION` is set to `FALSE`
  ([\#128](https://github.com/r-lib/pkgbuild/issues/128)).

- New `PKG_BUILD_COLOR_DIAGNOSTICS` environment variable to opt out from
  colored compiler output
  ([\#141](https://github.com/r-lib/pkgbuild/issues/141)).

- pkgbuild now works with a full XCode installation if the XCode Command
  Line Tools are not installed, on macOS, in RStudio
  ([\#103](https://github.com/r-lib/pkgbuild/issues/103)).

## pkgbuild 1.3.1

CRAN release: 2021-12-20

- Accept Rtools40 for R 4.2, it works well, as long as the PATH includes
  both `${RTOOLS40_HOME}/usr/bin` and `${RTOOLS40_HOME}/ucrt64/bin`.
  E.g. `~/.Renviron` should contain now

      PATH="${RTOOLS40_HOME}\usr\bin;${RTOOLS40_HOME}\ucrt64\bin;${PATH}"

  to make Rtools40 work with both R 4.2.x (devel currently) and R 4.1.x
  and R 4.0.x.

## pkgbuild 1.3.0

CRAN release: 2021-12-09

- pkgbuild now supports Rtools 4.2.

- pkgbuild now returns the correct path for R 3.x
  ([\#96](https://github.com/r-lib/pkgbuild/issues/96)).

- [`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) now
  always returns the path of the built package
  ([\#108](https://github.com/r-lib/pkgbuild/issues/108)).

- pkgbuild output now looks better in `.Rmd` documents and in general in
  non-dynamic terminals. You can also force dynamic and non-dynamic
  output now ([\#64](https://github.com/r-lib/pkgbuild/issues/64)).

- pkgbuild does not build the PDF manual now if `pdflatex` is not
  installed, even if `manual = TRUE`
  ([\#123](https://github.com/r-lib/pkgbuild/issues/123)).

## pkgbuild 1.2.1

CRAN release: 2021-11-30

- Gábor Csárdi is now the maintainer.

- `build_setup_source` now considers both command-line build arguments,
  as well as parameters `vignettes` or `manual` when conditionally
  executing flag-dependent behaviors ([@dgkf](https://github.com/dgkf),
  [\#120](https://github.com/r-lib/pkgbuild/issues/120))

## pkgbuild 1.2.0

CRAN release: 2020-12-15

- pkgbuild is now licensed as MIT
  ([\#106](https://github.com/r-lib/pkgbuild/issues/106))
- [`compile_dll()`](https://pkgbuild.r-lib.org/dev/reference/compile_dll.md)
  gains a `debug` argument for more control over the compile options
  used ([@richfitz](https://github.com/richfitz),
  [\#100](https://github.com/r-lib/pkgbuild/issues/100))
- [`pkgbuild_process()`](https://pkgbuild.r-lib.org/dev/reference/pkgbuild_process.md)
  and [`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) now
  use colored compiler diagnostics if supported
  ([\#102](https://github.com/r-lib/pkgbuild/issues/102))
- Avoid documentation link ambiguity in R 4.1
  ([\#105](https://github.com/r-lib/pkgbuild/issues/105))

## pkgbuild 1.1.0

CRAN release: 2020-07-13

- [`compile_dll()`](https://pkgbuild.r-lib.org/dev/reference/compile_dll.md)
  now supports automatic cpp11 registration if the package links to
  cpp11.
- `rtools_needed` returns correct version instead of “custom”
  ([@burgerga](https://github.com/burgerga),
  [\#97](https://github.com/r-lib/pkgbuild/issues/97))

## pkgbuild 1.0.8

CRAN release: 2020-05-07

- Fixes for capability RStudio 1.2. and Rtools 40, R 4.0.0

## pkgbuild 1.0.7

CRAN release: 2020-04-25

- Additional fixes for Rtools 40

## pkgbuild 1.0.6

CRAN release: 2019-10-09

- Support for RTools 40 and custom msys2 toolchains that are explicitly
  set using the `CC` Makevars
  ([\#40](https://github.com/r-lib/pkgbuild/issues/40)).

## pkgbuild 1.0.5

CRAN release: 2019-08-26

- [`check_build_tools()`](https://pkgbuild.r-lib.org/dev/reference/has_build_tools.md)
  gains a `quiet` argument, to control when the message is displayed.
  The message is no longer displayed when
  [`check_build_tools()`](https://pkgbuild.r-lib.org/dev/reference/has_build_tools.md)
  is called internally by pkgbuild functions.
  ([\#83](https://github.com/r-lib/pkgbuild/issues/83))

## pkgbuild 1.0.4

CRAN release: 2019-08-05

- [`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) gains a
  `clean_doc` argument, to control if the `inst/doc` directory is
  cleaned before building.
  ([\#79](https://github.com/r-lib/pkgbuild/issues/79),
  [\#75](https://github.com/r-lib/pkgbuild/issues/75))

- [`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) and
  `pkgbuild_process` now have standard output and error are correctly
  interleaved, by redirecting the standard error of build process to the
  standard output ([@gaborcsardi](https://github.com/gaborcsardi),
  [\#78](https://github.com/r-lib/pkgbuild/issues/78)).

- [`check_build_tools()`](https://pkgbuild.r-lib.org/dev/reference/has_build_tools.md)
  now has a more helpful error message which points you towards ways to
  debug the issue ([\#68](https://github.com/r-lib/pkgbuild/issues/68)).

- `pkgbuild_process` now do not set custom compiler flags, and it uses
  the user’s `Makevars` file
  ([@gaborcsardi](https://github.com/gaborcsardi),
  [\#76](https://github.com/r-lib/pkgbuild/issues/76)).

- [`rtools_path()`](https://pkgbuild.r-lib.org/dev/reference/has_rtools.md)
  now returns `NA` on non-windows systems and also works when
  [`has_rtools()`](https://pkgbuild.r-lib.org/dev/reference/has_rtools.md)
  has not been run previously
  ([\#74](https://github.com/r-lib/pkgbuild/issues/74)).

## pkgbuild 1.0.3

CRAN release: 2019-03-20

- Tests which wrote to the package library are now skipped on CRAN.

- [`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) can now
  build a tar.gz file directly
  ([\#55](https://github.com/r-lib/pkgbuild/issues/55))

## pkgbuild 1.0.2

CRAN release: 2018-10-16

- [`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) and
  [`compile_dll()`](https://pkgbuild.r-lib.org/dev/reference/compile_dll.md)
  gain a `register_routines` argument, to automatically register C
  routines with `tools::package_native_routines_registration_skeleton()`
  ([\#50](https://github.com/r-lib/pkgbuild/issues/50))

- [`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) will
  now warn if trying to build packages on R versions \<= 3.4.2 on
  Windows with a space in the R installation directory
  ([\#49](https://github.com/r-lib/pkgbuild/issues/49))

- [`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) will
  now message if a build contains long paths, which are unsupported on
  windows ([\#48](https://github.com/r-lib/pkgbuild/issues/48))

- [`compile_dll()`](https://pkgbuild.r-lib.org/dev/reference/compile_dll.md)
  no longer doubles output, a regression caused by the styling callback.
  (<https://github.com/r-lib/devtools/issues/1877>)

- [`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) output
  is now styled like that in the rcmdcheck package
  (<https://github.com/r-lib/devtools/issues/1874>).

- [`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) no
  longer sets compile flags
  ([\#46](https://github.com/r-lib/pkgbuild/issues/46))

## pkgbuild 1.0.1

CRAN release: 2018-09-18

- Preliminary support for rtools 4.0
  ([\#40](https://github.com/r-lib/pkgbuild/issues/40))

- [`compile_dll()`](https://pkgbuild.r-lib.org/dev/reference/compile_dll.md)
  now does not supply compiler flags if there is an existing user
  defined Makevars file.

- [`local_build_tools()`](https://pkgbuild.r-lib.org/dev/reference/has_build_tools.md)
  function added to provide a deferred equivalent to
  [`with_build_tools()`](https://pkgbuild.r-lib.org/dev/reference/has_build_tools.md).
  So you can add rtools to the PATH until the end of a function body.

## pkgbuild 1.0.0

CRAN release: 2018-06-27

- Add metadata to support Rtools 3.5
  ([\#38](https://github.com/r-lib/pkgbuild/issues/38)).

- [`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) only
  uses the `--no-resave-data` argument in `R CMD build` if the
  `--resave-data` argument wasn’t supplied by the user
  ([@theGreatWhiteShark](https://github.com/theGreatWhiteShark),
  [\#26](https://github.com/r-lib/pkgbuild/issues/26))

- [`build()`](https://pkgbuild.r-lib.org/dev/reference/build.md) now
  cleans existing vignette files in `inst/doc` if they exist.
  ([\#10](https://github.com/r-lib/pkgbuild/issues/10))

- [`clean_dll()`](https://pkgbuild.r-lib.org/dev/reference/clean_dll.md)
  also deletes `symbols.rds` which is created when
  [`compile_dll()`](https://pkgbuild.r-lib.org/dev/reference/compile_dll.md)
  is run inside of `R CMD check`.

- First argument of all functions is now `path` rather than `pkg`.
