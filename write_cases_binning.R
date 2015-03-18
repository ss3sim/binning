### ------------------------------------------------------------
## This file creates the binning cases for each species. They differ b/c
## their Linf is different.

### Function to write binning casefiles - external method
## BX where X is the bin width, and then B1X for the one with matching pop bin widths
## binwidth: must be integer
## lbmin: lowest bin, must be integer
## lbmax: highest bin, must be integer
## matchpop: match data bins to population bins, default set to TRUE, 1cm if FALSE
## pmin: pop minimum size
## pmax: pop maximum size
## Binning case ID number so that we can 0 is the 1cm binning, 1 is the small bin case, etc... See case list
write_bincase <- function(species, binwidth, lbmin, lbmax, matchpop=FALSE,
                          pmin, pmax, ID){
    pbins <- ifelse(matchpop, binwidth, 1)
    pseq <- seq(pmin, pmax, by=pbins)
    write <- c('lbin_method;2', paste0('pop_binwidth;', pbins),
               paste0('pop_minimum_size;', pmin), paste0('pop_maximum_size;', pmax),
               paste0('bin_vector;seq(', lbmin, ",", lbmax, ",by=", binwidth, ")"))
    if(nchar(binwidth)==1 & matchpop==TRUE) binwidth <- paste0("0", binwidth)
    if(matchpop==FALSE) name <- paste0("em_binning", ID)
    if(matchpop==TRUE) name <- paste0("em_binning1", ID)
    writeLines(write, con=paste0(case_folder, "/", name, "-", species, ".txt"))
}

if (spp == 'cod') {
    pmin <- 8; pmax <- 200
    dmin <- pmin; dmax <- pmax
    len_bins = "seq(8, 200, by=1)"
    write_bincase(species=spp, binwidth=1, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=0)
    write_bincase(species=spp, binwidth=2, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=1)
    write_bincase(species=spp, binwidth=2, lbmin=dmin, lbmax=dmax, matchpop=TRUE, pmin=pmin, pmax=pmax, ID=1)
    write_bincase(species=spp, binwidth=4, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=2)
    write_bincase(species=spp, binwidth=4, lbmin=dmin, lbmax=dmax, matchpop=TRUE, pmin=pmin, pmax=pmax, ID=2)
    write_bincase(species=spp, binwidth=12, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=3)
    write_bincase(species=spp, binwidth=12, lbmin=dmin, lbmax=dmax, matchpop=TRUE, pmin=pmin, pmax=pmax, ID=3)
    write_bincase(species=spp, binwidth=24, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=4)
    write_bincase(species=spp, binwidth=24, lbmin=dmin, lbmax=dmax, matchpop=TRUE, pmin=pmin, pmax=pmax, ID=4)
} else if (spp == 'flatfish') {
    pmin <- 2; pmax <- 102
    dmin <- pmin; dmax <- pmax
    len_bins = "seq(2, 102, by=1)"
    write_bincase(species=spp, binwidth=1, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=0)
    write_bincase(species=spp, binwidth=2, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=1)
    write_bincase(species=spp, binwidth=2, lbmin=dmin, lbmax=dmax, matchpop=TRUE, pmin=pmin, pmax=pmax, ID=1)
    write_bincase(species=spp, binwidth=5, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=2)
    write_bincase(species=spp, binwidth=5, lbmin=dmin, lbmax=dmax, matchpop=TRUE, pmin=pmin, pmax=pmax, ID=2)
    write_bincase(species=spp, binwidth=10, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=3)
    write_bincase(species=spp, binwidth=10, lbmin=dmin, lbmax=dmax, matchpop=TRUE, pmin=pmin, pmax=pmax, ID=3)
    write_bincase(species=spp, binwidth=20, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=4)
    write_bincase(species=spp, binwidth=20, lbmin=dmin, lbmax=dmax, matchpop=TRUE, pmin=pmin, pmax=pmax, ID=4)
} else if (spp == 'yellow') {
    pmin <- 10; pmax <- 106
    dmin <- pmin; dmax <- pmax
    len_bins = "seq(10, 106, by=1)"
    write_bincase(species=spp, binwidth=1, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=0)
    write_bincase(species=spp, binwidth=2, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=1)
    write_bincase(species=spp, binwidth=2, lbmin=dmin, lbmax=dmax, matchpop=TRUE, pmin=pmin, pmax=pmax, ID=1)
    write_bincase(species=spp, binwidth=4, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=2)
    write_bincase(species=spp, binwidth=4, lbmin=dmin, lbmax=dmax, matchpop=TRUE, pmin=pmin, pmax=pmax, ID=2)
    write_bincase(species=spp, binwidth=12, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=3)
    write_bincase(species=spp, binwidth=12, lbmin=dmin, lbmax=dmax, matchpop=TRUE, pmin=pmin, pmax=pmax, ID=3)
    write_bincase(species=spp, binwidth=24, lbmin=dmin, lbmax=dmax, matchpop=FALSE, pmin=pmin, pmax=pmax, ID=4)
    write_bincase(species=spp, binwidth=24, lbmin=dmin, lbmax=dmax, matchpop=TRUE, pmin=pmin, pmax=pmax, ID=4)
} else {
    warning(paste("no binning cases setup for species", spp))
}

## I is for "internal" which uses the change_bin function. The base case
## for I is to do no binning internally, so set these data bins to be 1cm
## since binning is done afterward (externally)
data0 <- c('age_bins; NULL', paste0('len_bins; ', len_bins),
           'pop_binwidth; 1', paste0('pop_minimum_size; ', pmin),
           paste0('pop_maximum_size; ', pmax), 'lcomp_constant; 1e-10',
           'tail_compression; -1')
writeLines(data0, con=paste0(case_folder,"/", "data0-", spp, ".txt"))

## For cases with tail compression
tc.seq <- c(-1, 0.01, 0.1, 0.25, 0.5)
tc.n <- length(tc.seq)
for(i in 1:tc.n){
    tc <- tc.seq[i]
    x <- c('age_bins; NULL', paste0('len_bins; ', len_bins),
           'pop_binwidth; 1', paste0('pop_minimum_size; ', pmin),
           paste0('pop_maximum_size; ', pmax), 'lcomp_constant; 1e-10',
           paste0("tail_compression; ", tc))
    writeLines(x, con=paste0(case_folder, "/data1",i, "-", spp, ".txt"))
}
## For cases with robustification constant
rb.seq <- c(1e-10,1e-5,1e-3,0.1,0.5)
rb.n <-length(rb.seq)
for(i in 1:rb.n){
    rb <- rb.seq[i]
    x <- c('age_bins; NULL', paste0('len_bins; ', len_bins),
           'pop_binwidth; 1', paste0('pop_minimum_size; ', pmin),
           paste0('pop_maximum_size; ', pmax), paste0("lcomp_constant; ", rb),
           'tail_compression; -1')
    writeLines(x, con=paste0(case_folder, "/data2",i, "-", spp, ".txt"))
}



## OLD case files
## External binning cases. For this the change_data function shouldn't be
## called at all, and instead the generated data should be in 1cm bins
## using data0. em_binning0 is to ignore it and leave unchanged for use in internal cases.
## em_binning0 <- c('lbin_method;2', 'pop_binwidth;1', 'pop_minimum_size;8',
##                  'pop_maximum_size;202', 'bin_vector;seq(20,160,by=1)')
## writeLines(em_binning0, con=paste0(case_folder,"/","em_binning0-cod.txt"))
## em_binning1 <- c('lbin_method;2', 'pop_binwidth;1', 'pop_minimum_size;8',
##                  'pop_maximum_size;202', 'bin_vector;seq(20,160,by=2)')
## writeLines(em_binning1, con=paste0(case_folder,"/","em_binning1-cod.txt"))
## em_binning2 <- c('lbin_method;2', 'pop_binwidth;1', 'pop_minimum_size;8',
##                  'pop_maximum_size;202', 'bin_vector;seq(20,160,by=4)')
## writeLines(em_binning2, con=paste0(case_folder,"/","em_binning2-cod.txt"))
## em_binning3 <- c('lbin_method;2', 'pop_binwidth;1', 'pop_minimum_size;8',
##                  'pop_maximum_size;202', 'bin_vector;seq(20,160,by=13)')
## writeLines(em_binning3, con=paste0(case_folder,"/","em_binning3-cod.txt"))

## em_binning11 <- c('lbin_method;2', 'pop_binwidth;2', 'pop_minimum_size;8',
##                  'pop_maximum_size;202', 'bin_vector;seq(20,160,by=2)')
## writeLines(em_binning11, con=paste0(case_folder,"/","em_binning11-cod.txt"))
## em_binning12 <- c('lbin_method;2', 'pop_binwidth;4', 'pop_minimum_size;8',
##                  'pop_maximum_size;202', 'bin_vector;seq(20,160,by=4)')
## writeLines(em_binning12, con=paste0(case_folder,"/","em_binning12-cod.txt"))
## em_binning13 <- c('lbin_method;2', 'pop_binwidth;13', 'pop_minimum_size;7',
##                  'pop_maximum_size;202', 'bin_vector;seq(20,160,by=13)')
## writeLines(em_binning13, con=paste0(case_folder,"/","em_binning13-cod.txt"))

## data2 <- c('age_bins; NULL', 'len_bins; seq(20, 160, by=1)',
##            'pop_binwidth; 4', 'pop_minimum_size; 8',
##            'pop_maximum_size; 202', 'lcomp_constant; 1e-10',
##            'tail_compression; -1')
## writeLines(data2, con=paste0(case_folder,"/", "data2-cod.txt"))
## data3 <- c('age_bins; NULL', 'len_bins; seq(20, 160, by=1)',
##            'pop_binwidth; 13', 'pop_minimum_size; 8',
##            'pop_maximum_size; 203', 'lcomp_constant; 1e-10',
##            'tail_compression; -1')
## writeLines(data3, con=paste0(case_folder,"/", "data3-cod.txt"))


## End of binning files
### ------------------------------------------------------------
