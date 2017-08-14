# pkgbuild 0.0.0.9000

* `clean_dll()` also deletes `symbols.rds` which is created when `compile_dll()`
  is run inside of `R CMD check`.

* First argument of all functions is now `path` rather than `pkg`.

* New global option `devtools.clean.compile.subdir.changes`. If it is
  set to `TRUE`, any change in subdirectories trigger a complete
  recompilation.

