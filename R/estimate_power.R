#' Estimate Power
#'
#' @param path Name of the folder with your data
#'
#' @return
#' @export
#'
#' @examples estimate_power_create_file("Power1")
estimate_power <- function(path) {
  runModels(paste0("estimate_",path,".inp"))
}

