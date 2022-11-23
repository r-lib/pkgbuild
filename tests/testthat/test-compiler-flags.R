
test_that("has_compiler_colored_diagnostics", {
  mockery::stub(
    has_compiler_colored_diagnostics,
    "cache_exists",
    function(...) stop("nope")
  )

  withr::local_envvar(PKG_BUILD_COLOR_DIAGNOSTICS = "true")
  expect_true(has_compiler_colored_diagnostics())

  withr::local_envvar(PKG_BUILD_COLOR_DIAGNOSTICS = "false")
  expect_false(has_compiler_colored_diagnostics())

  withr::local_envvar(PKG_BUILD_COLOR_DIAGNOSTICS = NA_character_)
  expect_error(has_compiler_colored_diagnostics(), "nope")
})
