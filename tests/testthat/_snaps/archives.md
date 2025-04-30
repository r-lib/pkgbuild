# pkg_has_src on non-package files

    Code
      pkg_has_src(file.path("fixtures", "xxx.zip"))
    Condition
      Error in `doTryCatch()`:
      ! fixtures/xxx.zip is not a valid package archive file, no DESCRIPTION file
    Code
      pkg_has_src(file.path("fixtures", "xxx.tar.gz"))
    Condition
      Error in `doTryCatch()`:
      ! fixtures/xxx.tar.gz is not a valid package archive file, no DESCRIPTION file

