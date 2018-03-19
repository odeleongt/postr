context("Render poster")

test_that("Create html and png files", {

  skip_on_cran()

  poster_html <- tempfile(fileext = ".html")
  rmarkdown::render("test-poster.Rmd", output_file = poster_html)
  expect_true(file.exists(poster_html))

  poster_png <- tempfile(fileext = ".png")
  postr::render_poster_image(poster_html, output_file = poster_png)
  expect_true(file.exists(poster_png))
})
