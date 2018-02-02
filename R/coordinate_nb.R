
#' @title The coordinate_nb() function returns spatial neighborhoods in a coordinate triplet format
#'
#' @param foo_spdf an object of class \code{\link[sp]{SpatialPolygonsDataFrame}}
#' @param style an optional character representing the style of spatial weights
#' The same 'style' arg in \code{\link[spdep]{nb2listw}}
#' @param dir_out an optional character representing the output directory
#' if the user wishes to write to a '.csv'
#' @param ... optional arguments passed to \code{\link[spdep]{nb2listw}}
#'
#' @return A data.frame of the nb-coordinate triplets ("from","to","weights") with 'spatial.neighbour' class returned from \code{\link[spdep]{listw2sn}}
#' @export
#'
#' @details If dir_out=NULL (the default), then a data.frame of (i,j,k) coordinate triplets is returned to the environment.
#' See \code{\link[spdep]{listw2sn}} for more details.
#' Otherwise a '.csv.' will be created at the specified destination path.
#'
#' @examples
#' example(columbus,package="spdep")
#' out_ijk = coordinate_nb(foo_spdf=columbus, zero.policy=TRUE)
#'
#' # above output is in coordinate structure
#' # below converts to adjacency matrix
#' mat_adj = spdep::as.spam.listw(sn2listw(out_ijk))

coordinate_nb = function(foo_spdf,style="B",dir_out=NULL, ...){

  ###################################################
  # output cartesian triplet: (row,col,value)
  # iterate over row,col and use write()
  # using nb object (its a list), print out its row/col/value tiplet rcoordinates
  ###################################################

  require(spdep)

  # ?poly2nb
  # ?nb2listw
  # ?listw2sn

  # sparse_coord = foo_spdf %>% poly2nb() %>%
  #   nb2listw(style="B") %>% listw2sn()

  sparse_coord = spdep::listw2sn(nb2listw(style=style,poly2nb(foo_spdf), ...))


  if(is.null(dir_out)==TRUE){

    return(sparse_coord)

  } else {
    # write to disk
    write.csv(sparse_coord,
              file=paste0(dir_out,"/coord_rep_nb_list.txt"),
              row.names = FALSE)
    message(paste0('wrote to disk at: ',paste0(dir_out,"/coord_rep_nb_list.txt")))
    }
}
