library(datzen)
library(spdep); example(columbus)

names(columbus)
x_features = as.data.frame(columbus[,c("AREA","HOVAL","CRIME","OPEN")])

coord_nb = save_coord_nb(foo_spdf=columbus)

out = moran_op(x_features,coord_nb)

str(out)
