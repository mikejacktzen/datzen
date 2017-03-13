
library(spdep); example(columbus)


?poly2nb

getwd()
dir_out = "~/projects/datzen/tests/proto/"

save_coord_nb(foo_spdf = columbus,dir_out=NULL)

save_coord_nb(foo_spdf = columbus,dir_out=dir_out)
