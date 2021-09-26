kttracks <- process_jobset("data-raw/kittracking001-kitjobset_191118_JHdonald_v801-OS_LLSM_191112_MC191_DMSO_washout_capture10.ome.csv") %>%
  mutate(filename="kittracking001-kitjobset_191118_JHdonald_v801-OS_LLSM_191112_MC191_DMSO_washout_capture10.ome.csv")
usethis::use_data(kttracks, overwrite = TRUE)
