# Need to check for existence so load_all doesn't override known rtools location
if (!exists("cache")) {
  cache <- new.env(parent = emptyenv())
}

cache_get <- function(name) {
  get(name, envir = cache)
}

cache_exists <- function(name) {
  exists(name, envir = cache)
}

cache_set <- function(name, value) {
  assign(name, value, envir = cache)
}

cache_remote <- function(name) {
  rm(list = name, envir = cache)
}
