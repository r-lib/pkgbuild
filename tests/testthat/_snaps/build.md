# build package with src requires compiler

    Code
      suppressMessages(build("testWithSrc", dest_path = tempdir(), quiet = TRUE))
    Condition
      Error:
      ! Could not find tools necessary to compile a package
      Call `pkgbuild::check_build_tools(debug = TRUE)` to diagnose the problem.

# package tarball binary build errors

    Code
      build(path, dest_path = tempdir(), quiet = TRUE)
    Condition
      Error:
      ! `binary` must be TRUE for package files

---

    Code
      build(path, dest_path = tempdir(), quiet = TRUE, binary = TRUE,
      needs_compilation = FALSE, compile_attributes = TRUE)
    Condition
      Error:
      ! `compile_attributes` must be FALSE for package files

