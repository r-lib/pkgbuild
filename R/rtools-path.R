scan_path_for_rtools <- function(debug = FALSE,
                                 gcc49 = using_gcc49(),
                                 arch = gcc_arch()) {
  if (debug) cat("Scanning path...\n")

  # First look for ls and gcc
  ls_path <- Sys.which("ls")
  if (ls_path == "") return(NULL)
  if (debug) cat("ls :", ls_path, "\n")

  # We have a candidate installPath
  install_path <- dirname(dirname(ls_path))

  if (gcc49) {
    find_gcc49 <- function(path) {
      if (!file.exists(path)) {
        path <- paste0(path, ".exe")
      }
      file_info <- file.info(path)

      # file_info$exe should be win32 or win64 respectively
      if (!file.exists(path) || file_info$exe != paste0("win", arch)) {
        return(character(1))
      }
      path
    }

    # First check if gcc set by BINPREF/CC is valid and use that is so
    cc_path <- callr::rcmd_safe("config", "CC", show = debug)$stdout

    # remove '-m64' from tail if it exists
    cc_path <- sub("[[:space:]]+-m[[:digit:]]+$", "", cc_path)

    gcc_path <- find_gcc49(cc_path)
    if (nzchar(gcc_path)) {
      return(rtools(install_path, NULL, valid_binpref = TRUE))
    }

    # if not check default location Rtools/mingw_{32,64}/bin/gcc.exe
    gcc_path <- find_gcc49(file.path(install_path, paste0("mingw_", arch), "bin", "gcc.exe"))
    if (!nzchar(gcc_path)) {
      return(NULL)
    }
  } else {
    gcc_path <- Sys.which("gcc")
    if (gcc_path == "") return(NULL)
  }
  if (debug) cat("gcc:", gcc_path, "\n")

  install_path2 <- dirname(dirname(dirname(gcc_path)))

  # If both install_paths are not equal
  if (tolower(install_path2) != tolower(install_path)) return(NULL)

  version <- installed_version(install_path, debug = debug)
  if (debug) cat("Version:", version, "\n")

  rtools(install_path, version)
}
