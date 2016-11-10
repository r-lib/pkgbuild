context("build_tools")

test_that("tests always run in environment with dev tools", {
  expect_true(has_compiler())
  expect_true(has_build_tools())
  expect_equal(has_rtools(), is_windows())
})

