

setwd("~/projects/datzen/")
devtools::load_all()
devtools::document()
roxygen2::roxygenise()


# devtools::install_github('mikejacktzen/datzen',force=TRUE)
library(datzen)
?simlm
?clean_name
?match_2_bank
?garble
?iterload
?itersave
?datzen
?class_df_from_term
?rmabd
?theme_zen
?freadss
?logit
?expit
?save_coord_nb
?moran_op
