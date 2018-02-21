context("rcmdbuild_process")

# Package without source code --------------------------------------------

test_that("source builds return correct filenames", {
  pr <- rcmdbuild_process$new("testDummy", dest_path = tempdir())
  pr$wait(60000)
  if (pr$is_alive()) {
    pr$kill()
    skip("has not finished in one minute")
  }

  path <- pr$get_dest_path()
  on.exit(unlink(path))

  expect_true(file.exists(path))
})

test_that("binary builds return correct filenames", {
  pr <- rcmdbuild_process$new("testDummy", binary = TRUE,
                              dest_path = tempdir())
  pr$wait(60000)
  if (pr$is_alive()) {
    pr$kill()
    skip("has not finished in one minute")
  }

  path <- pr$get_dest_path()
  on.exit(unlink(path))

  expect_true(file.exists(path))
})

test_that("can build package without src without compiler", {
  without_compiler({
    pr <- rcmdbuild_process$new("testDummy", binary = TRUE,
                                dest_path = tempdir())
    pr$wait(60000)
    if (pr$is_alive()) {
      pr$kill()
      skip("has not finished in one minute")
    }

    path <- pr$get_dest_path()
    on.exit(unlink(path))

    expect_true(file.exists(path))
  })
})


# Package with src code ---------------------------------------------------

test_that("source builds return correct filenames", {
  pr <- rcmdbuild_process$new("testWithSrc", dest_path = tempdir())
  pr$wait(60000)
  if (pr$is_alive()) {
    pr$kill()
    skip("has not finished in one minute")
  }

  path <- pr$get_dest_path()
  on.exit(unlink(path))

  expect_true(file.exists(path))
})

test_that("build package with src requires compiler", {
  without_compiler({
    expect_error({
      pr <- rcmdbuild_process$new("testWithSrc", dest_path = tempdir())
      pr$kill()
    }, "Could not find tools")
  })
})

test_that("can get output, exit status, etc.", {
  pr <- rcmdbuild_process$new("testDummy", dest_path = tempdir())
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
