# lazychromsomes – Quantitative assessment of chromosome segregation

The lazychromosomes package allows quantitative assessment of chromosome segregation via the laziness statistic which measures how far a chromosome is from the other chromosomes associated with the same daughter cell. 

# Installation

The lazychromosomes package is available on [github](https://github.com/shug3502/lazychromosomes) and can be installed via

    devtools::install_github("shug3502/lazychromosomes",ref="main")
    
# Usage

    library(dplyr)
    library(lazychromosomes)
    data(kttracks)
    kttracks %>% 
      annotate_anaphase_onset_for_cell(method="manual",t_ana_frame=86) %>%
      get_laziness() %>%
      group_by(SisterPairID) %>%
      summarise(max_laziness=max(laziness,na.rm=T))
  
To use with your own data, first track a movie using the kinetochore tracking software [KiT](https://doi.org/10.1093/bioinformatics/btw087) available from [github](https://github.com/cmcb-warwick/KiT)
Export the tracks from MATLAB as a csv file using ``kitMakeAnalysisTable``. These tracks can be loaded and processed in R using the ``lazychromosomes::process_jobset`` function.  

