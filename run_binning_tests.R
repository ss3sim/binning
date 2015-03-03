devtools::install_github("ss3sim/ss3sim")
source("startup.R")
### ------------------------------------------------------------
## Develop some code to explore how SS is doing binning and our functions
## external case files:
bin_width <- 10
## run function below first
data10 <- run_binning_test(10)
subset(data10, fleet==1 & year==71 & length==80)
data5 <- run_binning_test(5)
data13 <- run_binning_test(13)
g <- ggplot(data10, aes(length, proportion, group=method, color=method))+
    geom_line()+facet_wrap("year")
ggsave("plots/bin_tests_10cm.png", g, width=12, height=7)
g <- ggplot(data5, aes(length, proportion, group=method, color=method))+
    geom_line()+facet_wrap("year")
ggsave("plots/bin_tests_13cm.png", g, width=12, height=7)

run_binning_test <- function(bin_width){
    case_folder='cases'; species='cod'
    em_binning100 <- c('lbin_method;1', paste0('bin_vector;seq(20,160, by=', bin_width,')'))
    writeLines(em_binning100, con=paste0(case_folder,"/", "em_binning100-cod.txt"))
    data100 <- c('age_bins; NULL', 'len_bins; seq(20, 160, by=1)',
                 'pop_binwidth; 1', 'pop_minimum_size; 8',
                 'pop_maximum_size; 202', 'lcomp_constant; 0.0001',
                 'tail_compression; -1')
    writeLines(data100, con=paste0(case_folder,"/", "data100-cod.txt"))
    ## Internal case files:
    em_binning101 <- c('lbin_method;NULL', 'bin_vector;seq(20,160, by=2)')
    writeLines(em_binning101, con=paste0(case_folder,"/", "em_binning101-cod.txt"))
    data101 <- c('age_bins; NULL', paste0('len_bins;seq(20,160, by=', bin_width,')'),
                 'pop_binwidth; 1', 'pop_minimum_size; 8',
                 'pop_maximum_size; 202', 'lcomp_constant; 0.0001',
                 'tail_compression; -1')
    writeLines(data101, con=paste0(case_folder,"/", "data101-cod.txt"))
    case_files <- list(F="F", B=c("em_binning", "data"),
                       D=c("index","lcomp","agecomp","calcomp"), E="E")
    scenarios <- expand_scenarios(cases=list(D=1, F=1, B=100:101, E=991), species=species)
    ## Dont care about estimated values so turn off estimation in the EM to
    ## speed up
    run_ss3sim(iterations=1, scenarios=scenarios,
               case_folder=case_folder, om_dir=ss3model(species, "om"),
               em_dir=ss3model(species, "em"), case_files=case_files,
               call_change_data=TRUE, admb_options=" -maxfn 1")
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
    ## Get the different length expected values; note need to do the external
    ## binning manually on the ss_new file to get expected values directly and
    ## avoid sampling uncertainty

    ## The external case is used to get the "truth" which is the original 1cm
    ## bins as well as the externally binned
    external.dat <- extract_expected_data2("B100-D1-E991-F1-cod/1/om/data.ss_new")
    len.external <- change_em_binning(datfile=external.dat, file_out="xx", write_file=FALSE,
                                      bin_vector=seq(20,160, by=bin_width), lbin_method=1)$lencomp
    len.truth <- external.dat$lencomp
    ## The internal just has the one case
    internal.dat <- extract_expected_data2("B101-D1-E991-F1-cod/1/om/data.ss_new")
    len.internal <- internal.dat$lencomp
    unlink(scenarios, TRUE)
    c("data100-cod.txt", "data101-cod.txt", "em_binning100-cod.txt", "em_binning101-cod.txt")
    ## Melt these down for plotting
    ## Get ratio of # bins to help scale the proportions later
    num.bins.ratio <- ncol(len.external[-(1:6),])/ncol(len.truth[-(1:6),])
    len.external.long <- melt(subset(len.external, FltSvy==1, select=-c(Seas, Nsamp, Gender, Part)), id.vars=c("Yr", "FltSvy"))
    len.external.long$variable <- as.numeric(gsub("l", "", len.external.long$variable))
    names(len.external.long) <- c('year', 'fleet', "length", "proportion")
    len.external.long <- ddply(len.external.long, .(year, fleet), mutate,
                               proportion=proportion/sum(proportion))
    len.external.long$method <- "external"
    len.truth.long <- melt(subset(len.truth, FltSvy==1, select=-c(Seas, Nsamp, Gender, Part)), id.vars=c("Yr", "FltSvy"))
    len.truth.long$variable <- as.numeric(gsub("l", "", len.truth.long$variable))
    names(len.truth.long) <- c('year', 'fleet', "length", "proportion")
    len.truth.long <- ddply(len.truth.long, .(year, fleet), mutate,
                            proportion=proportion/sum(proportion))
    len.truth.long$proportion <-     len.truth.long$proportion/num.bins.ratio
    len.truth.long$method <- "truth"
    len.internal.long <- melt(subset(len.internal, FltSvy==1, select=-c(Seas, Nsamp, Gender, Part)), id.vars=c("Yr", "FltSvy"))
    len.internal.long$variable <- as.numeric(gsub("l", "", len.internal.long$variable))
    names(len.internal.long) <- c('year', 'fleet', "length", "proportion")
    len.internal.long <- ddply(len.internal.long, .(year, fleet), mutate,
                               proportion=proportion/sum(proportion))
    len.internal.long$method <- "internal"

    data <- rbind(len.external.long, len.truth.long, len.internal.long)
    return(invisible(data))
}
