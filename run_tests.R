library(devtools)
## Update the development tools, if you haven't recently
update.packages(c('knitr', 'devtools', 'roxygen2'))
## Build the ss3sim developement package
remove.packages("ss3sim")
## install whatever branch we are working on
load_all("F:/ss3sim")
dev_help
library(r4ss)

## to run the base model
setwd("F:/binning")
dir.create("cod-om-test")
files <- list.files("cod-om", full.names=TRUE)
file.copy(files,  "cod-om-test")
## to run the "change_bin" function
dir.create("cod-om-test-new")
files <- list.files("cod-om", full.names=TRUE)
file.copy(files,  "cod-om-test-new")
setwd("F:/binning/cod-om-test-new")
change_bin(file_in="codOM.dat", file_out="codOM.new.dat", bin_vector = c(20, 26, 29, 32, 35, 38, 41, 44, 47, 50, 53, 56, 59, 62, 65, 68, 71, 74, 77, 80, 83, 86, 89, 92, 95, 98, 101, 104, 107, 110, 113, 116, 119, 122, 125, 128, 131, 134, 137, 140, 143, 146, 149, 152), type="length", write_file = TRUE)

## End of session so clean up
unlink("cod-om-test", TRUE)

## to check whether the new function works or not

bin_or <- c(0.00260219, 0.0341899, 0.279936, 0.929283, 1.20611, 0.653391, 0.520717, 1.42683, 3.00334, 4.18986, 4.12005, 3.25679, 2.71086, 2.85671, 3.25729, 3.45327, 3.38539, 3.24925, 3.1975, 3.22675, 3.26419, 3.2722, 3.2615, 3.25157, 3.24677, 3.24085, 3.22745, 3.20273, 3.16287, 3.10237, 3.01459, 2.89321, 2.73361, 2.53419, 2.29732, 2.02987, 1.74285, 1.45006, 1.16618, 0.9046, 0.675517, 0.484856, 0.334057, 0.220715, 0.325783)
bin_new <- c(0.0357928, 0.279938, 0.929293, 1.20612, 0.653397, 0.520722, 1.42684, 3.00337, 4.1899, 4.12009, 3.25683, 2.71089, 2.85673, 3.25732, 3.4533, 3.38542, 3.24928, 3.19754, 3.22678, 3.26422, 3.27223, 3.26153, 3.2516, 3.2468, 3.24088, 3.22748, 3.20276, 3.1629, 3.1024, 3.01462, 2.89323, 2.73364, 2.53421, 2.29734, 2.02989, 1.74287, 1.45007, 1.1662, 0.904609, 0.675524, 0.484861, 0.334061, 0.220717, 0.325786)

plot(1:length(bin_new), bin_or[-1], type="p")
points(1:length(bin_new), bin_new, col="red")
