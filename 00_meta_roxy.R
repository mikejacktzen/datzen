

setwd("~/projects/datzen/")
devtools::load_all()
devtools::document()
# roxygenise() better for auto creating importFrom()
roxygen2::roxygenise()


# devtools::install_github('mikejacktzen/datzen',force=TRUE)
library(datzen)
?class_df_from_term
?rm_allbut
