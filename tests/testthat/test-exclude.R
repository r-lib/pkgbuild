
test_that("copy_package_tree creates package dir", {
  tmp <- withr::local_tempdir("pkgbuild-test-")

  # link
  withr::local_options(pkg.build_copy_method = "link")
  unlink(tmp, recursive = TRUE)
  expect_no_warning(
    copy_package_tree(test_path("testDummy"), tmp)
  )
  expect_snapshot(
    sort(dir(tmp, recursive = TRUE, include.dirs = TRUE))
  )

  # copy
  withr::local_options(pkg.build_copy_method = "copy")
  unlink(tmp, recursive = TRUE)
  expect_no_warning(
    copy_package_tree(test_path("testDummy"), tmp)
  )
  expect_snapshot(
    sort(dir(tmp, recursive = TRUE, include.dirs = TRUE))
  )
})

test_that("copy_package_tree errors", {
  tmp <- withr::local_tempdir("pkgbuild-test-")
  mkdirp(file.path(tmp, "testDummy"))
  expect_error(
    copy_package_tree(test_path("testDummy"), tmp),
    "already exists"
  )
})

test_that("exclusions", {
  pkgdir <- file.path(withr::local_tempdir("pkgbuild-test-"), "pkg")
  mkdirp(pkgdir)
  writeLines(
    c("Package: pkg", "Version: 1.0.0"),
    file.path(pkgdir, "DESCRIPTION")
  )

  # create some structure with files to ignore and keep
  writeLines(c(
    "^docs$",
    "^src/.*[.]o$"
  ), file.path(pkgdir, ".Rbuildignore"))

  mkdirp(file.path(pkgdir, "src"))
  file.create(file.path(pkgdir, "src", "src.c"))
  file.create(file.path(pkgdir, "src", "src.o"))
  mkdirp(file.path(pkgdir, "docs"))
  file.create(file.path(pkgdir, "docs", "foo"))

  file.create(file.path(pkgdir, "src", ".DS_Store"))
  file.create(file.path(pkgdir, ".Rhistory"))
  file.create(file.path(pkgdir, ".RData"))
  file.create(file.path(pkgdir, "src", "foo.c~"))
  file.create(file.path(pkgdir, "src", "foo.c.bak"))
  file.create(file.path(pkgdir, "src", "foo.c.swp"))
  file.create(file.path(pkgdir, "src", "foo.d"))
  dir.create(file.path(pkgdir, ".git"))
  file.create(file.path(pkgdir, ".git", "foo"))

  files <- build_files(pkgdir)
  expect_snapshot(files[, c("path", "exclude", "isdir", "trimmed")])

  dest <- withr::local_tempdir("pkgbuild-test-")
  copy_package_tree(pkgdir, dest)
})

test_that("get_copy_method", {
  mockery::stub(get_copy_method, "is_windows", TRUE)
  withr::local_options(pkg.build_copy_method = "link")
  expect_equal(get_copy_method(), "copy")

  withr::local_options(pkg.build_copy_method = "foobar")
  expect_error(get_copy_method(), "pkg.build_copy_method")

  withr::local_options(pkg.build_copy_method = 1:10)
  expect_error(get_copy_method(), "It must be a string")

  withr::local_options(pkg.build_copy_method = NULL)
  mockery::stub(get_copy_method, "desc::desc_get", "link")
  expect_equal(get_copy_method(), "copy")
})

test_that("Ignoring .Rbuildignore", {
  pkgdir <- file.path(withr::local_tempdir("pkgbuild-test-"), "pkg")
  mkdirp(pkgdir)
  writeLines(
    c("Package: pkg", "Version: 1.0.0"),
    file.path(pkgdir, "DESCRIPTION")
  )

  # create some structure with files to ignore and keep
  writeLines(c(
    "^docs$",
    "^src/.*[.]o$",
    "^\\.Rbuildignore$"
  ), file.path(pkgdir, ".Rbuildignore"))

  mkdirp(file.path(pkgdir, "src"))
  file.create(file.path(pkgdir, "src", "src.c"))
  file.create(file.path(pkgdir, "src", "src.o"))
  mkdirp(file.path(pkgdir, "docs"))
  file.create(file.path(pkgdir, "docs", "foo"))

  files <- build_files(pkgdir)
  expect_snapshot(files[, c("path", "exclude", "isdir", "trimmed")])
})

test_that("copying on windows", {
  # this works on Unix as well
  environment(cp)$wind <- TRUE
  on.exit(environment(cp)$wind <- NULL, add = TRUE)
  tmp <- withr::local_tempdir("pkgbuild-test-")

  # link
  withr::local_options(pkg.build_copy_method = "copy")
  unlink(tmp, recursive = TRUE)
  expect_no_warning(
    copy_package_tree(test_path("testDummy"), tmp)
  )
  expect_snapshot(
    sort(dir(tmp, recursive = TRUE, include.dirs = TRUE))
  )
})

test_that("cp error", {
  environment(cp)$wind <- TRUE
  on.exit(environment(cp)$wind <- NULL, add = TRUE)
  withr::local_dir(withr::local_tempdir())
  expect_snapshot(error = TRUE, cp("foo", "bar"))
})

test_that("detect_cp_args", {
  mockery::stub(
    detect_cp_args,
    "processx::run",
    function(...) stop("nope")
  )
  expect_snapshot(detect_cp_args())

  mockery::stub(
    detect_cp_args,
    "processx::run",
    function(f1, f2) file.create(f2)
  )
  expect_snapshot(detect_cp_args())
})

test_that("cp error on Unix", {
  skip_on_os("windows")
  withr::local_dir(withr::local_tempdir())
  expect_snapshot(
    error = TRUE,
    cp("foo", "bar"),
    # do not include the cp output because it is slightly different on
    # macOS, Linux, etc.
    transform = function(x) utils::head(x, 3)
  )
})
