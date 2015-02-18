## Source this file to recreate case files used in the analysis
### ------------------------------------------------------------
## The deterministic cases (not species specific)
index100 <- c('fleets;2', 'years;list(seq(50,100, by=2))', 'sds_obs;list(.01)')
lcomp100 <- c('fleets;c(1,2)', 'years;list(seq(50,100, by=2), seq(50,100, by=2))',
              'Nsamp;list(500, 500)', 'cpar;NA')
agecomp100 <- c('fleets;c(1,2)', 'years;list(seq(50,100, by=2),seq(50,100, by=2))',
              'Nsamp;list(500, 500)', 'cpar;NA')
calcomp100 <- c('fleets;NULL', 'years;list(seq(50,100, by=2))',
                'Nsamp;list(500)')
writeLines(index100, con=paste0(case_folder,"/", "index100-", species, ".txt"))
writeLines(lcomp100, con=paste0(case_folder,"/", "lcomp100-", species, ".txt"))
writeLines(agecomp100, con=paste0(case_folder,"/", "agecomp100-", species, ".txt"))
writeLines(calcomp100, con=paste0(case_folder,"/", "calcomp100-", species, ".txt"))
index101 <- c('fleets;2', 'years;list(seq(50,100, by=2))',
              'sds_obs;list(.01)')
lcomp101 <- c('fleets;c(1,2)', 'years;list(seq(50,100, by=2), seq(50,100, by=2))',
              'Nsamp;list(500, 500)', 'cpar;NA')
agecomp101 <- c('fleets;NULL', 'years;list(seq(50,100, by=2),seq(50,100, by=2))',
              'Nsamp;list(500, 500)', 'cpar;NA')
calcomp101 <- c('fleets;NULL', 'years;list(seq(50,100, by=2))',
                'Nsamp;list(500)')
writeLines(index101, con=paste0(case_folder,"/", "index101-", species, ".txt"))
writeLines(lcomp101, con=paste0(case_folder,"/", "lcomp101-", species, ".txt"))
writeLines(agecomp101, con=paste0(case_folder,"/", "agecomp101-", species, ".txt"))
writeLines(calcomp101, con=paste0(case_folder,"/", "calcomp101-", species, ".txt"))
index102 <- c('fleets;2', 'years;list(seq(50,100, by=2))',
              'sds_obs;list(.01)')
lcomp102 <- c('fleets;c(1,2)', 'years;list(seq(50,100, by=2), seq(50,100, by=2))',
              'Nsamp;list(500, 500)', 'cpar;NA')
agecomp102 <- c('fleets;NULL', 'years;list(seq(50,100, by=2),seq(50,100, by=2))',
              'Nsamp;list(500, 500)', 'cpar;NA')
calcomp102 <- c('fleets;c(2)', 'years;list(seq(50,100, by=2))',
                'Nsamp;list(500)')
writeLines(index102, con=paste0(case_folder,"/", "index102-", species, ".txt"))
writeLines(lcomp102, con=paste0(case_folder,"/", "lcomp102-", species, ".txt"))
writeLines(agecomp102, con=paste0(case_folder,"/", "agecomp102-", species, ".txt"))
writeLines(calcomp102, con=paste0(case_folder,"/", "calcomp102-", species, ".txt"))
## End of data cases
### ------------------------------------------------------------

### ------------------------------------------------------------
## Binning files for cod (species specific)
## I is for "internal" which uses the change_bin function. The base case
## for I is to do no binning internally, so set these data bins to be 1cm
## since binning is done afterward (externally)
data0 <- c('age_bins; NULL', 'len_bins; seq(20, 160, by=1)',
           'pop_binwidth; 1', 'pop_minimum_size; 8',
           'pop_maximum_size; 202', 'lcomp_constant; 0.0001',
           'tail_compression; -1')
writeLines(data0, con=paste0(case_folder,"/", "data0-cos.txt"))
data1 <- c('age_bins; NULL', 'len_bins; seq(20, 160, by=2)',
           'pop_binwidth; 2', 'pop_minimum_size; 8',
           'pop_maximum_size; 202', 'lcomp_constant; 0.0001',
           'tail_compression; -1')
writeLines(data1, con=paste0(case_folder,"/", "data1-cos.txt"))
data2 <- c('age_bins; NULL', 'len_bins; seq(20, 160, by=20)',
           'pop_binwidth; 2', 'pop_minimum_size; 8',
           'pop_maximum_size; 202', 'lcomp_constant; 0.0001',
           'tail_compression; -1')
writeLines(data2, con=paste0(case_folder,"/", "data2-cos.txt"))
## External binning cases. For this the change_data function shouldn't be
## called at all, and instead the generated data should be in 1cm bins
## using data0. em_binning0 is to ignore it and leave unchanged for use in internal cases.
em_binning0 <- c('lbin_method;NULL', 'bin_vector;seq(20,160, by=2)')
writeLines(em_binning0, con=paste0(case_folder,"/", "em_binning0-cos.txt"))
em_binning1 <- c('lbin_method;1', 'bin_vector;seq(20,160, by=2)')
writeLines(em_binning1, con=paste0(case_folder,"/", "em_binning1-cos.txt"))
em_binning2 <- c('lbin_method;1', 'bin_vector;seq(20,160, by=20)')
writeLines(em_binning2, con=paste0(case_folder,"/", "em_binning2-cos.txt"))
## End of binning files
### ------------------------------------------------------------
