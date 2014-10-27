## Peter: run the function below and make sure it outputs what you
## want. Theres a few things you should look at and try to fix before
## trying to run a simulation. In particular the value of -1 is set when no
## fish exists in an age bin.
fleets <- c(1)
## year 100 needs to be in there
years <- list(c(seq(1,100, by=4),100))
substr_r <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
infile <- "wtatage.ss_new"
datfile <- "data.ss_new"
ctlfile <- "control.ss_new"
outfile <- "wtatage_test.dat"
sample_wtatage(infile=infile, datfile=datfile, outfile=outfile,
               fleets=fleets, years=years, ctlfile=ctlfile)


