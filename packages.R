# Install dependencies ----------------------------------------------------

if(!require("pacman", quietly = TRUE)) install.packages("pacman")
pacman::p_load(
    "magrittr",
    "plumber",
    "logger",
    "purrr"
  )
