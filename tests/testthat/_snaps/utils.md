# should_add_compiler_flags errors

    Code
      should_add_compiler_flags()
    Condition
      Error in `should_add_compiler_flags()`:
      ! Invalid `pkg.build_extra_flags` option.
      i It must be `TRUE`, `FALSE` or "missing", not an integer vector.

---

    Code
      should_add_compiler_flags()
    Condition
      Error in `should_add_compiler_flags()`:
      ! Invalid `pkg_build_extra_flags` option.
      i It must be `TRUE`, `FALSE` or "missing", not "foobar".

---

    Code
      should_add_compiler_flags()
    Condition
      Error in `should_add_compiler_flags()`:
      ! Invalid `PKG_BUILD_EXTRA_FLAGS` environment variable.
      i Must be one of `true`, `false` or `missing`.

