context("build_tools")

test_that("tests always run in environment with dev tools", {
  on.exit(cache_reset())

  expect_true(has_compiler())
  expect_true(has_build_tools())
  expect_true(has_latex())
  expect_equal(has_rtools(), is_windows())
})

test_that("with dummy path, no build tools found", {
  on.exit(cache_reset())

  withr::with_path(".", action = "replace", {
    expect_false(has_compiler())
    expect_false(has_build_tools())
    expect_false(has_latex())
    expect_false(has_rtools())
  })
})