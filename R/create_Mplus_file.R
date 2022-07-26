#' Create Mplus file
#'
#' @param x number of time points
#' @param y number of replications
#' @param z effect size in the code
#' @param path name of the folder to save datasets
#'
#' @return
#' @export
#'
#' @examples create_Mplus_file(12,50, -0.33, "Power1")

create_Mplus_file <- function(x, y, z, path) {

  if (!file.exists(path)) {
    dir.create(path)
  }
  if (file.exists(paste0(path,"/sim_data"))) {
    unlink(paste0(path,"/sim_data"), recursive = T)
  }
  dir.create(paste0(path,"/sim_data"))


  cat("TITLE: MC simulation of ITS data;

MONTECARLO: ", paste0("NAMES ARE Y1-Y",x)," ;
            NOBSERVATIONS = 2;
            NREPS =", paste0(y)," ;
            SEED = 474164;
            GENCLASSES = C(2);
            CLASSES = c(2);
            REPSAVE = ALL;
            SAVE =", paste0(path,"/sim_data","/ITS_rep","*.dat"), ";

MODEL MONTECARLO:

  %OVERALL%

  [Y1", paste0("-Y",x, sep=""),"*0];

  intcpt  by Y1", paste0("-Y",x,"@1"),";

  lin_1   by",  paste0("Y",seq(1,x),"@", seq(0,x-1),"\n"),";

  lin_2  by", paste0("Y",seq(1,x/2),"@", 0,"\n"),
      paste0("Y",seq(1+x/2,x),"@", seq(1,x/2),"\n"),";

  Y1", paste0("-Y",x, sep=""),"*.5;

  [intcpt*0];
  [lin_1*.0];
  [lin_2*0];

  intcpt*1;
  lin_1*1;
  lin_2*1;

  intcpt with lin_1@0;
  lin_1 with lin_2@0;
  lin_1 with lin_2@0;

 %c#1%  ! control group

  [intcpt*0];
  [lin_1*0];
  [lin_2*0];

 %c#2%   ! intervention group

  [intcpt*0];
  [lin_1*0];
  [lin_2*",paste0(z),"];

ANALYSIS: TYPE = MIXTURE;

MODEL:

   %OVERALL%

  intcpt  by Y1", paste0("-Y",x, sep=""),"@1;

  lin_1   by",  paste0("Y",seq(1,x),"@", seq(0,x-1),"\n"),";

  lin_2  by", paste0("Y",seq(1,x/2),"@", 0,"\n"),
      paste0("Y",seq(1+x/2,x),"@", seq(1,x/2),"\n"),";

  Y1", paste0("-Y",x, sep=""),"*;

  [intcpt*0];
  [lin_1*0];
  [lin_2*0];

  intcpt*.5;
  lin_1*.5;
  lin_2*.5;

  intcpt with lin_1*0;
  intcpt with lin_2*0;
  lin_1  with lin_2*0;

 %c#1% ! control group

  [intcpt*0];
  [lin_1*0];
  [lin_2*0];

 %c#2% ! intervention group

  [intcpt*0];
  [lin_1*0];
  [lin_2*",paste0(z),"];

 OUTPUT: TECH1 TECH9 ;",
      file = paste0(path,".inp"))


}
