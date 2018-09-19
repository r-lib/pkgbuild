dir.exists <- function(x) {
  res <- file.exists(x) & file.info(x)$isdir
  stats::setNames(res, x)
}

pkg_path <- function(path = ".") {
  rprojroot::find_root("DESCRIPTION", path)
}

pkg_name <- function(path = ".") {
  desc::desc_get("Package", pkg_path(path))[[1]]
}

gcc_arch <- function() {
  if (Sys.getenv("R_ARCH") == "/i386") "32" else "64"
}

is_windows <- function() {
  .Platform$OS.type == "windows"
}

is_dir <- function(x) {
  isTRUE(file.info(x)$isdir)
}

# This is tools::makevars_user, provided here for backwards compatibility with older versions of R
makevars_user <- function () {
  m <- character()
  if (.Platform$OS.type == "windows") {
    if (!is.na(f <- Sys.getenv("R_MAKEVARS_USER", NA_character_))) {
      if (file.exists(f))
        m <- f
    }
    else if ((Sys.getenv("R_ARCH") == "/x64") && file.exists(f <- path.expand("~/.R/Makevars.win64")))
      m <- f
    else if (file.exists(f <- path.expand("~/.R/Makevars.win")))
      m <- f
    else if (file.exists(f <- path.expand("~/.R/Makevars")))
      m <- f
  }
  else {
    if (!is.na(f <- Sys.getenv("R_MAKEVARS_USER", NA_character_))) {
      if (file.exists(f))
        m <- f
    }
    else if (file.exists(f <- path.expand(paste0("~/.R/Makevars-",
            Sys.getenv("R_PLATFORM")))))
      m <- f
    else if (file.exists(f <- path.expand("~/.R/Makevars")))
      m <- f
  }
  m
}

last_char <- function(x) {
  l <- nchar(x)
  substr(x, l, l)
}

cat0 <- function(..., sep = "") {
  cat(..., sep = "")
}
