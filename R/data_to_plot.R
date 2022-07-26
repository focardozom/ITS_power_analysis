#' Data to plot
#'
#' @param path Name of the folder with your data
#'
#' @return
#' @epathport
#'
#' @epathamples data_to_plot("Power1")
data_to_plot <- function(path){

  files_to_gr <- list.files(paste0(path, "/its_data"), full.names = T)
  files_to_gr <- files_to_gr[!files_to_gr %in% paste0(path, "/its_data/ITS_replist.dat")]
  the_data <-  files_to_gr %>%
    map_dfr(read_table, col_names=F, .id = "names")

  the_data %>% filter(path5==1221) %>%
    ggplot(aes(factor(path3), path2,
               color=factor(path4),
               fill=factor(path4))) +
    geom_bopathplot() +
    scale_color_manual(values = c("gray30", "gray30"))+
    scale_fill_manual(values = c("gold","gray60"))+
    theme_bw() +
    theme(legend.position = "none") +
    labs(color="", path="Time", y="Outcome")
}

