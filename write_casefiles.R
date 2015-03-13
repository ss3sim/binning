## Source this file to recreate case files used in the analysis
### ------------------------------------------------------------

## some dimensions are the same across species so just loop through and
## write those to be the same
for(spp in species)
{
    ## Get the F cases from the package since based on Fmsy
    file.copy(from=paste0(system.file("cases", package="ss3models"),"/F1-", spp,'.txt'),
              to=case_folder)
    file.copy(from=paste0(system.file("cases", package="ss3models"),"/E991-", spp,'.txt'),
              to=case_folder)
    ## write the data cases
    source("cases/write_cases_data.R")
		## write the binning case files
		source("cases/write_cases_binning.R")

}

## Others are different by species so these are hard coded and write all
## species at the same time.

### ------------------------------------------------------------
## ## Old case files
## ## The deterministic cases (not species specific)
## index100 <- c('fleets;2', 'years;list(seq(50,100, by=2))', 'sds_obs;list(.01)')
## lcomp100 <- c('fleets;c(1,2)', 'years;list(seq(50,100, by=2), seq(50,100, by=2))',
##               'Nsamp;list(500, 500)', 'cpar;NA')
## agecomp100 <- c('fleets;c(1,2)', 'years;list(seq(50,100, by=2),seq(50,100, by=2))',
##               'Nsamp;list(500, 500)', 'cpar;NA')
## calcomp100 <- c('fleets;NULL', 'years;list(seq(50,100, by=2))',
##                 'Nsamp;list(500)')
## writeLines(index100, con=paste0(case_folder,"/", "index100-", species, ".txt"))
## writeLines(lcomp100, con=paste0(case_folder,"/", "lcomp100-", species, ".txt"))
## writeLines(agecomp100, con=paste0(case_folder,"/", "agecomp100-", species, ".txt"))
## writeLines(calcomp100, con=paste0(case_folder,"/", "calcomp100-", species, ".txt"))
## index101 <- c('fleets;2', 'years;list(seq(50,100, by=2))',
##               'sds_obs;list(.01)')
## lcomp101 <- c('fleets;c(1,2)', 'years;list(seq(50,100, by=2), seq(50,100, by=2))',
##               'Nsamp;list(500, 500)', 'cpar;NA')
## agecomp101 <- c('fleets;NULL', 'years;list(seq(50,100, by=2),seq(50,100, by=2))',
##               'Nsamp;list(500, 500)', 'cpar;NA')
## calcomp101 <- c('fleets;NULL', 'years;list(seq(50,100, by=2))',
##                 'Nsamp;list(500)')
## writeLines(index101, con=paste0(case_folder,"/", "index101-", species, ".txt"))
## writeLines(lcomp101, con=paste0(case_folder,"/", "lcomp101-", species, ".txt"))
## writeLines(agecomp101, con=paste0(case_folder,"/", "agecomp101-", species, ".txt"))
## writeLines(calcomp101, con=paste0(case_folder,"/", "calcomp101-", species, ".txt"))
## index102 <- c('fleets;2', 'years;list(seq(50,100, by=2))',
##               'sds_obs;list(.01)')
## lcomp102 <- c('fleets;c(1,2)', 'years;list(seq(50,100, by=2), seq(50,100, by=2))',
##               'Nsamp;list(500, 500)', 'cpar;NA')
## agecomp102 <- c('fleets;NULL', 'years;list(seq(50,100, by=2),seq(50,100, by=2))',
##               'Nsamp;list(500, 500)', 'cpar;NA')
## calcomp102 <- c('fleets;c(2)', 'years;list(seq(50,100, by=2))',
##                 'Nsamp;list(500)')
## writeLines(index102, con=paste0(case_folder,"/", "index102-", species, ".txt"))
## writeLines(lcomp102, con=paste0(case_folder,"/", "lcomp102-", species, ".txt"))
## writeLines(agecomp102, con=paste0(case_folder,"/", "agecomp102-", species, ".txt"))
## writeLines(calcomp102, con=paste0(case_folder,"/", "calcomp102-", species, ".txt"))
## ## End of data cases
## ### ------------------------------------------------------------
