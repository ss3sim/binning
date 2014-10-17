#' Sample conditional age-at-length compositions from expected values
#'
#' Take a \code{data.SS_new} file containing expected values and sample to
#' create observed age-at-length compositions which are then written to
#' file for use by the estimation model.
#'
#' @author Cole Monnahan
#'
#' @template lcomp-agecomp-index
#' @template lcomp-agecomp
#' @param agebin_vector Depreciated argument. Does nothing and will be
#'   removed in a future major version update. Instead, see
#'   \code{change_bin}.
#' @param keep_conditional A logical if conditional age-at-length data
#'   should be kept or removed entirely from the \code{.dat} file.
#'   \code{sample_agecomp} only works on the age composition data
#'   and not on the conditional age-at-length data. To sample the
#'   conditional data set \code{keep_conditional} to \code{TRUE}
#'   and use \link{\code{sample_ccomp}}.
#'
#' @template sampling-return
#' @template casefile-footnote
#'
#' @examples
#' d <- system.file("extdata", package = "ss3sim")
#' f_in <- paste0(d, "/example-om/data.ss_new")
#' infile <- r4ss::SS_readdat(f_in, section = 2, verbose = FALSE)
#'
#' ## Turn off age comps by specifying fleets=NULL
#' sample_agecomp(infile=infile, outfile="test1.dat",
#'                fleets=NULL, cpar=c(5,NA), Nsamp=list(100,100),
#'                years=list(1995, 1995), write_file=FALSE)
#'
#' ## Generate with a smaller number of fleet taking samples
#' ex1 <- sample_agecomp(infile=infile, outfile="test1.dat", fleets=c(2),
#'                       Nsamp=list(c(10,50)), years=list(c(1999,2000)),
#'                       write_file=FALSE)
#'
#' ## Generate with varying Nsamp by year for first fleet
#' ex2 <- sample_agecomp(infile=infile, outfile="test2.dat", fleets=c(1,2),
#'                       Nsamp=list(c(rep(50, 5), rep(100, 5)), 50),
#'                       years=list(seq(1994, 2012, by=2),
#'                           2003:2012), write_file=FALSE)
#'
#' \donttest{
#' ## Run three  cases showing Multinomial, Dirichlet(1) and over-dispersed
#' ## Dirichlet for different levels of sample sizes
#' op <- par(mfrow = c(1,3))
#' for(samplesize in c(30, 100, 1000)){
#'     ex4 <- sample_agecomp(infile=infile, outfile="test4.dat", fleets=c(1,2),
#'                           Nsamp=list(samplesize, samplesize),
#'                           write_file = FALSE,
#'                           years=list(2000,2000), cpar=c(NA, 1))
#'     ex5 <- sample_agecomp(infile=infile, outfile="test5.dat", fleets=c(1,2),
#'                           Nsamp=list(samplesize, samplesize),
#'                           write_file = FALSE,
#'                           years=list(2000,2000), cpar=c(1, 1))
#'     ex6 <- sample_agecomp(infile=infile, outfile="test6.dat", fleets=c(1,2),
#'                           Nsamp=list(samplesize, samplesize),
#'                           write_file = FALSE,
#'                           years=list(2000,2000), cpar=c(5, 1))
#'     true <- subset(infile$agecomp, FltSvy==1 & Yr == 2000)[-(1:9)]
#'     true <- true/sum(true)
#'     plot(0:15, subset(ex4, FltSvy==1)[1,-(1:9)], type="b", ylim=c(0,1),
#'          col=1, xlab="Age", ylab="Proportion", main=paste("Sample size=",
#'          samplesize))
#'     legend("topright", legend=c("Multinomial", "Dirichlet(1)",
#'                                 "Dirichlet(5)", "Truth"),
#'            lty=1, col=1:4)
#'     lines((0:15), subset(ex5, FltSvy==1)[1,-(1:9)], type="b", col=2)
#'     lines((0:15), subset(ex6, FltSvy==1)[1,-(1:9)], type="b", col=3)
#'     lines((0:15), true, col=4, lwd=2)
#' }
#' par(op)
#' }
#' @seealso \code{\link{sample_lcomp}}
#' @export

## temp values for testing
fleets <- c(1,2)
years <- list(c(1998, 2000), c(1999,2001))
Nsamp <- list(50,50)
cv <- list(.3,.3)
substr_r <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
sample_calcomp(infile, outfile="test.dat", fleets=fleets, years=years,
               Nsamp=Nsamp, cv=cv)

sample_calcomp <- function(infile, outfile, fleets = c(1,2), Nsamp,
                           years, cv, write_file=TRUE){
    ## Check inputs for errors
    if(substr_r(outfile,4) != ".dat" & write_file)
        stop(paste0("outfile ", outfile, " needs to end in .dat"))
    Nfleets <- ifelse(is.null(fleets), 0, length(fleets))
    if(Nfleets >0 & FALSE %in% (fleets %in% unique(agecomp$FltSvy)))
        stop(paste0("The specified fleet number does not match input file"))
    if(Nfleets!= 0 & (class(Nsamp) != "list" | length(Nsamp) != Nfleets))
        stop("Nsamp needs to be a list of same length as fleets")
    if(Nfleets!= 0 & (class(years) != "list" | length(years) != Nfleets))
        stop("years needs to be a list of same length as fleets")
    ## If no fleets are specified then skip these
    if (Nfleets>0){
        for(i in 1:Nfleets){
            if(length(Nsamp[[i]])>1 & length(Nsamp[[i]]) != length(years[[i]]))
                stop(paste0("Length of Nsamp does not match length of years for",
                            "fleet ",fleets[i]))
        }
        if(length(cpar) == 1){
            ## If only 1 value provided, use it for all fleets
            cpar <- rep(cpar, times=Nfleets)
        } else if(length(cpar) != Nfleets){
            stop(paste0("Length of cpar (", length(cpar),
                        ") needs to be length of fleets (", Nfleets,
                        ") or 1"))
        }
    }
    ## End input checks

    ## The samples are taken from the expected values, where the
    ## age-at-length data is in the age matrix but has a -1 for Lbin_lo and
    ## Lbin_hi, so subset those out, but don't delete the age values since
    ## those are already sampled from, or might be sampled later so need to
    ## leave them there.
    agecomp <- infile$agecomp
    agecomp.age <- agecomp[agecomp$Lbin_lo== -1,]
    agecomp.cal <- agecomp[agecomp$Lbin_lo != -1,]
    ## Resample from the length-at-age data
    ## The general approach here is to loop through each row to keep
    ## (depends on years input) and resample depending on Nsamp and
    ## cvar. All these rows are then combined back together to form
    ## the final ccomp.
    newcomp.list <- list() # temp storage for the new rows
    k <- 1                 # each k is a new row of data, to be rbind'ed later
    ## Loop through each fleet
    if (Nfleets>0){
        for(i in 1:length(fleets)){
            fl <- fleets[i]
            agecomp.fl <- agecomp.cal[agecomp.cal$FltSvy == fl &
                                      agecomp.cal$Yr %in% years[[i]], ]
            if(length(years[[i]]) != length(unique((agecomp.fl$Yr))))
                stop(paste("A year specified in years was not found in the",
                           "input file for fleet", fl))
            agecomp.fl$Nsamp <- Nsamp[[i]]
            ## Only loop through the subset of years for this fleet
            for(yr in years[[i]]) {
                newcomp <- agecomp.fl[agecomp.fl$Yr==yr, ]
                ## Now loop through each row and sample for each age bin
                ## (column)
                for(j in 1:NROW(newcomp)){
                    newcomp.lbin <- newcomp[j,]
                    ## Replace expected values with sampled values
                    ## First 1-9 cols aren't data so skip them
                    means <- as.numeric(newcomp.lbin[-(1:9)])
                    sds <- abs(means*cv[[i]])
                    samples.list <- lapply(1:length(means), function(kk)
                        rnorm(n=newcomp.lbin$Nsamp, mean=means[kk], sd=sds[kk]))
                    ## Take means and combine into vector to put back
                    ## into the data frame
                    newcomp.lbin[-(1:9)] <- do.call(c, lapply(samples.list, mean))
                    newcomp.list[[k]] <- newcomp.lbin
                    k <- k+1
                }
            }
        }
    }

    ## Combine new rows together into one data.frame
    if(Nfleets>0) newcomp.final <- do.call(rbind, newcomp.list)
    if(Nfleets==0) newcomp.final = data.frame("#")

    ## Build the new dat file
    newfile <- infile
    ## Recombine the age data, since we don't want to lose that
    newcomp.final <- rbind(agecomp.age, newcomp.final)
    newfile$agecomp <- newcomp.final

    if(Nfleets>0) newfile$N_agecomp <- nrow(newcomp.final)
    ## Write the modified file
    if(write_file)
        r4ss::SS_writedat(datlist = newfile, outfile = outfile,
                          overwrite = TRUE, verbose=FALSE)
    return(invisible(newcomp.final))
}
