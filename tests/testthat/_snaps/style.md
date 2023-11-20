# style

    Code
      cat(style(ok = "OK", "\n", note = "NOTE", "\n", warn = "WARN", "\n", err = "ERROR",
        "\n", pale = "Not important", "\n", timing = "[1m]", "\n"))
    Output
      [32mOK[39m
      [38;5;214mNOTE[39m
      [1m[38;5;214mWARN[39m[22m
      [31mERROR[39m
      [38;5;247mNot important[39m
      [36m[1m][39m

