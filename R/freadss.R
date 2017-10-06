#' The freadss() function reads in a csv and perhaps subsets the rows (optionally sampled).
#'
#' @seealso \code{\link[data.table]{fread}}
#' @description The input file is read in-memory via \code{\link[data.table]{fread}}.
#' If rows are subset, there is a slow down. Hence, subsetting rows costs a one-time slow down
#' but affords ability to bean count the read-in memory footprint
#'
#' @details NOTE: if both ss and ind_choose are NULL, no subsetting is done. Entire csv is read in.
#'
#' @param input character for file path of csv passed to \code{\link[data.table]{fread}}
#' @param ss integer for desired row sample size. Default of ss is NULL, meaning no subsampling.
#' @param replace a logical picking with/without-replacement sampling
#' @param ind_choose optional integer vector of specific rows to read in (instead of sampling)
#'
#' @return a 'data.frame' with optionally subsetted rows (perhaps from sampling)
#' @export
#'
#' @examples
#'
#' set.seed(1); m = matrix(rnorm(10*100),ncol=100,nrow=100)
#'
#' csv = data.frame(m)
#' names(csv) = paste0('x',seq_along(csv))
#' names(csv)
#'
#' tf = tempfile()
#' write.csv(csv,tf,row.names=FALSE)
#' dir_test=tf
#'
#' # if ss=NULL and ind_choose=NULL
#' # no sub sampling, basically fread() but no flexible optional args.
#' # just demo, might as well use fread() directly
#'
#' identical(freadss(input=dir_test),fread(dir_test))
#'
#' # user wants to sample 5 random rows
#' freadss(input=dir_test,ss=5)
#'
#' # user picks 5 specific rows
#' ind_pick = c(1,7,23,69,100)
#'
#' df_subset_before = freadss(input=dir_test,ind_choose = ind_pick)
#' df_subset_after = freadss(input=dir_test)[ind_pick,]
#' identical(df_subset_before,df_subset_after)
#'


# disabled optional ... args passed to fread()
# eg drop/keep bugs out since issue of original header name lost during do.call(fread,list_ss)

freadss = function(input,ss=NULL,replace=TRUE,ind_choose=NULL){

  # ss = 100  # samp size
  # ind_choose=ind_pick

  # negative ss

  # ss and ind_choose non null
  if((!is.null(ss))&&(!is.null(ind_choose))){stop('you can not have BOTH non-null ss and ind_choose')}


  require(data.table)

  # other args passed to fread()
  # dots = list(...)

  if((is.null(ss)&&is.null(ind_choose))==TRUE){
    # no subsampling of rows
    return(fread(input))
  }

  # else, subsample rows

  # must know nrow beforehand
  # input = '~/projects/datzen/tests/proto/test.csv'

  num_rows = data.table::fread(paste0('wc -l ',input))[[1]] - 1
  name_header_orig = names(fread(input,nrows=0))

  # row index random sampled
  if(is.null(ind_choose)&&(!is.null(ss))){

    if(ss <= 0){stop('ss must be NULL or greater than 0')}

    # use ind_samp
    if(num_rows < ss){
      ind_samp = sample(x=(1:nrow(dat_raw)),size=ss,replace=TRUE)
      warning('nrow() less than ss, so will force replace=TRUE')

    } else {
      ind_samp = sample(x=(1:num_rows),size=ss,replace=replace)
    }
    ind_spec = as.integer(ind_samp)
  }

  # row index user specified
  if(!is.null(ind_choose)&&(is.null(ss))){
    ind_spec = as.integer(ind_choose)
  }


  # probably slightly faster, but storage overhead
  v = rep(FALSE,num_rows)
  v[ind_spec] = TRUE
  # sum(v)
  # v <- (1:num_rows %in% ind_spec)

  seq  = rle(v)
  idx  = c(0, cumsum(seq$lengths))[which(seq$values)] + 1
  df_indx = data.frame(start=idx, length=seq$length[which(seq$values)])
  # str(df_indx)

  result = do.call(rbind,apply(df_indx,1, function(x) return(fread(input,nrows=x[2],skip=x[1]))))

  names(result) = name_header_orig

  # revisit drop keep optional args
  # names(result) = name_header_orig[!(name_header_orig %in% drop)]

  return(result)
}



########################################
#
#
# result = do.call(rbind,
#                  apply(X=df_indx,MARGIN=1,
#                        FUN=function(xx){
#
#                          # str(df_indx)
#                          # xx = df_indx[1,]
#
#
#                          # internal do.call(fread,X[[i]])
#                          # will chop off first global row (true header)
#                          # and following rows will be auto renamed to use V1 etc
#                          # behavior of fread()
#
#                          args_cust = list(input,
#                                           # header=FALSE,
#                                           nrows=unlist(xx[2]),
#                                           skip=unlist(xx[1])
#                          )
#
#                          # str(args_cust)
#
#                          # append 'dots' from topmost scope
#                          # args_all = append(args_cust,dots)
#
#                          args_all = args_cust
#
#
#                          return(do.call(fread,args_all))
#
#                        }))
#
#
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
