#!/usr/local/bin/Rscript

cran_pkgs <- c(
          'assertr',
          'awspack',
          'bayesplot',
          'beepr',
          'bigmemory',
          'bitops',
          'bookdown',
          'caret',
          'caTools',
          'cluster',
          'covr',
          'countrycode',
          'cowplot',
          'datapasta',
          'devtools',
          'deSolve',
          'doMC',
          'doRNG',
          'doSNOW',
          'drat',
          'DT',
          'EML',
          'extrafont',
          'fulltext',
          'foreach',
          'forecast',
          'foreign',
          'ggalt',
          'ggforce',
          'ggiraph',
          'ggraph',
          'ggrepel',
          'ggridges',
          'gmailr',
          'googlesheets',
          'googledrive',
          'haven',
          'here',
          'httr',
          'igraph',
          'janitor',
          'jsonlite',
          'knitcitations',
          'littler',
          'lucr',
          'magick',
          'maptools',
          'mclust',
          'microbenchmark',
          'MonetDBLite',
          'naniar',
          'nloptr',
          'numDeriv',
          'odbc',
          'ompr',
          'officer',
          'pander',
          'pdftools',
          'plotly',
          'pomp',
          'printr',
          'raster',
          'rasterVis',
          'rcrossref',
          'Rcpp',
          'RcppArmadillo',
          'RcppParallel',
          'RcppProgress',
          'rhub',
          'rio',
          'rJava',
          'rmarkdown',
          'rmdshower',
          'RPostgres',
          'robotstxt',
          'rootSolve',
          'roxygen2',
          'RSQLite',
          'rstan',
          'rstanarm',
          'rticles',
          'rvest',
          'rvg',
          'sf',
          'shiny',
          'skimr',
          'snow',
          'styler',
          'svglite',
          'testthat',
          'threejs',
          'tidygraph',
          'tidytext',
          'tidyverse',
          'tweenr',
          'urltools',
          'usethis',
          'viridis',
          'visdat',
          'xaringan',
          'XML',
          'xgboost'
          )

github_pkgs <- c(
  'bergant/airtabler',
#  'clauswilke/colorblindr',
  'dgrtwo/gganimate',
  'ecohealthalliance/eidith',
  'ecohealthalliance/fasterize',
  'ecohealthalliance/metaflu',
  'jimhester/lookup',
  'MangoTheCat/rmdshower',
  'MangoTheCat/goodpractice',
  'noamross/noamtools',
  'r-lib/pkgdown',
  'ropensci/codemetar',
  'ropensci/tabulizer',
  'rstudio/keras',
  'rstudio/tensorflow',
  'yihui/tinytex'
  )

bioc_pkgs <- c(
  'graph'
)

#r_forge_pkgs <- c(
#  'colorspace'
#)

update.packages(ask=FALSE, checkBuilt = TRUE, type="both")

if ("BiocInstaller" %in% rownames(installed.packages())) {
  BiocInstaller::biocLite()
} else {
  source("https://bioconductor.org/biocLite.R")
  BiocInstaller::biocLite()
}

bioc_to_install <- setdiff(bioc_pkgs, rownames(installed.packages()))

if(length(bioc_to_install)) {
  cat("Installing from BioConductor:", bioc_to_install, "\n")
  biocLite(bioc_to_install)
}

cran_to_install <- sort(setdiff(
                unique(unlist(
                  c(cran_pkgs,
                    tools::package_dependencies(cran_pkgs, recursive=TRUE,
                      which= c("Depends", "Imports", "LinkingTo")),
                    tools::package_dependencies(cran_pkgs, recursive=FALSE,
                                                which= c("Depends", "Imports", "LinkingTo", "Suggests", "Enhances"))
                     ))),
                rownames(installed.packages())))

if(length(cran_to_install)) {
  cat("Installing from CRAN:", cran_to_install, "\n")
  install.packages(cran_to_install, type="both")
  }

file.remove('/usr/local/bin/lr')
file.symlink(from=littler::r(), '/usr/local/bin/lr')

devtools::install_github(github_pkgs,
                         build_vignettes = TRUE,
                         keep_source = TRUE,
                         dependencies = c("Depends", "Imports", "LinkingTo", "Suggests"))

try(tinytex::install_tinytex())

if (!dir.exists("~/.Rcache")) {
  dir.create("~/.Rcache")
}

if(!keras::is_keras_available()) {
  keras::install_keras()
}
