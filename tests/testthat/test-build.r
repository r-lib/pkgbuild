context("build")

# Package without source code --------------------------------------------

test_that("source builds return correct filenames", {
  path <- build("testDummy", dest_path = tempdir(), quiet = TRUE)
  on.exit(unlink(path))

  expect_true(file.exists(path))
  expect_false(is.na(desc::desc(path)$get("Packaged")))
  expect_true(is.na(desc::desc(path)$get("Built")))
})

test_that("binary builds return correct filenames", {
  path <- build("testDummy", binary = TRUE, dest_path = tempdir(), quiet = TRUE)
  on.exit(unlink(path))

  expect_true(file.exists(path))
})

test_that("can build package without src without compiler", {
  without_compiler({
    path <- build("testDummy", binary = TRUE, dest_path = tempdir(), quiet = TRUE)
    on.exit(unlink(path))

    expect_true(file.exists(path))
  })
})


# Package with src code ---------------------------------------------------

test_that("source builds return correct filenames", {
  path <- build("testWithSrc", dest_path = tempdir(), quiet = TRUE, register_routines = FALSE)
  on.exit(unlink(path))

  expect_true(file.exists(path))
})

test_that("build package with src requires compiler", {
  without_compiler({
    expect_error(
      build("testWithSrc", dest_path = tempdir(), quiet = TRUE),
      "Could not find tools"
    )
  })
})

# Package files -----------------------------------------------------------

test_that("package tarball binary build", {
  path <- build("testDummy", dest_path = tempdir(), quiet = TRUE)
  on.exit(unlink(path), add = TRUE)

  path2 <- build(path, dest_path = tempdir(), quiet = TRUE,
                 binary = TRUE, needs_compilation = FALSE,
                 compile_attributes = FALSE)
  on.exit(unlink(path2), add = TRUE)
  expect_true(file.exists(path2))
  expect_false(is.na(desc::desc(path2)$get("Packaged")))
  expect_false(is.na(desc::desc(path2)$get("Built")))
})

test_that("package tarball binary build errors", {
  path <- build("testDummy", dest_path = tempdir(), quiet = TRUE)
  on.exit(unlink(path), add = TRUE)

  expect_error(
    build(path, dest_path = tempdir(), quiet = TRUE),
    "binary")
  expect_error(
    build(path, dest_path = tempdir(), quiet = TRUE, binary = TRUE,
          needs_compilation = FALSE, compile_attributes = TRUE),
    "compile_attributes")
})
