
describe("has_compiler", {
  withr::local_options(pkgbuild.has_compiler = NULL)
  testthat::local_reproducible_output()
  it("succeeds if a compiler exists", {
    skip_if(is_windows() && !has_rtools())
    without_cache({
      without_compiler({
        expect_false(has_compiler())
        expect_error(check_compiler(), "Failed to compile C code")
      })
      cache_reset()
      expect_true(has_compiler())
      expect_true(check_compiler())
    })
  })

  it("returns the value of the has_compiler option", {
    skip_if(is_windows() && !has_rtools())
    without_cache({
      without_compiler({
        withr::with_options(
          c(pkgbuild.has_compiler = TRUE),
          {
            expect_true(has_compiler())
            expect_error(check_compiler(), NA)
          }
        )
      })
      cache_reset()
      withr::with_options(
        c(pkgbuild.has_compiler = FALSE),
        {
          expect_false(has_compiler())
          expect_error(check_compiler(), "Failed to compile C code")
        }
      )
      withr::with_options(
        list(pkgbuild.has_compiler = 1:2),
        expect_snapshot(
          error = TRUE,
          has_compiler()
        )
      )
    })
  })
})
