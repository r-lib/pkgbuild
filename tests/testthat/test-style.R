test_that("style", {
  withr::local_options(cli.num_colors = 256)
  expect_snapshot(
    cat(style(
      ok = "OK",
      "\n",
      note = "NOTE",
      "\n",
      warn = "WARN",
      "\n",
      err = "ERROR",
      "\n",
      pale = "Not important",
      "\n",
      timing = "[1m]",
      "\n"
    ))
  )
})
