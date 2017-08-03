# postr

R Markdown template for conference posters using flexdashboard layouts.


## Dependencies

This poster template depends on the following R packages

- rmarkdown [@rmarkdown]
- flexdashboard [@flexdashboard]
- webshot [@webshot]


## Preparing a new poster

In order to use this poster template, you need to:

1. Install the [`odeleongt/postr`](https://github.com/odeleongt/postr) package
  from github
  `devtools::install_github("odeleongt/postr")`
1. Install the PhantomJS library  
  `webshot::install_phantomjs()`
1. Create a new R Markdown document in Rstudio based on the poster template,
  or run 
    rmarkdown::draft("my_poster.Rmd", template = "poster", package = "postr")
1. Run `postr::render()`
