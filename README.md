# lazychromsomes – Quantitative assessment of chromosome segregation

The lazychromosomes package allows 
The cowplot package provides various features that help with creating publication-quality figures, such as a set of themes, functions to align plots and arrange them into complex compound figures, and functions that make it easy to annotate plots and or mix plots with images. The package was originally written for internal use in the Wilke lab, hence the name (Claus O. Wilke's plot package). It has also been used extensively in the book  [Fundamentals of Data Visualization.](https://www.amazon.com/gp/product/1492031089)

# Installation

The cowplot package is available on [github]() and can be installed via

    devtools::install_github("shug3502/lazychromosomes")
    
# Usage

    library(dplyr)
    library(lazychromosomes)
    lazychromosomes::kttracks %>% 
      annotate_anaphase_onset_for_cell(method="manual",t_ana_frame=86) %>%
      get_laziness() %>%
      group_by(SisterPairID) %>%
      summarise(max_laziness=max(laziness,na.rm=T))
  
