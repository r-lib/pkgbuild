
test_that("should_stop_for_warnings", {
  withr::local_options(pkg.build_stop_for_warnings = NULL)
  withr::local_envvar(PKG_BUILD_STOP_FOR_WARNINGS = NA_character_)
  expect_false(should_stop_for_warnings())

  withr::local_options(pkg.build_stop_for_warnings = FALSE)
  withr::local_envvar(PKG_BUILD_STOP_FOR_WARNINGS = "true")
  expect_false(should_stop_for_warnings())

  withr::local_options(pkg.build_stop_for_warnings = TRUE)
  withr::local_envvar(PKG_BUILD_STOP_FOR_WARNINGS = "false")
  expect_true(should_stop_for_warnings())

  withr::local_options(pkg.build_stop_for_warnings = NULL)
  withr::local_envvar(PKG_BUILD_STOP_FOR_WARNINGS = "true")
  expect_true(should_stop_for_warnings())

  withr::local_options(pkg.build_stop_for_warnings = NULL)
  withr::local_envvar(PKG_BUILD_STOP_FOR_WARNINGS = "false")
  expect_false(should_stop_for_warnings())

  withr::local_options(pkg.build_stop_for_warnings = 1:10)
  withr::local_envvar(PKG_BUILD_STOP_FOR_WARNINGS = "false")
  expect_error(should_stop_for_warnings(), "option must be")

  withr::local_options(pkg.build_stop_for_warnings = NULL)
  withr::local_envvar(PKG_BUILD_STOP_FOR_WARNINGS = "foobar")
  expect_error(should_stop_for_warnings(), "environment variable must be")
})
