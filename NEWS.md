# pkgbuild 0.0.0.9000

* Add metadata to support Rtools 3.5 (#38).

* `build()` only uses the `--no-resave-data` argument in `R CMD build`
  if the `--resave-data` argument wasn't supplied by the user
  (@theGreatWhiteShark, #26)

* `build()` now cleans existing vignette files in `inst/doc` if they exist. (#10)

* `clean_dll()` also deletes `symbols.rds` which is created when `compile_dll()`
  is run inside of `R CMD check`.

* First argument of all functions is now `path` rather than `pkg`.



