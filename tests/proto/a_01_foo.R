options(stringsAsFactors = FALSE)

# rm(list = ls())
# library(dplyr)
# library(datzen)

dir_parent = "~/projects/proj_skel/"
setwd(dir_parent)

dir_rel_scripts = "/scripts/"
dir_scripts = paste0(getwd(),dir_rel_in)
list.files(dir_scripts,full.names = TRUE)
# source(list.files(dir_scripts,full.names = TRUE)[1])

dir_rel_data = "/data/raw/"
dir_data = paste0(getwd(),dir_rel_data)
list.files(dir_data,full.names = TRUE)
# read.csv(list.files(dir_data,full.names = TRUE)[1])

dir_rel_out = "/output/"
dir_out = paste0(getwd(),dir_rel_out)
# saveRDS(x=foo,file=paste0(getwd(),dir_out,'foo.rds'))
