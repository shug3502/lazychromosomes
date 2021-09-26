#' Kinteochore tracks for a single cell at 4.7s resolution
#'
#' A dataset containing the positions of kinetochores over time
#'
#' @format A data frame with 4880 rows and 12 variables:
#' \describe{
#'   \item{SisterPairID}{id for each kinetochore pair, integer}
#'   \item{Position_1}{x coordinate perpendicular to metaphase plate, in um}
#'   \item{Position_2}{y coordinate within metaphase plate, in um}
#'   \item{Position_3}{z coordinate within metaphase plate, in um}
#'   \item{Frame}{frame of  the movie (dt=4.7s  between frames), integer}
#'   \item{SisterID}{which daughter cluster a kinetochore corresponds to, integer}
#'   ...
#' }
#' @source LLSM live imaging experiments at CMCB, University of Warwick by Onur Sen
"kttracks"
