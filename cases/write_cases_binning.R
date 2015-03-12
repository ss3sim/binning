
### ------------------------------------------------------------
## Binning files for cod (species specific)
## I is for "internal" which uses the change_bin function. The base case
## for I is to do no binning internally, so set these data bins to be 1cm
## since binning is done afterward (externally)
data0 <- c('age_bins; NULL', 'len_bins; seq(20, 160, by=1)',
           'pop_binwidth; 1', 'pop_minimum_size; 8',
           'pop_maximum_size; 202', 'lcomp_constant; 1e-10',
           'tail_compression; -1')
writeLines(data0, con=paste0(case_folder,"/", "data0-cod.txt"))

#### For cases with tail compression 
tc.seq <- c(0.01, seq(0.05, .25, len=5))
tc.n <- length(tc.seq)
for(i in 1:tc.n){
    tc <- tc.seq[i]
	x <- c('age_bins; NULL', 'len_bins; seq(20, 160, by=1)',
           'pop_binwidth; 1', 'pop_minimum_size; 8',
           'pop_maximum_size; 202', 'lcomp_constant; 1e-10',
           paste0("tail_compression; ", tc))
    writeLines(x, con=paste0(case_folder, "/data1",i, "-cod.txt"))
}

#### For cases with robustification constant
rb.seq <- c(1e-5,1e-4,1e-3,1e-2,1e-1)
rb.n <-length(rb.seq)
for(i in 1:rb.n){
    rb <- rb.seq[i]
	x <- c('age_bins; NULL', 'len_bins; seq(20, 160, by=1)',
           'pop_binwidth; 1', 'pop_minimum_size; 8',
           'pop_maximum_size; 202', paste0("lcomp_constant; ", rb), 
           'tail_compression; -1')
    writeLines(x, con=paste0(case_folder, "/data2",i, "-cod.txt"))
}


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

### Function to write binning casefiles - external method
## BX where X is the bin width, and then B1X for the one with matching pop bin widths
## binwidth: must be integer
## lbmin: lowest bin, must be integer
## lbmax: highest bin, must be integer
## matchpop: match data bins to population bins, default set to TRUE, 1cm if FALSE
## pmin: pop minimum size
## pmax: pop maximum size
write_bincase <- function(species, binwidth, lbmin, lbmax, matchpop=FALSE,
                            pmin, pmax){

  pbins <- ifelse(matchpop, binwidth, 1)
  write <- c('lbin_method;2', paste0('pop_binwidth;', pbins),
    paste0('pop_minimum_size;', pmin), paste0('pop_maximum_size;', pmax), 
    paste0('bin_vector;seq(', lbmin, ",", lbmax, ",by=", binwidth, ")"))
  if(nchar(binwidth)==1 & matchpop==TRUE) binwidth <- paste0("0", binwidth)
  if(matchpop==FALSE) name <- paste0("em_binning", binwidth)
  if(matchpop==TRUE) name <- paste0("em_binning1", binwidth)
  writeLines(write, con=paste0(case_folder, "/", name, "-", species, ".txt"))

}

write_bincase(species="cod", binwidth=2, lbmin=20, lbmax=160,
                matchpop=FALSE, pmin=8, pmax=202)


## External binning cases. For this the change_data function shouldn't be
## called at all, and instead the generated data should be in 1cm bins
## using data0. em_binning0 is to ignore it and leave unchanged for use in internal cases.
em_binning0 <- c('lbin_method;2', 'pop_binwidth;1', 'pop_minimum_size;8',
                 'pop_maximum_size;202', 'bin_vector;seq(20,160,by=1)')
writeLines(em_binning0, con=paste0(case_folder,"/","em_binning0-cod.txt"))
em_binning1 <- c('lbin_method;2', 'pop_binwidth;1', 'pop_minimum_size;8',
                 'pop_maximum_size;202', 'bin_vector;seq(20,160,by=2)')
writeLines(em_binning1, con=paste0(case_folder,"/","em_binning1-cod.txt"))
em_binning2 <- c('lbin_method;2', 'pop_binwidth;1', 'pop_minimum_size;8',
                 'pop_maximum_size;202', 'bin_vector;seq(20,160,by=4)')
writeLines(em_binning2, con=paste0(case_folder,"/","em_binning2-cod.txt"))
em_binning3 <- c('lbin_method;2', 'pop_binwidth;1', 'pop_minimum_size;8',
                 'pop_maximum_size;202', 'bin_vector;seq(20,160,by=13)')
writeLines(em_binning3, con=paste0(case_folder,"/","em_binning3-cod.txt"))

em_binning11 <- c('lbin_method;2', 'pop_binwidth;2', 'pop_minimum_size;8',
                 'pop_maximum_size;202', 'bin_vector;seq(20,160,by=2)')
writeLines(em_binning11, con=paste0(case_folder,"/","em_binning11-cod.txt"))
em_binning12 <- c('lbin_method;2', 'pop_binwidth;4', 'pop_minimum_size;8',
                 'pop_maximum_size;202', 'bin_vector;seq(20,160,by=4)')
writeLines(em_binning12, con=paste0(case_folder,"/","em_binning12-cod.txt"))
em_binning13 <- c('lbin_method;2', 'pop_binwidth;13', 'pop_minimum_size;7',
                 'pop_maximum_size;202', 'bin_vector;seq(20,160,by=13)')
writeLines(em_binning13, con=paste0(case_folder,"/","em_binning13-cod.txt"))



## End of binning files
### ------------------------------------------------------------
