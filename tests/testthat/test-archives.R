
context("Package archives")

test_that("is_zip_file", {
  expect_true(is_zip_file(file.path("fixtures", "xxx.zip")))
  expect_false(is_zip_file(file.path("fixtures", "xxx.gz")))
  expect_false(is_zip_file(file.path("fixtures", "xxx.tar.gz")))
})

test_that("is_gz_file", {
  expect_false(is_gz_file(file.path("fixtures", "xxx.zip")))
  expect_true(is_gz_file(file.path("fixtures", "xxx.gz")))
  expect_true(is_gz_file(file.path("fixtures", "xxx.tar.gz")))
})

test_that("is_tar_gz_file", {
  expect_false(is_tar_gz_file(file.path("fixtures", "xxx.zip")))
  expect_false(is_tar_gz_file(file.path("fixtures", "xxx.gz")))
  expect_true(is_tar_gz_file(file.path("fixtures", "xxx.tar.gz")))
})

test_that("pkg_has_src", {
  expect_false(pkg_has_src(file.path("fixtures", "testDummy_0.1.tar.gz")))
  expect_true(pkg_has_src(file.path("fixtures", "testWithSrc_0.1.tar.gz")))
})

test_that("pkg_has_src on non-package files", {
  expect_error(pkg_has_src(file.path("fixtures", "xxx.zip")))
  expect_error(pkg_has_src(file.path("fixtures", "xxx.tar.gz")))
})
