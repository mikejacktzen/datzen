

# devtools::install_github('statsccpr/datzen',force=TRUE)

library(roxygen2)
library(devtools)

setwd("~/projects/datzen")
devtools::load_all()
devtools::document()
# roxygenise() better for auto creating importFrom()
roxygen2::roxygenise()

