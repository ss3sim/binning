## Instructions to quickly test the new sample conditional age at length
## data:
## Put thsi script and data files into folder
## Run function below
## The come back here and call it with different parameters
## Verify it works by looking at the file created: "outfile"

fleets <- c(1,2)
## These are the only years in the OM
years <- list(c(91,94, 97), 94)
substr_r <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
datfile <- paste0("data.ss_new")
outfile <- paste0("data_test.dat")
sample_calcomp(datfile=datfile,outfile=outfile,
               fleets=fleets, years=years)



#'
#'
#' #' Sample conditional age-at-length (CAL) data and write to file for use by
#' the EM.
#'
#' @details Take a \code{data.SS_new} file containing expected values and
#' sample from true lengths to get realistic proportions for the number of
#' fish in each length bin.
#' @author Cole Monnahan
#'
#' @template lcomp-agecomp-index
#' @template lcomp-agecomp
#' @param datfile A path to the data file, outputed from an OM, containing
#' the true age distributions (population bins). This file is read in and
#' then used to determine how many fish of each age bin are to be sampled.
#' @param ctlfile A path to the control file, outputed from an OM, containing
#' the OM parameters for growth and weight/length relationship. These
#' values are used to determine the uncertainty about weight for fish
#' sampled in each age bin.
#' @template sampling-return
#' @template casefile-footnote
#' @seealso \code{\link{sample_lcomp}, \link{sample_agecomp}}
#' @export

sample_calcomp <- function(datfile, outfile, fleets = c(1,2), Nsamp,
                           years, cv, write_file=TRUE){
    ## Check inputs for errors

    ## The samples are taken from the expected values, where the
    ## age-at-length data is in the age matrix but has a -1 for Lbin_lo and
    ## Lbin_hi, so subset those out, but don't delete the age values since
    ## those are already sampled from, or might be sampled later so need to
    ## leave them there.
    datfile <- r4ss::SS_readdat(datfile, verbose=FALSE)
    agecomp.age <- datfile$agecomp[datfile$agecomp$Lbin_lo== -1,]
    agecomp.cal <- datfile$agecomp[datfile$agecomp$Lbin_lo != -1,]
    lencomp <- datfile$lencomp
    lbin_vector <- datfile$lbin_vector
    newfile <- datfile
    ## A value of NULL for fleets indicates not to sample and strip out the
    ## data from the file.
    if(is.null(fleets)){
        newfile$agecomp <- agecomp.age
        newfile$N_agecomp <- nrow(agecomp.age)
        r4ss::SS_writedat(datlist = newfile, outfile = outfile,
                          overwrite = TRUE, verbose=FALSE)
        return(NULL)
    }
    ## If not, do argument checks
    if(nrow(agecomp.cal)==0) stop("No conditional age-at-length data found")
    if(substr_r(outfile,4) != ".dat" & write_file)
        stop(paste0("outfile ", outfile, " needs to end in .dat"))
    Nfleets <- length(fleets)
    if(any(!fleets %in% unique(agecomp.cal$FltSvy)))
        stop(paste0("The specified fleet number: ",fleets, " does not match input file"))
    if(class(years) != "list" | length(years) != Nfleets)
        stop("years needs to be a list of same length as fleets")
    ## End input checks

    ## The general approach here is to loop through each row to keep
    ## (depends on years input) and resample depending on Nsamp and
    ## cvar. All these rows are then combined back together to form
    ## the final ccomp.
    newcomp.list <- list() # temp storage for the new rows
    k <- 1                 # each k is a new row of data, to be rbind'ed later
    ## Loop through each fleet
        for(i in 1:length(fleets)){
            fl <- fleets[i]
            agecomp.age.fl <- agecomp.age[agecomp.age$FltSvy == fl &
                                      agecomp.age$Yr %in% years[[i]], ]
            agecomp.cal.fl <- agecomp.cal[agecomp.cal$FltSvy == fl &
                                      agecomp.cal$Yr %in% years[[i]], ]
            if(length(years[[i]]) != length(unique((agecomp.age.fl$Yr))))
                stop(paste("A year specified in years was not found in the",
                           "input file for fleet", fl))
            ## Only loop through the subset of years for this fleet
            for(yr in years[[i]]) {
                newcomp <- agecomp.cal.fl[agecomp.cal.fl$Yr==yr, ]
                if(nrow(newcomp) != length(lbin_vector))
                    stop(paste("number of length bins does not match calcomp data: fleet", fl, ", year", yr))
                ## Get the sample sizes of the length and age comps.
                Nsamp.len <- lencomp$Nsamp[lencomp$Yr==yr & lencomp$FltSvy==fl]
                Nsamp.age <- agecomp.age$Nsamp[agecomp.age$Yr==yr & agecomp.age$FltSvy==fl]
                ## Probability distribution for length and age comps
                prob.len <- as.numeric(lencomp[lencomp$Yr==yr & lencomp$FltSvy==fl, -(1:6)])
                prob.age <- as.numeric(agecomp.age[agecomp.age$Yr==yr & agecomp.age$FltSvy==fl, -(1:9)])
                ## Sample to get # fish in each length bin, that is the
                ## sample sizes needed
                N1 <- rmultinom(n=1, size=Nsamp.len, prob=prob.len)
                ## Convert that to proportions
                p1 <- N1/sum(N1)
                N2 <- rmultinom(n=1, size=Nsamp.age, prob=p1)
                ## This is where the actual sampling takes place
                ## Loop through each length bin and sample # fish in
                ## each age bin, given length
                newcomp$Nsamp <- N2
                for(ll in 1:nrow(newcomp)){
                    N.temp <- newcomp$Nsamp[ll]
                    if(N.temp>0){
                        cal.temp <- rmultinom(n=1, size=N2[ll], prob=as.numeric(newcomp[ll,-(1:9)]))
                    } else {
                        cal.temp <- -1
                    }
                    ## Write the samples back, leaving the other columns
                    newcomp[ll,-(1:9)] <- cal.temp
                }
                ## Drpo the -1 value which were temp placeholders
                newcomp <- newcomp[newcomp$Nsamp>0,]
                newcomp.list[[k]] <- newcomp
            }
        }
    ## End of loops doing the sampling. Used values of -1 as placeholders,
    ## so drop them here.

    ## Combine back together into final data frame with the different data
    ## types
    newcomp.final <- do.call(rbind, newcomp.list)
    ## Cases for which data types are available. Need to be very careful
    ## here, as need to keep what's there
    if(nrow(agecomp.age)>0){
        if(nrow(agecomp.cal)>0){
            ## age and cal
            newcomp.final <- rbind(agecomp.age, newcomp.final)
            newfile$agecomp <- newcomp.final
            newfile$N_agecomp <- nrow(newcomp.final)
        } else {
            ## age but not cal
            newfile$agecomp <- newcomp.final
            newfile$N_agecomp <- nrow(newcomp.final)
        }
    } else {
        ## only cal
        if(nrow(agecomp.cal)>0){
            newcomp.final <- agecomp.age
            newfile$agecomp <- newcomp.final
            newfile$N_agecomp <- nrow(newcomp.final)
        } else {
            ## no age nor data
            newcomp.final <- data.frame("#")
            newfile$agecomp <- newcomp.final
            newfile$N_agecomp <- 0
        }
    }
        ## Write the modified file
    if(write_file)
        r4ss::SS_writedat(datlist = newfile, outfile = outfile,
                          overwrite = TRUE, verbose=FALSE)
    return(invisible(newcomp.final))
}




## sample_calcomp <- function(datfile, outfile, ctlfile, fleets = 1,
##                            years, write_file=TRUE){
##     ## A value of NULL for fleets signifies to turn this data off in the
##     ## EM. So quit early and in ss3sim_base do NOT turn wtatage on using
##     ## the maturity function.
##     ##

##     ## Read in datfile, need this for true age distributions and Nsamp
##     datfile <- r4ss::SS_readdat(file=datfile, verbose=FALSE)

##     ## If fleets==NULL, quit here and delete the data so the EM doesn't use it.
##     if(is.null(fleets)){
##         datfile$MeanSize_at_Age_obs <- NULL
##         datfile$N_MeanSize_at_Age_obs <- 0
##         r4ss::SS_writedat(datlist=datfile, outfile=outfile, over=TRUE,
##                           verbose=FALSE)
##         return(NULL)
##     }
##     agecomp <- datfile$agecomp
##     mlacomp <- datfile$MeanSize_at_Age_obs
##     agebin_vector <- datfile$agebin_vector

##     ## Read in the control file
##     ctl <- r4ss::SS_parlines(ctlfile)
##     ## Check inputs for errors
##     if(substr_r(outfile,4) != ".dat" & write_file)
##         stop(paste0("outfile ", outfile, " needs to end in .dat"))
##     Nfleets <- length(fleets)
##     if(class(years) != "list" | length(years) != Nfleets)
##         stop("years needs to be a list of same length as fleets")
##     ## End input checks

##     ## Resample from the length-at-age data. The general approach here is
##     ## to loop through each row and sample based on the true age
##     ## distirbution. Note, true age distribution is known, as is but there
##     ## is uncertainty in the age->length relationship. This uncertainty
##     ## defines the distribution from which we sample. It is also based on
##     ## the # of age samples taken, to mimic reality better.
##     mlacomp.new.list <- list() # temp storage for the new rows
##     k <- 1                 # each k is a new row of data, to be rbind'ed later
##     ## Loop through each fleet, if fleets=NULL then skip sampling and
##     ## return nothing (subtract out this type from the data file)
##     for(fl in 1:length(fleets)){
##         fl.temp <- fleets[fl]
##         mlacomp.fl <- mlacomp[mlacomp$Fleet == fleets[fl] & mlacomp$Yr %in% years[[fl]],]
##         for(j in 1:NROW(mlacomp.fl)){
##             yr.temp <- mlacomp.fl$Yr[j]
##             mlacomp.new <- mlacomp.fl[j,]
##             mla.means <- as.numeric(mlacomp.new[paste0("a",agebin_vector)])
##             ## For each age, given year and fleet, get the expected length
##             ## and CV around that length, then sample from it using
##             ## lognormal (below)
##             CV.growth <- ctl[ctl$Label=="CV_young_Fem_GP_1", "INIT"]
##             sds <- mla.means*CV.growth
##             ## These are the moments on the natural scale, so
##             ## convert to log scale and generate data
##             means.log <- log(mla.means^2/sqrt(sds^2+mla.means^2))
##             sds.log <- sqrt(log(1 + sds^2/mla.means^2))
##             ## Get the true age distributions
##             agecomp.temp <- agecomp[agecomp$Yr==yr.temp & agecomp$FltSvy==fl.temp,]
##             ## Get the true age distributions
##             age.means <- as.numeric(agecomp.temp[-(1:9)])
##             age.Nsamp <- as.numeric(agecomp.temp$Nsamp)
##             ## Draw samples to get # of fish in each age bin
##             age.samples <- rmultinom(n=1, size=age.Nsamp, prob=age.means)
##             ## apply sampling across the columns (ages) to get
##             ## sample of lengths
##             lengths.list <-
##                 lapply(1:length(means.log), function(kk)
##                        exp(rnorm(n=age.samples[kk], mean=means.log[kk], sd=sds.log[kk])))
##             ## Take means and combine into vector to put back
##             ## into the data frame.
##             mlacomp.new.means <- do.call(c, lapply(lengths.list, mean))
##             ## Sometimes you draw 0 fish from an age class,
##             ## resulting in NaN for the mean mlacomp. For now,
##             ## replace with filler values
## ### TODO: Fix the placeholder values for missing age bins
##             mlacomp.new.means[is.nan(mlacomp.new.means)] <- -1
##             ## mla data needs the sample sizes, so concate those on
##             mlacomp.new[-(1:7)] <- c(mlacomp.new.means, age.samples)
##             mlacomp.new.list[[k]] <- mlacomp.new
##             k <- k+1
##         }
##     } # end sampling

##     ## Combine new rows together into one data.frame
##     mlacomp.new <- do.call(rbind, mlacomp.new.list)
##     datfile$MeanSize_at_Age_obs <- mlacomp.new
##     datfile$N_MeanSize_at_Age_obs <- nrow(mlacomp.new)
##     ## Write the modified file
##     if(write_file) r4ss::SS_writedat(datlist=datfile, outfile=outfile,
##                                      over=TRUE, verbose=TRUE)
##     return(invisible(mlacomp.new))
## }
