# lazychromsomes – Quantitative assessment of chromosome segregation

The lazychromosomes package allows quantitative assessment of chromosome segregation via the laziness statistic which measures how far a chromosome is from the other chromosomes associated with the same daughter cell. 

# Installation

The cowplot package is available on [github](https://github.com/shug3502/lazychromosomes) and can be installed via

    devtools::install_github("shug3502/lazychromosomes")
    
# Usage

    library(dplyr)
    library(lazychromosomes)
    lazychromosomes::kttracks %>% 
      annotate_anaphase_onset_for_cell(method="manual",t_ana_frame=86) %>%
      get_laziness() %>%
      group_by(SisterPairID) %>%
      summarise(max_laziness=max(laziness,na.rm=T))
  
