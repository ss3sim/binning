## Develop some code to explore how SS is doing binning and our functions
## external case files:
stop("dont source this file")
library(devtools)
## install_github("ss3sim/ss3sim")
## install_github("ss3sim/ss3models")
install("../ss3sim")
install("../ss3models")
source("startup.R")
### ------------------------------------------------------------
## Write some functions that look at expected values for a given bin width
## between the two methods.
plot.binning.test <- function(bin_width, fleet=1){
    df <- run.binning.test.ev(bin_width=bin_width, fleet=fleet)
    data.wide <- reshape2::dcast(subset(df, method != "truth"), year+fleet+length~method, value.var='proportion')
    data.wide <- within(data.wide, {
        difference <- external-internal
        rel.error <- (external-internal)/internal
    })
    g <- ggplot(df, aes(length, proportion, group=method, color=method))+
        geom_line()+facet_wrap("year")
    ggsave(paste0("plots/bin_tests_raw_", bin_width, "cm.png"), g, width=12, height=7)
    g <- ggplot(data.wide, aes(length, difference))+facet_wrap("year")+
        geom_line() + ggtitle("Raw difference, E-I")
    ggsave(paste0("plots/bin_tests_differences_", bin_width, "cm.png"), g, width=12, height=7)
    g <- ggplot(data.wide, aes(length, rel.error))+facet_wrap("year")+
        geom_line() + ggtitle("Relative error of expected values (E-I)/I")
    ggsave(paste0("plots/bin_tests_relerror_", bin_width, "cm.png"), g, width=12, height=7)
}
extract_expected_data2 <- function(data_ss_new = "data.ss_new") {
    ## modified slightly from one in package for temporary external use
    data_file <- readLines(data_ss_new)
    x1 <- grep("#_expected values with no error added", data_file, fixed=TRUE)+1
    x2 <- grep("ENDDATA", data_file)-2
    if(length(x1)!=1 | length(x2)!=1)
        stop("grep failed to find lines for extracting data, not of length 1")
    if(x2<x1)
        stop("Something wrong with OM data.ss_new file, last line comes before first line")
    data_file_new <- data_file[x1:x2]
    if(999 != as.numeric(data_file_new[length(data_file_new)]))
        warning("last line of extracted expected values was not 999, was it read in correctly?")
    writeLines(data_file_new, "temp.dat")
    dat <- r4ss::SS_readdat("temp.dat", verb=FALSE)
    file.remove("temp.dat")
    return(dat)
}
melt.length <- function(df, method, fleet){
    df.long <- melt(subset(df, FltSvy==fleet, select=-c(Seas, Nsamp, Gender, Part)), id.vars=c("Yr", "FltSvy"))
    df.long$variable <- as.numeric(gsub("l", "", df.long$variable))
    names(df.long) <- c('year', 'fleet', "length", "proportion")
    df.long <- ddply(df.long, .(year, fleet), mutate,
                     proportion=proportion/sum(proportion))
    df.long$method <- method
    return(df.long)
}
run.binning.test.ev <- function(bin_width, fleet=1){
    case_folder='cases'; species='cod'
    em_binning100 <- c('lbin_method;1', paste0('bin_vector;seq(20,160, by=', bin_width,')'))
    writeLines(em_binning100, con=paste0(case_folder,"/", "em_binning100-cod.txt"))
    data100 <- c('age_bins; NULL', 'len_bins; seq(20, 160, by=1)',
                 'pop_binwidth; 1', 'pop_minimum_size; 8',
                 'pop_maximum_size; 202', 'lcomp_constant; 1e-10',
                 'tail_compression; -1')
    writeLines(data100, con=paste0(case_folder,"/", "data100-cod.txt"))
    ## Internal case files:
    em_binning101 <- c('lbin_method;NULL', 'bin_vector;seq(20,160, by=2)')
    writeLines(em_binning101, con=paste0(case_folder,"/", "em_binning101-cod.txt"))
    data101 <- c('age_bins; NULL', paste0('len_bins;seq(20,160, by=', bin_width,')'),
                 'pop_binwidth; 1', 'pop_minimum_size; 8',
                 'pop_maximum_size; 202', 'lcomp_constant; 1e-10',
                 'tail_compression; -1')
    writeLines(data101, con=paste0(case_folder,"/", "data101-cod.txt"))
    case_files <- list(F="F", B=c("em_binning", "data"),
                       D=c("index","lcomp","agecomp","calcomp"), E="E")
    scenarios <- expand_scenarios(cases=list(D=1, F=1, B=100:101, E=991), species=species)
    ## Dont care about estimated values so turn off estimation in the EM to
    ## speed up
    unlink(scenarios, TRUE)
    run_ss3sim(iterations=1, scenarios=scenarios,
               case_folder=case_folder, om_dir=ss3model(species, "om"),
               em_dir=ss3model(species, "em"), case_files=case_files,
               call_change_data=TRUE, admb_options=" -maxfn 1")
    ## Get the different length expected values; note need to do the external
    ## binning manually on the ss_new file to get expected values directly and
    ## avoid sampling uncertainty
    ## The external case is used to get the "truth" which is the original 1cm
    ## bins as well as the externally binned
    external.dat <- extract_expected_data2("B100-D1-E991-F1-cod/1/om/data.ss_new")
    external <- change_em_binning(datfile=external.dat, file_out="xx", write_file=FALSE,
                                  bin_vector=seq(20,160, by=bin_width), lbin_method=1)$lencomp
    truth <- external.dat$lencomp
    ## The internal just has the one case
    internal <- extract_expected_data2("B101-D1-E991-F1-cod/1/om/data.ss_new")$lencomp
    ## Get ratio of # bins to help scale the proportions later
    num.bins.ratio <- ncol(external[-(1:6),])/ncol(truth[-(1:6),])
    ## Prep them for plotting
    external <- melt.length(external, "external", fleet=fleet)
    internal <- melt.length(internal, "internal", fleet=fleet)
    truth <- melt.length(truth, "truth", fleet=fleet)
    truth$proportion <- truth$proportion/num.bins.ratio
    data <- rbind(external, truth, internal)
    ## clean up
    unlink(scenarios, TRUE)
    file.remove(paste0(case_folder, "/", c("data100-cod.txt", "data101-cod.txt", "em_binning100-cod.txt", "em_binning101-cod.txt")))
    return(invisible(data))
}
## Loop through and make plots for a set of bin widths for cod
for(i in c(1, 2, 5, 10, 13)){ plot.binning.test(i) }
## End of expected values
### ------------------------------------------------------------

### ------------------------------------------------------------
## Look at a set of observed samples across iterations and compare between
## the methods to see, the ratio should be 1 on average since the expected
## values are very close.
fleet <- 1
id <- "D1-B3"
internal.dir <- "B0-D1-E991-F1-I3-cod"
external.dir <- "B3-D1-E991-F1-I0-cod"
internal.reps <- list.dirs(internal.dir, recursive=FALSE, full=FALSE)
external.reps <- list.dirs(external.dir, recursive=FALSE, full=FALSE)
if(length(external.reps)!=length(internal.reps)) stop("not same reps")
temp.list <- list()
for(i in 1:length(internal.reps)){
    int.temp <- SS_readdat(paste(internal.dir, internal.reps[i], "em", "ss3.dat", sep="/"), verb=FALSE)$lencomp
    ext.temp <- SS_readdat(paste(external.dir, external.reps[i], "em", "ss3.dat", sep="/"), verb=FALSE)$lencomp
    ratio.temp <- int.temp[,-(1:6)]/ext.temp[,-(1:6)]
    temp.list[[i]]<- cbind(replicate=i, int.temp[,1:6], ratio.temp)
}
results <- do.call(rbind, temp.list)
results.long <-
    melt(subset(results, FltSvy==fleet, select=-c(Seas, Nsamp, Gender,
                         Part)), id.vars=c("Yr", "FltSvy", 'replicate'))
results.long$variable <- as.numeric(gsub("l", "", results.long$variable))
names(results.long) <- c('year', 'fleet', 'replicate', "length", "proportion")
results.long$proportion[!is.finite(results.long$proportion)] <- NA
results.long.means <- ddply(results.long, .(replicate, length), mutate,
                 mean.proportion=mean(proportion, na.rm=TRUE))
g <- ggplot()+  geom_line(data=results.long, aes(length, proportion,
                          group=year, color=year), alpha=.3)+
    geom_line(data=results.long.means, aes(length, mean.proportion), lwd=1.5)+
    facet_wrap("replicate") + geom_hline(yintercept=1, col=gray(.5))+
    ggtitle("Ratio of observed internal/external; mean across years")
ggplot(results.long.means, aes(factor(length), mean.proportion))+geom_violin()
ggsave(paste0("plots/ratio_tests_", id, ".png"),g, width=12, height=7)

## End of observed ratio tests
### ------------------------------------------------------------
