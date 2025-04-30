test_that("has_compiler_colored_diagnostics", {
  local_mocked_bindings(cache_exists = function(...) stop("nope"))

  withr::local_envvar(PKG_BUILD_COLOR_DIAGNOSTICS = "true")
  expect_true(has_compiler_colored_diagnostics())

  withr::local_envvar(PKG_BUILD_COLOR_DIAGNOSTICS = "false")
  expect_false(has_compiler_colored_diagnostics())

  withr::local_envvar(PKG_BUILD_COLOR_DIAGNOSTICS = NA_character_)
  expect_snapshot(error = TRUE, has_compiler_colored_diagnostics())
})
