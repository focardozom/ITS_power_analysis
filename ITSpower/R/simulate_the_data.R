#' Simulate the Data
#'
#' @param path Name of the folder with your data
#'
#' @return
#' @export
#'
#' @examples simulate_the_data("Power1")
simulate_the_data <- function(path) {
  runModels(paste0(path,".inp"))
}
