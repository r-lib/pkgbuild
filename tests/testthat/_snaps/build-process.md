# build package with src requires compiler

    Code
      suppressMessages(local({
        pr <- pkgbuild_process$new("testWithSrc", dest_path = tempdir(),
        register_routines = FALSE)
        pr$kill()
      }))
    Condition
      Error:
      ! Could not find tools necessary to compile a package
      Call `pkgbuild::check_build_tools(debug = TRUE)` to diagnose the problem.

