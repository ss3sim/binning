library(devtools)
## Update the development tools, if you haven't recently
update.packages(c('knitr', 'devtools', 'roxygen2'))
## Build the ss3sim developement package
remove.packages("ss3sim")
## install whatever branch we are working on
load_all("../ss3sim")
dev_help
library(r4ss)
change_bin

dir.create("cod-om-test")
files <- list.files("cod-om", full.names=TRUE)
file.copy(files,  "cod-om-test")

## End of session so clean up
unlink("cod-om-test", TRUE)
