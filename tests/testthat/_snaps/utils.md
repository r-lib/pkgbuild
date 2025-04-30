# should_stop_for_warnings

    Code
      should_stop_for_warnings()
    Condition
      Error in `get_config_flag_value()`:
      ! The `pkg.build_stop_for_warnings` option must be `TRUE` or `FALSE`, if set.

---

    Code
      should_stop_for_warnings()
    Condition
      Error in `interpret_envvar_flag()`:
      ! The `PKG_BUILD_STOP_FOR_WARNINGS` environment variable must be `true` or `false`, if set.

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

