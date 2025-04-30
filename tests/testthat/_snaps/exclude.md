# copy_package_tree creates package dir

    Code
      sort(dir(tmp, recursive = TRUE, include.dirs = TRUE))
    Output
      [1] "testDummy"             "testDummy/DESCRIPTION" "testDummy/NAMESPACE"  
      [4] "testDummy/R"           "testDummy/R/a.R"       "testDummy/R/b.R"      

---

    Code
      sort(dir(tmp, recursive = TRUE, include.dirs = TRUE))
    Output
      [1] "testDummy"             "testDummy/DESCRIPTION" "testDummy/NAMESPACE"  
      [4] "testDummy/R"           "testDummy/R/a.R"       "testDummy/R/b.R"      

# copy_package_tree errors

    Code
      copy_package_tree(test_path("testDummy"), tmp)
    Condition
      Error in `copy_package_tree()`:
      ! Cannot copy package tree to '<tempdir>/pkgbuild-test-<id>'
      i Directory '<tempdir>/pkgbuild-test-<id>/testDummy' already exists, and did not want to overwrite.

# exclusions

    Code
      files[, c("path", "exclude", "isdir", "trimmed")]
    Output
                  path exclude isdir trimmed
      1         .RData    TRUE FALSE   FALSE
      2  .Rbuildignore   FALSE FALSE   FALSE
      3      .Rhistory    TRUE FALSE   FALSE
      4           .git    TRUE  TRUE   FALSE
      5    DESCRIPTION   FALSE FALSE   FALSE
      6           docs    TRUE  TRUE   FALSE
      7            src   FALSE  TRUE    TRUE
      8  src/.DS_Store    TRUE FALSE   FALSE
      9  src/foo.c.bak    TRUE FALSE   FALSE
      10 src/foo.c.swp    TRUE FALSE   FALSE
      11    src/foo.c~    TRUE FALSE   FALSE
      12     src/foo.d    TRUE FALSE   FALSE
      13     src/src.c   FALSE FALSE   FALSE
      14     src/src.o    TRUE FALSE   FALSE

# get_copy_method

    Code
      get_copy_method()
    Condition
      Error in `check_method()`:
      ! Invalid `pkg.build_copy_method` value: "foobar".
      i It must be one of "none", "copy", and "link".

---

    Code
      get_copy_method()
    Condition
      Error in `get_copy_method()`:
      ! Invalid `pkg.build_copy_method` value.
      i It must be a string, but it is an integer vector.

# Ignoring .Rbuildignore

    Code
      files[, c("path", "exclude", "isdir", "trimmed")]
    Output
                 path exclude isdir trimmed
      1 .Rbuildignore   FALSE FALSE   FALSE
      2   DESCRIPTION   FALSE FALSE   FALSE
      3          docs    TRUE  TRUE   FALSE
      4           src   FALSE  TRUE    TRUE
      5     src/src.c   FALSE FALSE   FALSE
      6     src/src.o    TRUE FALSE   FALSE

# copying on windows

    Code
      sort(dir(tmp, recursive = TRUE, include.dirs = TRUE))
    Output
      [1] "testDummy"             "testDummy/DESCRIPTION" "testDummy/NAMESPACE"  
      [4] "testDummy/R"           "testDummy/R/a.R"       "testDummy/R/b.R"      

# cp error

    Code
      cp("foo", "bar")
    Condition
      Error in `cp()`:
      ! Could not copy package files.
      i Failed to copy 'foo' to 'bar'.

# detect_cp_args

    Code
      detect_cp_args()
    Output
      [1] "-pLR"

---

    Code
      detect_cp_args()
    Output
      [1] "-LR"                   "--preserve=timestamps"

# cp error on Unix

    Code
      cp("foo", "bar")
    Condition
      Error in `cp()`:
      ! Could not copy package files.
      i Failed to copy 'foo' to 'bar'.

