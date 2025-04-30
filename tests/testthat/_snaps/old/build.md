# warnings can be turned into errors

    Code
      if (getRversion() >= "4.1") {
        build(file.path(src, "testDummy"), dest_path = dest, quiet = TRUE)
      } else {
        suppressMessages(build(file.path(src, "testDummy"), dest_path = dest, quiet = TRUE))
      }
    Condition
      Error in `force()`:
      ! converted from `R CMD build` warning.

