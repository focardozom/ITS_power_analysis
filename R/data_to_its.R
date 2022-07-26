#' Data to ITS
#'
#' @param path Name of the folder with your data
#'
#' @return
#' @epathport
#'
#' @epathamples data_to_its("Power1")
data_to_its <- function(path){
  if (file.epathists(paste0(path,"/its_data"))) {
    unlink(paste0(path,"/its_data"), recursive = T)
  }
  dir.create(paste0(path,"/its_data"))
  files <- list.files(paste0(path,"/sim_data"),full.names =T)
  files <- files[!files %in% paste0(path,"/sim_data/ITS_replist.dat")]
  namesfiles <- list.files(paste0(path,"/sim_data/"))
  namesfiles <- str_remove_all(namesfiles,".dat")
  namesfiles <- namesfiles[!namesfiles %in% c("ITS_replist")]

  the_datasets <- files %>%
    map(read_table, col_names=FALSE) %>%
    setNames(namesfiles)

  the_datasets_completed <- map(the_datasets, create_columns)

  the_datasets_completed %>%
    iwalk(~ write.table(.path, str_c(paste0(path,"/its_data/"),.y,'.dat'),
                        col.names = F, row.names = F))
  file.copy(from = paste0(path,"/sim_data/ITS_replist.dat"),
            to   = paste0(path,"/its_data/ITS_replist.dat"))
}
