## Update the development tools, if you haven't recently
update.packages(c('knitr', 'devtools', 'roxygen2'))
## Build the ss3sim developement package
remove.packages("ss3sim")
devtools::install_github(repo="ss3sim", usernamer="ss3sim", ref="feature/change_bins")
library(ss3sim)
library(r4ss)

dir.create("cod-om-test")
files <- list.files("cod-om", full.names=TRUE)
file.copy(files,  "cod-om-test")

## End of session so clean up
unlink("cod-om-test", TRUE)
