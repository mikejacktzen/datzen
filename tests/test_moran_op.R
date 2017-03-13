library(spdep); example(columbus)

x_features = columbus$AREA
coord_nb = save_coord_nb(foo_spdf=columbus)

out = moran_op(x_features,coord_nb)

str(out)
