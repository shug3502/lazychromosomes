#' @title annotate_anaphase_onset_for_cell
#'
#' @description Provides a data frame wiith time relative to the time of anaphase onset via manual annotation
#'
#' @param input_df A data frame object with columns for Frame, SisterID, filename, and Position_1
#'
#' @return A data frame object with time (in Frames) relative to the anaphase onset time (or Frame)
#' @examples
#' data(toydata)
#' output_table <- overview_tab(dat = toydata, id = ccode, time = year)
#' @export
#' @importFrom dplyr "%>%"
#'
annotate_anaphase_onset_for_cell <- function(raw_df,
                                             method="manual",t_ana_frame=NULL) {
  if (method!="manual") stop("Only manual annotation of anaphase onset currently implemented. Automatic annotation to be implemmented.")
  stopifnot(is.numeric(t_ana_frame)) #ensure you enter a frame for anaphase onset
  if (length(unique(raw_df$filename))>1) warning("More than one cell present in data. Annotations should be for one single cell only.")
  raw_df %>%
    ungroup() %>%
    mutate(Frames_since_start = Frame-t_ana_frame,
           kittracking_file_str = filename)
}
