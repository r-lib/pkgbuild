# pkgbuild 1.0.1

* `compile_dll()` now does not supply compiler flags if there is an existing
  user defined Makevars file.

* `local_build_tools()` function added to provide a deferred equivalent to
  `with_build_tools()`. So you can add rtools to the PATH until the end of a
  function body.

# pkgbuild 1.0.0

* Add metadata to support Rtools 3.5 (#38).

* `build()` only uses the `--no-resave-data` argument in `R CMD build`
  if the `--resave-data` argument wasn't supplied by the user
  (@theGreatWhiteShark, #26)

* `build()` now cleans existing vignette files in `inst/doc` if they exist. (#10)

* `clean_dll()` also deletes `symbols.rds` which is created when `compile_dll()`
  is run inside of `R CMD check`.

* First argument of all functions is now `path` rather than `pkg`.



