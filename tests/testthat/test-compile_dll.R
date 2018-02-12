context("compile_dll")

test_that("can compile a DLL and clean up afterwards", {
  expect_error(compile_dll("testWithSrc", quiet = FALSE), NA)

  clean_dll("testWithSrc")
  expect_equal(dir("testWithSrc/src"), "add1.c")
})
