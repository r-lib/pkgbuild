context("test-compiler.R")

describe("has_compiler", {
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
})
