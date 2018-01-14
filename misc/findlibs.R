library(tidyverse)
library(stringi)

#  Run this system command to generate libs.txt with library call from all
#  stuff under home directory
system('ag -G "\\.(R|Rmd)$" --nofilename "library\\(" ~/ > "misc/libs.txt"')


libtxt <- read_lines("misc/libs.txt")

libtxt <- libtxt[libtxt != ""]

libs <- stri_extract_first_regex(libtxt,
                               "(?<=library\\(\\\"?)\\w+")

libsdist <- data_frame(package=libs) %>%
  count(package) %>%
  arrange(desc(n))

View(libsdist)

