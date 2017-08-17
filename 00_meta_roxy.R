

setwd("~/projects/datzen/")
devtools::load_all()
devtools::document()
roxygen2::roxygenise()


# devtools::install_github('mikejacktzen/datzen',force=TRUE)
library(datzen)
?iterload
?itersave
?datzen
?class_df_from_term
?rmabd
?theme_zen
?readss
?logit
?expit
?save_coord_nb
?moran_op
