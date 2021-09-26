extract_long_tracks <- function(Data,K=Inf,T0=0,max_missing=0){
  #take str giving reference to a jobset converted to csv and return all tracks beyond a certain length
  #defaults to using all the available data
  how_much_missing <- Data %>%
    dplyr::filter(Frame<=(T0+K), Frame>T0) %>% #assess only on first K frames, starting at frame T0 + 1
    dplyr::group_by(SisterPairID,SisterID) %>% #assess each track individually
    dplyr::summarise(proportionNaN = sum(is.na(Position_1))/length(Position_1)) %>%
    dplyr::group_by(SisterPairID) %>% #combine to consider pairs together
    dplyr::summarise(proportionNaN = max(proportionNaN))
  Data <- dplyr::left_join(Data,how_much_missing) %>%
    dplyr::group_by(SisterPairID,SisterID) %>%
    dplyr::filter(proportionNaN <= max_missing,
                  Frame<=(T0+K), Frame>T0) %>%
    dplyr::ungroup()

  return(Data)
}

interpolate_missing_data <- function(Position,Time){
  Y <- zoo::zoo(cbind(Time,Position)) #see https://stackoverflow.com/questions/7188807/interpolate-na-values
  index(Y) <- Y[,1]
  Y_approx <- na.approx(Y)
  return(as.numeric(Y_approx[,2]))
}

reorder_sisters <- function(Data){
  Data %>%
    dplyr::group_by(SisterPairID,SisterID) %>%
    dplyr::summarise(x = mean(Position_1,na.rm=T)) %>%
    dplyr::group_by(SisterPairID) %>%
    dplyr::summarise(need_to_switch = (first(x) - last(x))<0) %>%
    dplyr::right_join(Data) %>%
    dplyr::mutate(SisterID = as.integer(dplyr::case_when(
      need_to_switch & (SisterID==1) ~ 2,
      need_to_switch & (SisterID==2) ~ 1,
      !need_to_switch ~ as.double(SisterID),
      TRUE ~ as.double(NA)))) %>%
    dplyr::select(-need_to_switch)
}

process_jobset <- function(jobset_str,K=Inf,max_missing=0,start_from=0,plot_opt=0){
  Data <- read.csv(jobset_str,header=TRUE) %>%
    dplyr::group_by(SisterPairID,SisterID) %>%
    dplyr::mutate(Position_1=interpolate_missing_data(Position_1,Time)) %>%
    dplyr::mutate(Position_2=interpolate_missing_data(Position_2,Time)) %>%
    dplyr::mutate(Position_3=interpolate_missing_data(Position_3,Time)) %>%
    dplyr::ungroup() %>%
    extract_long_tracks(K,start_from,max_missing) %>%
    reorder_sisters()
  return(Data)
}
