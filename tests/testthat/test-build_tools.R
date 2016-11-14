context("build_tools")

test_that("tests always run in environment with dev tools", {
  without_cache({
    expect_true(has_build_tools())
    expect_equal(has_rtools(), is_windows())
  })
})

test_that("unless specifically disabled", {
  without_compiler({
    expect_false(has_build_tools())
    expect_false(has_rtools())
  })
})
