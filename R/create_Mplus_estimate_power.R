#' Create Mplus Estimate Power
#'
#' @param path Name of the folder with your data
#'
#' @return
#' @export
#'
#' @examples estimate_power_create_file("Power1")
#'
estimate_power_create_file <- function(path) {
  cat(
    "TITLE: test of ITS data ;
     DATA:
       file is", paste0(path,"/its_data/ITS_replist.dat"),";
     TYPE = MONTECARLO ;

     VARIABLE:
       NAMES ARE
     OBS   value     T     G  X   D     P    GT    GD    GP   GTP;

     USEVARIABLES ARE
     value     T     G   D     P    GT    GD    GP   ;

     !CATEGORICAL ARE ;

     MISSING = ALL (999) ;

     ANALYSIS:

       MODEL:

       value on T     G     D     P    GT    GD    GP  ;


     OUTPUT: sampstat standardized ;
     ",
    file = paste0("estimate_",path,".inp")
  )
}
