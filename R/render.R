#' Render a poster into a printable image
#'
#' @description
#' `render()` will generate an image with enough resolution to print a poster
#' with standard ISO 216 A1 dimensions.
#'
#' @note
#' Currently the dimensions and other parameters can be changed manually,
#' but a mechanism to select different dimension templates with appropriate
#' resolution and zoom for common paper sizes will be implemented.
#'
#' Documents with dimensions in the ISO A series can be scaled to other sizes
#' in the series, with corresponding decrease in resolution when upscaling or
#' increase in resolution when downscaling.
#'
#' @param input Input file (an html generated with \code{\link{flex_dashboard_poster}}).
#' @param output_file Output file. Defaults to the same name that the input file,
#'   but uses the png extension.
#' @param width Width, in pixels, for the viewport
#'   (see \code{\link[webshot]{webshot}}). This will impact the size of elements
#'   relative to the page.
#' @param aspect_ratio Aspect ratio between the height and the width of the
#'   viewport. The poster orientation will depend on this ratio; if it is
#'   > 1 the orientation is portrait (height > width), and if it is < 1 the
#'   orientation is landscape (width > height)
#' @param height Calculated using as \code{width * aspect_ratio}, rounded down.
#' @param poster_width Intended physical width of the printed poster, in mm.
#'   Defaults to the width of an A1 sheet with portrait orientation.
#'   This will not impact the size of the elements to the page, but the
#'   number of pixels covered per element.
#' @param dpi Intended print resolution, in dpi. Used to calculate the zoom
#'   factor necessary to produce enough pixels for a \code{poster_width} print
#'   with the intended resolution.
#' @param delay Time in seconds for phantomJS to wait while the page loads
#'   before taking the snapshot.
#' @param ... Ignored
#' @return Silently returns the path of the rendered image.
#' @export
#' @examples
#' \dontrun{
#' # generate a simple poster from the provided template
#' rmarkdown::draft("my_poster.Rmd", template = "poster", package = "postr")
#' # render the html output
#' rmarkdown::render(input = "my_poster/my_poster.Rmd")
#' # render the png poster
#' postr::render_poster_image("my_poster/my_poster.html")
#' }
render_poster_image <- function(
  input,
  output_file = paste0(tools::file_path_sans_ext(input), '.png'),
  width = 1200,
  aspect_ratio = sqrt(2),
  height = floor(width * aspect_ratio),
  poster_width = 594,
  dpi = 300,
  delay = 1
){
  # Render poster
  webshot::webshot(
    url = input,
    file = output_file,
    vwidth = width,
    vheight = height,
    delay = delay,                           # Wait to allow all element to load
    zoom = poster_width / (width / (dpi / 25.4)) # Adjust pixel density
  )
  return(invisible(output_file))
}


# End of script
