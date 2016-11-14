context("build_tools")

test_that("tests always run in environment with dev tools", {
  without_cache({
    expect_true(has_compiler())
    expect_true(has_build_tools())
    expect_equal(has_rtools(), is_windows())
  })
})

test_that("with dummy path, no build tools found", {
  without_compiler({
    expect_false(has_compiler())
    expect_false(has_build_tools())
  })
})
