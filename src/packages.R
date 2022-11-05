# Install dependencies ----------------------------------------------------

if(!require("pacman", quietly = TRUE)) install.packages("pacman")
pacman::p_load(
  "magrittr",
  "xml2",
  "rvest",
  "plumber",
  "logger",
  "purrr",
  "tidyr",
  "glue",
  "here",
  "RSelenium"
  )
