context("test-compile_dll.R")

test_that("can compile a DLL and clean up afterwards", {
  expect_error(compile_dll("testWithSrc", quiet = TRUE, register_routines = FALSE), NA)

  clean_dll("testWithSrc")
  expect_equal(dir("testWithSrc/src"), "add1.c")
})
