# codemetar

<details>

* Version: 0.1.8
* Source code: https://github.com/cran/codemetar
* URL: https://github.com/ropensci/codemetar, https://ropensci.github.io/codemetar
* BugReports: https://github.com/ropensci/codemetar/issues
* Date/Publication: 2019-04-22 04:20:03 UTC
* Number of recursive dependencies: 79

Run `revdep_details(,"codemetar")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘memoise’
      All declared Imports should be used.
    ```

# ctsem

<details>

* Version: 3.0.0
* Source code: https://github.com/cran/ctsem
* URL: https://github.com/cdriveraus/ctsem
* Date/Publication: 2019-07-31 12:40:07 UTC
* Number of recursive dependencies: 109

Run `revdep_details(,"ctsem")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking installed package size ... NOTE
    ```
      installed size is 10.1Mb
      sub-directories of 1Mb or more:
        R      2.0Mb
        data   1.7Mb
        libs   5.3Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘pkgbuild’
      All declared Imports should be used.
    ```

# jwutil

<details>

* Version: 1.2.3
* Source code: https://github.com/cran/jwutil
* URL: https://github.com/jackwasey/jwutil
* BugReports: https://github.com/jackwasey/jwutil/issues
* Date/Publication: 2019-05-06 19:10:03 UTC
* Number of recursive dependencies: 56

Run `revdep_details(,"jwutil")` for more info

</details>

## In both

*   checking whether package ‘jwutil’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘.../revdep/checks.noindex/jwutil/new/jwutil.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘jwutil’ ...
** package ‘jwutil’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c get_current_stdlib.cpp -o get_current_stdlib.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c jwomp.cpp -o jwomp.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c rowsorted.cpp -o rowsorted.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c stdlib.cpp -o stdlib.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c test-jwutil.cpp -o test-jwutil.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c test-runner.cpp -o test-runner.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c util.cpp -o util.o
clang: error: unsupported option '-fopenmp'
clang: error: unsupported option '-fopenmp'
make: *** [test-jwutil.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [jwomp.o] Error 1
clang: error: unsupported option '-fopenmp'
clang: error: unsupported option '-fopenmp'
make: *** [rowsorted.o] Error 1
clang: error: unsupported option '-fopenmp'
clang: error: unsupported option '-fopenmp'
make: *** [RcppExports.o] Error 1
make: *** [test-runner.o] Error 1
make: *** [get_current_stdlib.o] Error 1
clang: error: unsupported option '-fopenmp'
make: *** [util.o] Error 1
clang: error: unsupported option '-fopenmp'
make: *** [stdlib.o] Error 1
ERROR: compilation failed for package ‘jwutil’
* removing ‘.../revdep/checks.noindex/jwutil/new/jwutil.Rcheck/jwutil’

```
### CRAN

```
* installing *source* package ‘jwutil’ ...
** package ‘jwutil’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c get_current_stdlib.cpp -o get_current_stdlib.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c jwomp.cpp -o jwomp.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c rowsorted.cpp -o rowsorted.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c stdlib.cpp -o stdlib.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c test-jwutil.cpp -o test-jwutil.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c test-runner.cpp -o test-runner.o
clang++ -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I".../revdep/library.noindex/jwutil/Rcpp/include" -I".../revdep/library.noindex/jwutil/testthat/include" -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -I/usr/local/include -I. -fopenmp -fPIC  -Wall -g -O2  -c util.cpp -o util.o
clang: error: unsupported option '-fopenmp'
make: *** [RcppExports.o] Error 1
make: *** Waiting for unfinished jobs....
clang: error: unsupported option '-fopenmp'
clang: error: unsupported option '-fopenmp'
clang: error: unsupported option '-fopenmp'
make: *** [get_current_stdlib.o] Error 1
clang: error: unsupported option '-fopenmp'
make: *** [util.o] Error 1
make: *** [stdlib.o] Error 1
make: *** [rowsorted.o] Error 1
clang: clangerror: : error: unsupported option '-fopenmp'unsupported option '-fopenmp'

make: *** [jwomp.o] Error 1
make: *** [test-runner.o] Error 1
clang: error: unsupported option '-fopenmp'
make: *** [test-jwutil.o] Error 1
ERROR: compilation failed for package ‘jwutil’
* removing ‘.../revdep/checks.noindex/jwutil/old/jwutil.Rcheck/jwutil’

```
