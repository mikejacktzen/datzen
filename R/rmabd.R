#' The rmabd() function removes 'all but deeze' objects
#'
#' @param list_keep an optional list of names for objects to keep from '?rm()'.
#' The default 'list_keep=NULL' will remove all objects.
#' @param envir an optional environment. Defaults to '?globalenv()'.
#'
#' @return nothing but a message will be printed for the kept objects
#' @export
#'
#' @examples
# x1 = 1
# x2 = 2
# x3 = 3
#' ls()
# rmabd(list_keep=list('x1','x2'))
#' ls()
#' rmabd()

rmabd = function(list_keep=NULL,envir=globalenv()){

  # default: remove all
  # list_keep = NULL

  # default: global env
  # envir=globalenv()

  rm(list=ls(envir=envir)[!(ls(envir=envir) %in% unlist(list_keep))],
     envir=envir)

  message('kept: ',paste(as.character(ls(envir=envir)),collapse=' '))
}



