#' Convert to a poster with flexdashboard layout.
#'
#' @description
#' A flexdashboard poster is an R Markdown document using a flexdashboard
#' layout to arrange text, figures, tables and other content into a typical
#' grid format as used for conference posters.
#' The print version will be rendered when knitting if the format option
#' \code{render_print} is set to \code{TRUE} in the YAML header or the function
#' call; currently this requires that the root dir be set to the default or a
#' path relative to the Rmd document location, otherwise it will result in an
#' error.
#'
#' @details
#'
#' Compared to \code{flexdashboard::flex_dashboard}, it:
#'
#' \itemize{
#'   \item uses level 2 headings as dashboard rows by default, because posters are
#'   usually divided vertically in horizontal sections (e.g. title, body, figures),
#'   each of which can contain a different number of columns (i.e. level three headings)
#'   \item prints data frames using \code{\link[knitr]{kable}} to show nice simple
#'   tables when there is data frame output from the code chunks
#'   \item produces larger figures
#'   \item never creates mobile rendering of the R graphics
#'   \item never uses retina figures
#'  }
#'
#' @param render_print Whether to render the print version (defaults to FALSE).
#' @inheritParams flexdashboard::flex_dashboard
#' @param ... Additional arguments passed to \code{\link[flexdashboard]{flex_dashboard}}
#' @inheritParams rmarkdown::output_format
#' @return R Markdown output format to pass to \code{\link{render}}
#' @export
flex_dashboard_poster <- function(
  fig_width = 6, fig_height = 6, fig_mobile = FALSE, dev = 'png',
  self_contained = TRUE, orientation = "rows", df_print = "kable",
  css = NULL, keep_md = FALSE, theme = "default", highlight = "default",
  md_extensions = NULL, render_print = FALSE,
  ...
) {
  # Render the print version using the default locations when exiting rmarkdown::render
  if(render_print){
    on_exit <- function(){
      print_render <- function(){
        input_poster <- paste(
          output_file, sep = "/"
        )
        postr::render(input = input_poster)
      }
      environment(print_render) <- parent.frame(n = 2)
      print_render()
    }
  } else {
    exit_actions <- list()
    on_exit <- function() {
      for (action in exit_actions) try(action())
    }
  }

  # Define output format
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
    ),
    on_exit = on_exit
  )
}
