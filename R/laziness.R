#' @title get_laziness
#'
#' @description Provides a data frame with the laziness of each kinetochore at every time frame
#'
#' @param input_df A data frame object with columns for Frames_since_start, SisterID, kittracking_file_str, and Position_1
#'
#' @return A data frame object that contains a laziness for each kinetochore at every time frame
#' @examples
#' data(toydata)
#' output_table <- overview_tab(dat = toydata, id = ccode, time = year)
#' @export
#' @importFrom dplyr "%>%"
#'
get_laziness <- function(input_df) {
  cluster_positions_df <- input_df %>%
    group_by(Frames_since_start,SisterID,kittracking_file_str) %>%
    summarise(med=median(Position_1,na.rm=TRUE),
              spread=mad(Position_1,na.rm=TRUE))

  spread_in_anaphase_df <- input_df %>%
    filter((Frames_since_start >= 5) & (Frames_since_start<=25)) %>%
    group_by(SisterID,kittracking_file_str) %>%
    summarise(anaphase_spread=mad(Position_1,na.rm=TRUE))

  opposite_cluster_positions_df <- cluster_positions_df %>%
    ungroup() %>%
    mutate(SisterID=3-SisterID,
           opposite_med=med) %>%
    dplyr::select(-med,-spread)

  cluster_positions_df <- cluster_positions_df %>%
    inner_join(spread_in_anaphase_df,by=c("SisterID","kittracking_file_str")) %>%
    inner_join(opposite_cluster_positions_df,by=c("SisterID","kittracking_file_str","Frames_since_start"))

  zscore_df <- input_df %>%
    inner_join(cluster_positions_df,by = c("Frames_since_start", "SisterID","kittracking_file_str")) %>%
    mutate(laziness=(-1)^SisterID*(Position_1-med)/anaphase_spread*(Frames_since_start>0),
           opposite_laziness=(-1)^(3-SisterID)*(Position_1-opposite_med)/anaphase_spread*(Frames_since_start>0))
  return(zscore_df)
}
