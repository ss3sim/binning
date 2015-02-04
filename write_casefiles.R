## Source this file to recreate case files used in the analysis


## The deterministic cases
index100 <- c('fleets;2', 'years;list(seq(50,100, by=2))', 'sds_obs;list(.01)')
lcomp100 <- c('fleets;c(1,2)', 'years;list(seq(50,100, by=2), seq(50,100, by=2))',
              'Nsamp;list(500, 500)', 'cpar;NULL')
agecomp100 <- c('fleets;c(1,2)', 'years;list(seq(50,100, by=2),seq(50,100, by=2))',
              'Nsamp;list(500, 500)', 'cpar;NULL')
calcomp100 <- c('fleets;NULL', 'years;list(seq(50,100, by=2),seq(50,100, by=2))',
                'Nsamp;list(500, 500)')
writeLines(index100, con=paste0(case_folder,"/", "index100-", species, ".txt"))
writeLines(lcomp100, con=paste0(case_folder,"/", "lcomp100-", species, ".txt"))
writeLines(agecomp100, con=paste0(case_folder,"/", "agecomp100-", species, ".txt"))
writeLines(calcomp100, con=paste0(case_folder,"/", "calcomp100-", species, ".txt"))
index101 <- c('fleets;2', 'years;list(seq(50,100, by=2))',
              'sds_obs;list(.01)')
lcomp101 <- c('fleets;c(1,2)', 'years;list(seq(50,100, by=2), seq(50,100, by=2))',
              'Nsamp;list(500, 500)', 'cpar;NULL')
agecomp101 <- c('fleets;NULL', 'years;list(seq(50,100, by=2),seq(50,100, by=2))',
              'Nsamp;list(500, 500)', 'cpar;NULL')
calcomp101 <- c('fleets;c(1,2)', 'years;list(seq(50,100, by=2),seq(50,100, by=2))',
                'Nsamp;list(500, 500)')
writeLines(index101, con=paste0(case_folder,"/", "index101-", species, ".txt"))
writeLines(lcomp101, con=paste0(case_folder,"/", "lcomp101-", species, ".txt"))
writeLines(agecomp101, con=paste0(case_folder,"/", "agecomp101-", species, ".txt"))
writeLines(calcomp101, con=paste0(case_folder,"/", "calcomp101-", species, ".txt"))
