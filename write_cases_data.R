
### ------------------------------------------------------------
## Data cases
#Scenario 1:
index1 <- c('fleets;c(2)', 'years;list(seq(76,100, by=2))', 'sds_obs;list(.2)')
lcomp1 <- c('fleets;c(1,2)', 'years;list(c(seq(26,46,by=10),seq(51,66,by=5),71:100), seq(76,100, by=2))', 'Nsamp;list(500/4, 500)', 'cpar;c(NA,NA)')
agecomp1 <- "fleets;NULL"
calcomp1 <- "fleets;NULL"
writeLines(index1, con=paste0(case_folder,"/", "index1-", spp, ".txt"))
writeLines(lcomp1, con=paste0(case_folder,"/", "lcomp1-", spp, ".txt"))
writeLines(agecomp1, con=paste0(case_folder,"/", "agecomp1-", spp, ".txt"))
writeLines(calcomp1, con=paste0(case_folder,"/", "calcomp1-", spp, ".txt"))

#Scenario 2:
index2 <- c('fleets;c(2)', 'years;list(seq(76,100, by=2))', 'sds_obs;list(.2)')
lcomp2 <- c('fleets;c(1,2)', 'years;list(c(seq(26,46,by=10),seq(51,66,by=5),71:100), seq(76,100, by=2))', 'Nsamp;list(500/4, 500)', 'cpar;c(NA,NA)')
agecomp2 <- c('fleets;c(1,2)', 'years;list(c(seq(26,46,by=10),seq(51,66,by=5),71:100), seq(76,100, by=2))', 'Nsamp;list(500/4, 500)', 'cpar;c(NA,NA)')
calcomp2 <- c('fleets;NULL')
writeLines(index2, con=paste0(case_folder,"/", "index2-", spp, ".txt"))
writeLines(lcomp2, con=paste0(case_folder,"/", "lcomp2-", spp, ".txt"))
writeLines(agecomp2, con=paste0(case_folder,"/", "agecomp2-", spp, ".txt"))
writeLines(calcomp2, con=paste0(case_folder,"/", "calcomp2-", spp, ".txt"))

#Scenario 3:
index3 <- c('fleets;c(2)', 'years;list(seq(76,100, by=2))', 'sds_obs;list(.2)')
lcomp3 <- c('fleets;c(1,2)', 'years;list(c(seq(26,46,by=10),seq(51,66,by=5),71:100), seq(76,100, by=2))', 'Nsamp;list(500/4, 500)', 'cpar;c(NA,NA)')
agecomp3 <- c('fleets;NULL')
calcomp3 <- c('fleets;c(1,2)', 'years;list(c(seq(26,46,by=10),seq(51,66,by=5),71:100), seq(76,100, by=2))', 'Nsamp;list(500/4, 500)')
writeLines(index3, con=paste0(case_folder,"/", "index3-", spp, ".txt"))
writeLines(lcomp3, con=paste0(case_folder,"/", "lcomp3-", spp, ".txt"))
writeLines(agecomp3, con=paste0(case_folder,"/", "agecomp3-", spp, ".txt"))
writeLines(calcomp3, con=paste0(case_folder,"/", "calcomp3-", spp, ".txt"))

#Scenario 4:
index4 <- c('fleets;c(2)', 'years;list(c(seq(94,100,by=2)))', 'sds_obs;list(.2)')
lcomp4 <- c('fleets;c(1,2)', 'years;list(c(seq(86,90,by=10), 91:100), c(seq(94,100,by=2)))', 'Nsamp;list(20, 20)', 'cpar;c(NA,NA)')
agecomp4 <- c('fleets;NULL')
calcomp4 <- c('fleets;NULL')
writeLines(index4, con=paste0(case_folder,"/", "index4-", spp, ".txt"))
writeLines(lcomp4, con=paste0(case_folder,"/", "lcomp4-", spp, ".txt"))
writeLines(agecomp4, con=paste0(case_folder,"/", "agecomp4-", spp, ".txt"))
writeLines(calcomp4, con=paste0(case_folder,"/", "calcomp4-", spp, ".txt"))

#Scenario 5:
index5 <- c('fleets;c(2)', 'years;list(c(seq(94,100,by=2)))', 'sds_obs;list(.2)')
lcomp5 <-  c('fleets;c(1,2)', 'years;list(c(seq(86,90,by=10), 91:100), c(seq(94,100,by=2)))', 'Nsamp;list(20, 20)', 'cpar;c(NA,NA)')
agecomp5 <-  c('fleets;c(1,2)', 'years;list(c(seq(86,90,by=10), 91:100), c(seq(94,100,by=2)))', 'Nsamp;list(20, 20)', 'cpar;c(NA,NA)')
calcomp5 <- c('fleets;NULL')
writeLines(index5, con=paste0(case_folder,"/", "index5-", spp, ".txt"))
writeLines(lcomp5, con=paste0(case_folder,"/", "lcomp5-", spp, ".txt"))
writeLines(agecomp5, con=paste0(case_folder,"/", "agecomp5-", spp, ".txt"))
writeLines(calcomp5, con=paste0(case_folder,"/", "calcomp5-", spp, ".txt"))

#Scenario 6:
index6 <- c('fleets;c(2)', 'years;list(c(seq(94,100,by=2)))', 'sds_obs;list(.2)')
lcomp6 <-  c('fleets;c(1,2)', 'years;list(c(seq(86,90,by=10), 91:100), c(seq(94,100,by=2)))', 'Nsamp;list(20, 20)', 'cpar;c(NA,NA)')
agecomp6 <- c('fleets;NULL')
calcomp6 <-  c('fleets;c(1,2)', 'years;list(c(seq(86,90,by=10), 91:100), c(seq(94,100,by=2)))', 'Nsamp;list(20, 20)')
writeLines(index6, con=paste0(case_folder,"/", "index6-", spp, ".txt"))
writeLines(lcomp6, con=paste0(case_folder,"/", "lcomp6-", spp, ".txt"))
writeLines(agecomp6, con=paste0(case_folder,"/", "agecomp6-", spp, ".txt"))
writeLines(calcomp6, con=paste0(case_folder,"/", "calcomp6-", spp, ".txt"))

#Scenario 7:
index7 <- c('fleets;c(2)', 'years;list(c(seq(94,100,by=2)))', 'sds_obs;list(.2)')
lcomp7 <-  c('fleets;c(1,2)', 'years;list(c(seq(86,90,by=10), 91:100), c(seq(94,100,by=2)))', 'Nsamp;list(50, 50)', 'cpar;c(NA,NA)')
agecomp7 <-  c('fleets;c(1,2)', 'years;list(c(seq(86,90,by=10), 91:100), c(seq(94,100,by=2)))', 'Nsamp;list(10, 10)', 'cpar;c(NA,NA)')
calcomp7 <- c('fleets;NULL')
writeLines(index7, con=paste0(case_folder,"/", "index7-", spp, ".txt"))
writeLines(lcomp7, con=paste0(case_folder,"/", "lcomp7-", spp, ".txt"))
writeLines(agecomp7, con=paste0(case_folder,"/", "agecomp7-", spp, ".txt"))
writeLines(calcomp7, con=paste0(case_folder,"/", "calcomp7-", spp, ".txt"))

#Scenario 8:
index8 <-  c('fleets;c(2)', 'years;list(c(seq(94,100,by=2)))', 'sds_obs;list(.2)')
lcomp8 <-   c('fleets;c(1,2)', 'years;list(c(seq(86,90,by=10), 91:100), c(seq(94,100,by=2)))', 'Nsamp;list(50, 50)', 'cpar;c(NA,NA)')
agecomp8 <-  c('fleets;NULL')
calcomp8 <-   c('fleets;c(1,2)', 'years;list(c(seq(86,90,by=10), 91:100), c(seq(94,100,by=2)))', 'Nsamp;list(10, 10)')
writeLines(index8, con=paste0(case_folder,"/", "index8-", spp, ".txt"))
writeLines(lcomp8, con=paste0(case_folder,"/", "lcomp8-", spp, ".txt"))
writeLines(agecomp8, con=paste0(case_folder,"/", "agecomp8-", spp, ".txt"))
writeLines(calcomp8, con=paste0(case_folder,"/", "calcomp8-", spp, ".txt"))
