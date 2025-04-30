# find_package_root errors

    Code
      find_package_root("file1130e91427d3")
    Condition
      Error in `find_package_root()`:
      ! Path does not exist: file1130e91427d3

---

    Code
      find_package_root("/")
    Condition
      Error in `find_package_root()`:
      ! Could not find R package in `/` or its parent directories.

