The effect of discretizing length on growth estimation in integrated age-structured stock assessments
=======================

Monnahan, C.C., Ono, K., Anderson, S.C., Rudd, M.B., Hicks, A.C., Hurtado-Ferro, F., Johnson, K.F., Kuriyama, P.T., Licandeo, R.R., Stawitz, C.C., Taylor, I.G., and Valero, J.L. 2016. The effect of length bin width on growth estimation in integrated age-structured stock assessments. Fisheries Research 180:103-112.

This folder contains:

- Models, case files, results, plots, and figures from the study.
- The code necessary to reproduce the study.

To reproduce this study:

1. Clone this repository into a local folder.

2. Open the run_simulation.R script in R, set working directory to that folder. Use
the devtools install commands to install the correct version of ss3sim and
r4ss (9/4/2015 was latest install date, you may want to specify a commit
from that day to avoid errors introduced by future commits).

3. Set the ss3sim executables in the system PATH (see vignette for
   help). Certain versions of ss3sim do this automatically.

4. Set the number of cores you would like to use. Run the code in Step 0,
including sourcing the startup.R script, and installing whichever packages
you need to. The workspace should now be ready.

5. Run steps 2 and 3, which may take a week or longer and a lot of disk
space.

6. Run step 4 to reproduce plots (not in the paper) and figures (are in the
paper.

If you just want to explore the results you can accomplish this by running
the load_results.R script (after doing step 4 above). The results are now
loaded into the workspace. See the script file for the contents of the
files.


