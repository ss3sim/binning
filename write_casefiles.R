## Source this file to recreate case files used in the analysis

## The deterministic cases (not species specific)
index100 <- c('fleets;2', 'years;list(seq(50,100, by=2))', 'sds_obs;list(.01)')
lcomp100 <- c('fleets;c(1,2)', 'years;list(seq(50,100, by=2), seq(50,100, by=2))',
              'Nsamp;list(500, 500)', 'cpar;NA')
agecomp100 <- c('fleets;c(1,2)', 'years;list(seq(50,100, by=2),seq(50,100, by=2))',
              'Nsamp;list(500, 500)', 'cpar;NA')
calcomp101 <- c('fleets;NULL', 'years;list(seq(50,100, by=2))',
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
calcomp101 <- c('fleets;c(2)', 'years;list(seq(50,100, by=2))',
                'Nsamp;list(500)')
writeLines(index101, con=paste0(case_folder,"/", "index101-", species, ".txt"))
writeLines(lcomp101, con=paste0(case_folder,"/", "lcomp101-", species, ".txt"))
writeLines(agecomp101, con=paste0(case_folder,"/", "agecomp101-", species, ".txt"))
writeLines(calcomp101, con=paste0(case_folder,"/", "calcomp101-", species, ".txt"))

## Binning files for cod (species specific)
data0 <- c('age_bins; NULL', 'len_bins; seq(20, 155, 3)',
           'pop_binwidth; 2', 'pop_minimum_size; 8',
           'pop_maximum_size; 202', 'lcomp_constant; 0.02',
           'tail_compression; 0.05')
writeLines(calcomp101, con=paste0(case_folder,"/", "data0-cod.txt"))
