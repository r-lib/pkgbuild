context("build")

test_that("source builds return correct filenames", {
  path <- build("testNamespace", dest_path = tempdir(), quiet = TRUE)
  on.exit(unlink(path))

  expect_true(file.exists(path))
})

test_that("binary builds return correct filenames", {
  path <- build("testNamespace", binary = TRUE, dest_path = tempdir(), quiet = TRUE)
  on.exit(unlink(path))

  expect_true(file.exists(path))
})
