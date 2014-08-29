I'm dumping some csv files of results in here, so need a way to keep track of what is what. Cole 8/29/14.

tc_test1
Ran this:
for(i in 1:length(tc.seq)){
    tc <- tc.seq[i]
    x <- c(paste("tail_compression;", tc), "file_in; ss3.dat", "file_out; ss3.dat")
    writeLines(x, con=paste0(case_folder, "/T",i, "-cod.txt"))
}
scen <- expand_scenarios(cases=list(D=0, E=0, F=0, R=0,M=0, T=0:10), species="cod")

## Run them in parallel
run_ss3sim(iterations = 1:20, scenarios = scen, parallel=TRUE,
           case_folder = case_folder, om_dir = om,
           em_dir = em, case_files = list(M = "M", F = "F", D =
    c("index", "lcomp", "agecomp"), R = "R", E = "E", T="T"))
 -----------------------------------