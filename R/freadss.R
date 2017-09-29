#' The freadss() function reads in a csv and perhaps subsets the rows (optionally sampled).
#'
#' @seealso \code{\link[data.table]{fread}}
#' @description The input file is read in-memory via \code{\link[data.table]{fread}}.
#' If rows are subset, there is a speed down. Hence, subsetting rows takes on a one-time slow down
#' in order to bean count the read-in memory footprint
#' @param input character for file path of csv passed to \code{\link[data.table]{fread}}
#' @param ss integer for desired row sample size. Default of ss is NULL, meaning no subsampling.
#' @param replace a logical picking with/without-replacement sampling
#' @param ind_choose optional integer vector of specific rows to read in (instead of sampling)
#' @param ... optional args passed to \code{\link[data.table]{fread}}
#'
#' @return a 'data.frame' with optionally subsetted rows (perhaps from sampling)
#' @export
#'
#' @examples
#'
#' set.seed(1)
#' m = matrix(rnorm(1e5),ncol=10)
#' csv = data.frame(x=1:1e4,m)
#'
#' setwd("~/projects/datzen/tests/proto/")
#' write.csv(csv,"test.csv")
#'
#' dir_test = '~/projects/datzen/tests/proto/test.csv'
#'
#' result = freadss(input=dir_test,ss=1000,replace=TRUE,ind_choose=NULL)
#' # sometimes sample drops some row
#'
#' dim(result)
#' head(result)
#'
#' ind_pick = as.integer(50:100)
#' result = freadss(input=dir_test,replace=TRUE,
#'                  ind_choose=ind_pick,
#'                  drop='V12')
#'
#' identical(sort(as.integer(result$V1)),sort(ind_pick))
#'
#' dim(result)
#' head(result)
#' tail(result)
#'
#' # no sub sampling
#' result = freadss(input=dir_test,ss=NULL)
#' dim(result)

freadss = function(input,ss=NULL,replace=TRUE,ind_choose=NULL,...){

  # ss = 100  # samp size
  stopifnot(is.null(ss)||(ss>0))

  require(data.table)

  # other args passed to fread()
  dots = list(...)

  if(is.null(ss)==TRUE){
    args_all = append(input,dots)
    # no subsampling of rows
    return(do.call(fread,args_all))
  }

  # else, subsample rows

  # must know nrow beforehand
  # input = '~/projects/datzen/tests/proto/test.csv'

  num_rows = data.table::fread(paste0('wc -l ',input))[[1]] - 1

  if(is.null(ind_choose)){
    # use ind_samp
    if(num_rows < ss){
      ind_samp = sample(x=(1:nrow(dat_raw)),size=ss,replace=TRUE)
      warning('nrow() less than ss, so will force replace=TRUE')

    } else {
      ind_samp = sample(x=(1:num_rows),size=ss,replace=replace)
    }
    ind_spec = as.integer(ind_samp)
  } else {
    # ind_choose = c(1:50,53, 65,77,90,100:200,350:500, 5000:6000)
    ind_spec = as.integer(ind_choose)
  }


  # probably slightly faster, but storage overhead
  v = rep(FALSE,num_rows)
  v[ind_spec] = TRUE
  # sum(v)

  seq  = rle(v)
  idx  = c(0, cumsum(seq$lengths))[which(seq$values)] + 1

  df_indx = (data.frame(start=as.integer(idx),
                        length=as.integer(seq$length[which(seq$values)])
                        ))

  # str(df_indx)

  result = do.call(rbind,
                   apply(X=df_indx,MARGIN=1,
                         FUN=function(xx){

                           # str(df_indx)
                           # xx = df_indx[1,]



                           args_cust = list(input=input,
                                            nrows=unlist(xx[2]),
                                            skip=unlist(xx[1]))

                           # str(args_cust)
                           # append 'dots' from topmost scope

                           args_all = append(args_cust,dots)
                           # do.call(fread,args_all)

                           return(do.call(fread,args_all))

                         }))

  return(result)
}





########################################
# one line at time is signifig slower
#
#
# freadss = function(input,ss=10,replace=TRUE,ind_choose=NULL,...){
#
#   require(data.table)
#
#   # other args passed to fread()
#   dots = list(...)
#
#   # must know nrow beforehand
#   # input = '~/projects/datzen/tests/proto/test.csv'
#
#   num_rows = data.table::fread(paste0('wc -l ',input))[[1]] - 1
#
#   if(is.null(ind_choose)){
#     # use ind_samp
#     if(num_rows < ss){
#       ind_samp = sample(x=(1:nrow(dat_raw)),size=ss,replace=TRUE)
#       warning('nrow() less than ss, so will force replace=TRUE')
#
#     } else {
#       ind_samp = sample(x=(1:num_rows),size=ss,replace=replace)
#     }
#     ind_spec = as.integer(ind_samp)
#   } else {
#     # ind_choose = c(1:50,53, 65,77,90,100:200,350:500, 5000:6000)
#     ind_spec = as.integer(ind_choose)
#   }
#
#
#   # 1 line at a time version
#
#   result = do.call(rbind,
#                    lapply(X=ind_spec,
#                           FUN=function(xx){
#
#                             # str(df_indx)
#                             # xx = df_indx[1,]
#
#                             # read 1 entry at a time without rle()
#                             # nrows=ind_spec
#                             # skip=1
#
#                             args_cust = list(input=input,
#                                              nrows=1,
#                                              skip=unlist(xx))
#
#                             # str(args_cust)
#                             # append 'dots' from topmost scope
#
#                             args_all = append(args_cust,dots)
#                             # do.call(fread,args_all)
#
#                             return(do.call(fread,args_all))
#
#                           }))
#
#   return(result)
# }
#



# I don't want to be that random! Can you just specifically give me rows 69,23, and 7 ?
#
# ```{r message=FALSE}
# freadss(input=tf,ind_choose=c(69,23,7)) %>% str
# ```
