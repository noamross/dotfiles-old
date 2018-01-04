#!/usr/local/bin/Rscript

cran_pkgs <- c(
          'assertr',
          'awspack',
          'beepr',
          'bigmemory',
          'bitops',
          'bookdown',
          'caTools',
          'covr',
          'cowplot',
          'datapasta',
          'devtools',
          'DT',
          'fulltext',
          'ggalt',
          'ggforce',
          'ggiraph',
          'ggraph',
          'ggrepel',
          'ggridges',
          'here',
          'igraph',
          'knitcitations',
          'littler',
          'magick',
          'mclust',
          'microbenchmark',
          'MonetDBLite',
          'officer',
          'pdftools',
          'plotly',
          'printr',
          'rcrossref',
          'rhub',
          'rio',
          'rJava',
          'rmarkdown',
          'rmdshower',
          'robotstxt',
          'roxygen2',
          'rstan',
          'rstanarm',
          'rticles',
          'rvg',
          'sf',
          'shiny',
          'skimr',
          'styler',
          'svglite',
          'testthat',
          'threejs',
          'tidygraph',
          'tidytext',
          'tidyverse',
          'tweenr',
          'usethis',
          'viridis',
          'visdat',
          'xgboost'
)

github_pkgs <- c(
  'dgrtwo/gganimate',
  'ecohealthalliance/eidith',
  'ecohealthalliance/metaflu',
  'jimhester/lookup',
  'noamross/noamtools',
  'ropensci/codemetar',
  'ropensci/tabulizer',
  'rstudio/keras',
  'rstudio/tensorflow',
  'yihui/tinytex'
  )

bioc_pkgs <- c(
  'graph'
)

update.packages(ask=FALSE, checkBuilt = TRUE, type="both")

if ("BiocInstaller" %in% rownames(installed.packages())) {
  BiocInstaller::biocLite()
} else {
  source("https://bioconductor.org/biocLite.R")
  BiocInstaller::biocLite()
}

bioc_to_install <- setdiff(bioc_pkgs, rownames(installed.packages()))

if(length(bioc_to_install)) {
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
  install.packages(cran_to_install, type="both")
  }

if(!file.exists('/usr/local/bin/lr')) {
  file.symlink(from=littler::r(), '/usr/local/bin/lr')
}

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
