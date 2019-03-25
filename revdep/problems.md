# codemetar

Version: 0.1.7

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘memoise’
      All declared Imports should be used.
    ```

# fakemake

Version: 1.4.0

## In both

*   checking examples ... ERROR
    ```
    Running examples in ‘fakemake-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: get_pkg_archive_path
    > ### Title: Get a Package's Archive Path From the Package's DESCRIPTION
    > ### Aliases: get_pkg_archive_path
    > 
    > ### ** Examples
    > 
    > package_path <- file.path(tempdir(), "anRpackage")
    > usethis::create_package(path = package_path)
    ✔ Setting active project to '/private/var/folders/dt/r5s12t392tb5sk181j3gs4zw0000gn/T/Rtmp8Mzmfd/anRpackage'
    ✔ Creating 'R/'
    ✔ Creating 'man/'
    ✔ Writing 'DESCRIPTION'
    ✔ Writing 'NAMESPACE'
    > print(tarball <- get_pkg_archive_path(package_path))
    Error in loadNamespace(name) : there is no package called ‘devtools’
    Calls: print ... tryCatch -> tryCatchList -> tryCatchOne -> <Anonymous>
    Execution halted
    ```

*   checking re-building of vignette outputs ... WARNING
    ```
    Error in re-building vignettes:
      ...
    Prerequisite DESCRIPTION found.
    Prerequisite R/throw.R found.
    Prerequisite R/throw.R found.
    Prerequisite R/throw.R found.
    Prerequisite R/throw.R found.
    ```

*   checking package dependencies ... NOTE
    ```
    Package suggested but not available for checking: ‘devtools’
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘pkgbuild’
      All declared Imports should be used.
    ```

# rstan

Version: 2.18.2

## In both

*   checking whether package ‘rstan’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: package ‘StanHeaders’ was built under R version 3.5.2
    See ‘.../revdep/checks.noindex/rstan/new/rstan.Rcheck/00install.out’ for details.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is 12.4Mb
      sub-directories of 1Mb or more:
        R      2.1Mb
        libs   8.3Mb
    ```

*   checking Rd cross-references ... NOTE
    ```
    Packages unavailable to check Rd xrefs: ‘coda’, ‘rstanarm’
    ```

