context("pkgbuild_process")

# Package without source code --------------------------------------------

test_that("source builds return correct filenames", {
  dir.create(tmp <- tempfile())
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)

  pr <- pkgbuild_process$new("testDummy", dest_path = tmp)
  pr$wait(60000)
  if (pr$is_alive()) {
    pr$kill()
    skip("has not finished in one minute")
  }

  expect_true(file.exists(pr$get_dest_path()))
  expect_true(file.exists(pr$get_built_file()))
  expect_true(!is.na(desc::desc(pr$get_built_file())$get("Packaged")))
})

test_that("binary builds return correct filenames", {
  # building binaries also installs them to the library, so we need to skip on
  # CRAN.
  skip_on_cran()

  dir.create(tmp <- tempfile())
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)

  pr <- pkgbuild_process$new("testDummy", binary = TRUE, dest_path = tmp)
  pr$wait(60000)
  if (pr$is_alive()) {
    pr$kill()
    skip("has not finished in one minute")
  }

  expect_true(file.exists(pr$get_dest_path()))
  expect_true(file.exists(pr$get_built_file()))
  expect_true(!is.na(desc::desc(pr$get_built_file())$get("Built")))
})

test_that("can build package without src without compiler", {
  # building binaries also installs them to the library, so we need to skip on
  # CRAN.
  skip_on_cran()

  dir.create(tmp <- tempfile())
  on.exit(unlink(tmp, recursive = TRUE))

  without_compiler({
    pr <- pkgbuild_process$new("testDummy", binary = TRUE, dest_path = tmp)
    pr$wait(60000)
    if (pr$is_alive()) {
      pr$kill()
      skip("has not finished in one minute")
    }

    expect_true(file.exists(pr$get_dest_path()))
    expect_true(file.exists(pr$get_built_file()))
    expect_true(!is.na(desc::desc(pr$get_built_file())$get("Built")))
  })
})


# Package with src code ---------------------------------------------------

test_that("source builds return correct filenames", {
  dir.create(tmp <- tempfile())
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)

  pr <- pkgbuild_process$new("testWithSrc", dest_path = tmp, register_routines = FALSE)
  pr$wait(60000)
  if (pr$is_alive()) {
    pr$kill()
    skip("has not finished in one minute")
  }

  expect_true(file.exists(pr$get_dest_path()))
  expect_true(file.exists(pr$get_built_file()))
  expect_true(!is.na(desc::desc(pr$get_built_file())$get("Packaged")))
})

test_that("build package with src requires compiler", {
  without_compiler({
    expect_error({
      pr <- pkgbuild_process$new("testWithSrc", dest_path = tempdir(), register_routines = FALSE)
      pr$kill()
    }, "Could not find tools")
  })
})

test_that("can get output, exit status, etc.", {
  dir.create(tmp <- tempfile())
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)

  pr <- pkgbuild_process$new("testDummy", dest_path = tmp)
  pr$wait(60000)
  if (pr$is_alive()) {
    pr$kill()
    skip("has not finished in one minute")
  }

  out <- pr$read_all_output()
  expect_match(out, "* building", fixed = TRUE)
  expect_error(err <- pr$read_all_error(), NA)
  expect_equal(pr$get_exit_status(), 0)

  path <- pr$get_dest_path()
  on.exit(unlink(path))
})

test_that("can kill a build process", {
  dir.create(tmp <- tempfile())
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)

  pr <- pkgbuild_process$new("testDummy", dest_path = tmp)
  ret <- pr$kill()
  if (!ret) skip("build finished before we could kill it")

  ex_stat <- pr$get_exit_status()
  if (.Platform$OS.type == "unix") {
    expect_equal(ex_stat, -9)
  } else {
    expect_true(ex_stat != 0)
  }
})
