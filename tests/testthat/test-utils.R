
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

test_that("isFALSE", {
  pos <- list(FALSE, structure(FALSE, class = "foo"))
  neg <- list(1, c(FALSE, TRUE), NA, list(FALSE))
  for (p in pos) expect_true(isFALSE(p), info = p)
  for (n in neg) expect_false(isFALSE(n), info = n)
})

test_that("should_add_compiler_flags", {
  # should not be called if option is set
  mockery::stub(
    should_add_compiler_flags,
    "makevars_user",
    function() stop("dont")
  )

  # options is TRUE
  withr::local_options(pkg.build_extra_flags = TRUE)
  expect_true(should_add_compiler_flags())

  # options is FALSE
  withr::local_options(pkg.build_extra_flags = FALSE)
  expect_false(should_add_compiler_flags())

  # depends on whether Makevars exists
  withr::local_options(pkg.build_extra_flags = "missing")
  mockery::stub(
    should_add_compiler_flags,
    "makevars_user",
    function() character()
  )
  expect_true(should_add_compiler_flags())
  mockery::stub(
    should_add_compiler_flags,
    "makevars_user",
    function() "foobar"
  )
  withr::local_options(pkg.build_extra_flags = "missing")
  expect_false(should_add_compiler_flags())

  mockery::stub(
    should_add_compiler_flags,
    "makevars_user",
    function() stop("dont")
  )
  withr::local_options(pkg.build_extra_flags = NULL)

  # env var true
  withr::local_envvar(PKG_BUILD_EXTRA_FLAGS = "true")
  expect_true(should_add_compiler_flags())

  # env var false
  withr::local_envvar(PKG_BUILD_EXTRA_FLAGS = "false")
  expect_false(should_add_compiler_flags())

  # depends on whether Makevars exists
  withr::local_envvar(PKG_BUILD_EXTRA_FLAGS = "missing")
  mockery::stub(
    should_add_compiler_flags,
    "makevars_user",
    function() character()
  )
  expect_true(should_add_compiler_flags())
  mockery::stub(
    should_add_compiler_flags,
    "makevars_user",
    function() "foobar"
  )
  expect_false(should_add_compiler_flags())

  # no option or env var, then TRUE
  mockery::stub(
    should_add_compiler_flags,
    "makevars_user",
    function() stop("dont")
  )
  withr::local_options(pkg.build_extra_flags = NULL)
  withr::local_envvar(PKG_BUILD_EXTRA_FLAGS = NA_character_)
  expect_true(should_add_compiler_flags())
})

test_that("should_add_compiler_flags errors", {
  # invalid option type
  withr::local_options(pkg.build_extra_flags = 1:10)
  expect_snapshot(error = TRUE, should_add_compiler_flags())

  # invalid option value
  withr::local_options(pkg.build_extra_flags = "foobar")
  expect_snapshot(error = TRUE, should_add_compiler_flags())

  # invalid env var value
  withr::local_options(pkg.build_extra_flags = NULL)
  withr::local_envvar(PKG_BUILD_EXTRA_FLAGS = "foo")
  expect_snapshot(error = TRUE, should_add_compiler_flags())
})
