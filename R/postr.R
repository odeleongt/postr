#' postr: Prepare reproducible posters using R Markdown
#'
#' Provides templates and helper functions to prepare R Markdown based
#' conference posters and produce output both in html for hosting and png for
#' printing. Relies on the flexdashboard package to easily define poster layout.
"_PACKAGE"

## quiets concerns of undefined global variables R CMD check
if(getRversion() >= "2.15.1") utils::globalVariables(
  c(
    "original_input", "output_dir", "output_file"
  )
)
