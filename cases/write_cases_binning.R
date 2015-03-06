
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
data1 <- c('age_bins; NULL', 'len_bins; seq(20, 160, by=2)',
           'pop_binwidth; 1', 'pop_minimum_size; 8',
           'pop_maximum_size; 202', 'lcomp_constant; 1e-10',
           'tail_compression; -1')
writeLines(data1, con=paste0(case_folder,"/", "data1-cod.txt"))
data2 <- c('age_bins; NULL', 'len_bins; seq(20, 160, by=4)',
           'pop_binwidth; 1', 'pop_minimum_size; 8',
           'pop_maximum_size; 202', 'lcomp_constant; 1e-10',
           'tail_compression; -1')
writeLines(data2, con=paste0(case_folder,"/", "data2-cod.txt"))
data3 <- c('age_bins; NULL', 'len_bins; seq(20, 160, by=13)',
           'pop_binwidth; 1', 'pop_minimum_size; 8',
           'pop_maximum_size; 202', 'lcomp_constant; 1e-10',
           'tail_compression; -1')
writeLines(data3, con=paste0(case_folder,"/", "data3-cod.txt"))
## External binning cases. For this the change_data function shouldn't be
## called at all, and instead the generated data should be in 1cm bins
## using data0. em_binning0 is to ignore it and leave unchanged for use in internal cases.
em_binning0 <- c('lbin_method;NULL', 'bin_vector;seq(20,160, by=2)')
writeLines(em_binning0, con=paste0(case_folder,"/", "em_binning0-cod.txt"))
em_binning1 <- c('lbin_method;1', 'bin_vector;seq(20,160,by=2)')
writeLines(em_binning1, con=paste0(case_folder,"/","em_binning1-cod.txt"))
em_binning2 <- c('lbin_method;1', 'bin_vector;seq(20,160,by=4)')
writeLines(em_binning2, con=paste0(case_folder,"/","em_binning2-cod.txt"))
em_binning3 <- c('lbin_method;1', 'bin_vector;seq(20,160,by=13)')
writeLines(em_binning3, con=paste0(case_folder,"/","em_binning3-cod.txt"))
## End of binning files
### ------------------------------------------------------------
