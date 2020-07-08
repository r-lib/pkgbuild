context("test-rtools.R")

test_that("has_rtools finds rtools", {
  skip_if_not(is_windows() && !is.null(scan_path_for_rtools()))

  # Rtools path can be looked up by the PATH
  without_cache({
    expect_true(has_rtools())
    expect_true(!is.null(scan_path_for_rtools()))
  })

  withr::with_path(Sys.getenv("R_HOME"), action = "replace", {
   expect_equal(scan_path_for_rtools(), NULL)
  })

  skip_if_not(!is.null(scan_registry_for_rtools()))

  # Rtools path can be looked up from the registery
  expect_true(!is.null(scan_registry_for_rtools()))
  without_cache(
    withr::with_path(Sys.getenv("R_HOME"), action = "replace", {
      has_rtools()
      expect_true(rtools_path() != "")
    }))
})

test_that("rtools_needed works", {
  skip_if_not(is_windows())

  # Test only frozen versions
  expect_equal(rtools_needed("3.6.3"), "Rtools 3.5")
  expect_equal(rtools_needed("2.9"), "Rtools 3.0")
  expect_equal(rtools_needed("0.0.0"), "the appropriate version of Rtools")
})
