context("build")

# Package build setup ----------------------------------------------------

test_that("with*_latex context fixtures force has_latex result", {
  expect_true(with_latex(has_latex()))
  expect_false(without_latex(has_latex()))

  # one of them should be different from default
  expect_true({
    with_latex(has_latex()) != has_latex() ||
    without_latex(has_latex()) != has_latex()
  })
})

# expect `manual=TRUE` & empty `args` not to add build --no-manual flag
test_that("source build setup accept args and/or parameterized helpers", {
  expect_silent(res <- with_latex({
    build_setup_source(
      file.path(testthat::test_path(), "testDummy"),
      file.path(tempdir(), "testDummyBuild"),
      vignettes = FALSE,
      manual = TRUE,
      clean_doc = FALSE,
      args = c(),
      needs_compilation = FALSE
    )
  }))
  expect_true(!"--no-manual" %in% res$args)

  # expect `manual=FALSE` to affect build --no-manual flag
  expect_silent(res <- with_latex({
    build_setup_source(
      file.path(testthat::test_path(), "testDummy"),
      file.path(tempdir(), "testDummyBuild"),
      vignettes = FALSE,
      manual = FALSE,
      clean_doc = FALSE,
      args = c(),
      needs_compilation = FALSE
    )
  }))
  expect_true("--no-manual" %in% res$args)

  # expect `args` "--no-manual" to affect build --no-manual flag
  expect_silent(res <- with_latex({
    build_setup_source(
      file.path(testthat::test_path(), "testDummy"),
      file.path(tempdir(), "testDummyBuild"),
      vignettes = FALSE,
      manual = TRUE,
      clean_doc = FALSE,
      args = c("--no-manual"),
      needs_compilation = FALSE
    )
  }))
  expect_true("--no-manual" %in% res$args)

  expect_silent(res <- build_setup_source(
    file.path(testthat::test_path(), "testDummy"),
    file.path(tempdir(), "testDummyBuild"),
    vignettes = TRUE,
    manual = FALSE,
    clean_doc = FALSE,
    args = c(),
    needs_compilation = FALSE
  ))
  expect_true(!"--no-build-vignettes" %in% res$args)

  # expect `vignettes=FALSE` to affect build --no-build-vignettes flag
  expect_silent(res <-build_setup_source(
    file.path(testthat::test_path(), "testDummy"),
    file.path(tempdir(), "testDummyBuild"),
    vignettes = FALSE,
    manual = FALSE,
    clean_doc = FALSE,
    args = c(),
    needs_compilation = FALSE
  ))
  expect_true("--no-build-vignettes" %in% res$args)

  # expect `arg` `--no-build-vignettes` to produce --no-build-vignettes flag
  expect_silent(res <- build_setup_source(
    file.path(testthat::test_path(), "testDummy"),
    file.path(tempdir(), "testDummyBuild"),
    vignettes = TRUE,
    manual = FALSE,
    clean_doc = FALSE,
    args = c("--no-build-vignettes"),
    needs_compilation = FALSE
  ))
  expect_true("--no-build-vignettes" %in% res$args)
})

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
