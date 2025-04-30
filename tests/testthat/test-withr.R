test_that("withr_with_makevars", {
  skip_on_cran()
  # need to run this without a user Makevars file
  file.create(tmpmake <- tempfile())
  on.exit(unlink(tmpmake), add = TRUE)
  withr::local_envvar("R_MAKEVARS_USER" = tmpmake, R_MAKEVARS_SITE = tmpmake)

  split_lines <- function(x) strsplit(x, "\n\r?")[[1]]

  orig <- split_lines(callr::rcmd("config", "CFLAGS")$stdout)
  new <- withr_with_makevars(
    new = c(CFLAGS = "-DFOO"),
    split_lines(callr::rcmd("config", "CFLAGS")$stdout)
  )
  expect_equal(new, paste(orig, "-DFOO"))

  # with our own custom Makevars file
  tmp <- tempfile()
  on.exit(unlink(tmp), add = TRUE)
  writeLines(
    c(
      "CFLAGS=-DTHIS",
      "CXXFLAGS+=-DTHAT"
    ),
    tmp
  )

  orig <- split_lines(callr::rcmd("config", "CFLAGS")$stdout)
  new <- withr_with_makevars(
    new = c(CFLAGS = "-DFOO"),
    path = tmp,
    split_lines(callr::rcmd("config", "CFLAGS")$stdout)
  )
  expect_equal(new, "-DTHIS -DFOO")

  orig <- split_lines(callr::rcmd("config", "CXXFLAGS")$stdout)
  new <- withr_with_makevars(
    new = c(CXXFLAGS = "-DFOO"),
    path = tmp,
    split_lines(callr::rcmd("config", "CXXFLAGS")$stdout)
  )
  expect_equal(new, paste(orig, "-DTHAT -DFOO"))
})
