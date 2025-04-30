# has_compiler: succeeds if a compiler exists

    Code
      check_compiler()
    Condition
      Error:
      ! Failed to compile C code

# has_compiler: returns the value of the has_compiler option

    Code
      check_compiler()
    Condition
      Error:
      ! Failed to compile C code

---

    Code
      has_compiler()
    Condition
      Error in `has_compiler()`:
      ! 
      ! Invalid `pkgbuild.has_compiler` option.
      i It must be `TRUE` or `FALSE`, not an integer vector.

