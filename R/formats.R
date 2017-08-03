#' Convert to a poster with fexdashboard layout.
#'
#' @description
#' A flexdashboard poster is an R Markdown document using a flexdashboard
#' layout to arrange text, figures, tables and other content into a typical
#' grid format as used for conference posters.
#'
#' @details
#'
#' Compared to \code{flexdashboard::flex_dashboard}, it:
#'
#' \itemize{
#'   \item uses level 2 headings as dashboard rows by default, because posters are
#'   usually divided vertically in horizontal sections (e.g. title, body, figures),
#'   each of which can contain a different number of columns (i.e. level three headings)
#'   \item prints data frames using \code{\link{knitr::kable}} to show nice simple
#'   tables when there is data frame output from the code chunks
#'   \item produces larger figures
#'   \item never creates mobile rendering of the R graphics
#'   \item never uses retina figures
#'  }
#'
#' @inheritParams flexdashboard::flex_dashboard
#' @param ... Additional arguments passed to \code{\link{html_document}}
#' @param readme Use this vignette as the package README.md file (i.e. render
#'   it as README.md to the package root). Note that if there are image files
#'   within your vignette you should be sure to add README_files to .Rbuildignore
#' @return R Markdown output format to pass to \code{\link{render}}
#' @export
flex_dashboard_poster <- function(
  fig_width = 6, fig_height = 6, fig_mobile = FALSE, dev = 'png',
  self_contained = TRUE, orientation = "rows", df_print = "kable",
  css = NULL, keep_md = FALSE, theme = "default", highlight = "default",
  md_extensions = NULL,
  ...
) {

  # Set knit chunk defaults
  knitr_options <- rmarkdown::knitr_options_html(
    fig_width = fig_width,
    fig_height = fig_height, fig_retina = NULL, keep_md = FALSE,
    dev = dev
  )
  knitr_options$opts_chunk$echo = FALSE
  knitr_options$opts_chunk$warning = FALSE
  knitr_options$opts_chunk$message = FALSE
  knitr_options$opts_chunk$comment = NA

  rmarkdown::output_format(
    knitr = NULL,
    pandoc = NULL,
    df_print = df_print,
    base_format = flexdashboard::flex_dashboard(
      fig_width = fig_width, fig_height = fig_height, fig_mobile, dev = dev,
      css = css, theme = theme,
      self_contained = self_contained,
      orientation = orientation,
      highlight = highlight,
      ...
    )
  )
}
