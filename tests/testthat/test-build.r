context("build")

test_that("source builds return correct filenames", {
  path <- build("testDummy", dest_path = tempdir(), quiet = TRUE)
  on.exit(unlink(path))

  expect_true(file.exists(path))
})

test_that("binary builds return correct filenames", {
  path <- build("testDummy", binary = TRUE, dest_path = tempdir(), quiet = TRUE)
  on.exit(unlink(path))

  expect_true(file.exists(path))
})

test_that("can build package without src without compiler", {
  cache_reset()
  on.exit(cache_reset())

  with_no_compiler({
    path <- build("testDummy", binary = TRUE, dest_path = tempdir(), quiet = TRUE)
    on.exit(unlink(path))

    expect_true(file.exists(path))
  })
})
