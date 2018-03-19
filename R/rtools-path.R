scan_path_for_rtools <- function(debug = FALSE) {
  if (debug)
    cat("Scanning path...\n")

  # Next looks for ls and gcc on path
  ls_path <- Sys.which("ls")
  if (ls_path == "")
    return(NULL)
  if (debug)
    cat("ls:", ls_path, "\n")

  # We have a candidate install_path
  install_path <- dirname(dirname(ls_path))

  gcc_path <- Sys.which("gcc")
  if (debug)
    cat("gcc_path:", gcc_path, "\n")

  if (gcc_path != "") {
    # Check both candidate install paths are same
    install_path2 <- dirname(dirname(dirname(gcc_path)))
    if (tolower(install_path2) != tolower(install_path))
      return(NULL)
  } else {
    # Maybe isn't on path, but is in default location
    gcc_default <- find_arch_exe(
      file.path(install_path, paste0("mingw_", gcc_arch()), "bin", "gcc.exe"),
      debug = debug
    )
    if (gcc_default == "") {
      return(NULL)
    }
  }

  version <- installed_version(install_path, debug = debug)
  if (debug)
    cat("Version:", version, "\n")

  rtools(install_path, version)
}

find_arch_exe <- function(path, debug = FALSE) {
  # First try adding .exe
  if (!file.exists(path)) {
    path <- paste0(path, ".exe")
  }

  if (!file.exists(path)) {
    if (debug)
      cat("'", path, "' does not exist\n", sep = "")
    return("")
  }

  # Then check architecture matches
  file_info <- file.info(path)
  if (file_info$exe != paste0("win", gcc_arch())) {
    if (debug)
      cat("  Architecture doesn't match\n")
    return("")
  }

  path
}
