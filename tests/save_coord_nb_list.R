


save_coord_nb = function(foo_nb,dir_out,write2disk=TRUE){


  ###################################################
  # output cartesian triplet: (row,col,value)
  # iterate over row,col and use write()
  # using nb object (its a list), print out its row/col/value tiplet rcoordinates
  ###################################################

  if(write2disk==TRUE){

    # create column header
    write(paste('row','col','val',sep=','),
          file=paste0(dir_out,"/coord_rep_nb_list.txt"),
          append=FALSE)

    for (i in 1:length(foo_nb)){
      for (j in 1:length(foo_nb[[i]])){

        out2 <- paste(i,foo_nb[[i]][j],'1', sep=',')

        # dir_out = "/ccpr/user2/mtzen/projects/datzen/tests/proto/"

        write((out2),
              file=paste0(dir_out,"/coord_rep_nb_list.txt"),
              append=TRUE)
      }
    }
  }

  # else, in memory list
  else{
    return('in memory coord rep not yet implemented')
  }

}
