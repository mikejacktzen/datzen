# meta commands
rm_allbut = function(list_keep){
  rm(list=ls()[!(ls() %in% unlist(list_keep))])
}