#' The iterload() helper function to easily read in .rds files
#'
#' @description
#' The .rds files are expected to be output from from \code{\link[datzen]{itersave}}
#' This is essentially using lapply(list.files(dir_rds),FUN=readRDS)
#'
#' @param dir_rds character for path of directory containing .rds files
#'
#' @return a list storing read in results
#' @seealso \code{\link[datzen]{itersave}} to see how the .rds files were written
#' @export
#'
#' @examples
#'
#' foo_func_spec = function(x){return(log(x))}
#' mainDir = '~/projects/datzen/tests/proto/temp/'
#' subDir = '/dump_1/'
#' subSubDir = '/failed/'
#'
#' ########################
#' # error control
#' ########################
#'
#' arg_vec_spec = c(letters)
#' names(arg_vec_spec) = stringr::str_sub(arg_vec_spec,start=-6)
#' itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
#'          mainDir,subDir,subSubDir='/failed/',parallel=FALSE)
#' dir_rds_failed = '~/projects/datzen/tests/proto/temp/dump_1/failed/'
#' list.files(dir_rds_failed)
#' out_failed = iterload(dir_rds=dir_rds_failed)
#' str(out_failed)
#'
#' purrr::transpose(out_failed)$ind_fail
#' purrr::transpose(out_failed)$input_bad
#' purrr::transpose(out_failed)$result_bad
#'
#' ########################
#' # retrying itersave() on failed runs from 'input_bad'
#' ########################
#'
#' # NOTE: re-assemble named vector for arg_retry
#' arg_bad = unlist(transpose(out_failed)$input_bad)
#' # convert letters to its order in alphabet
#' arg_retry = seq_along(letters)
#' names(arg_retry) = stringr::str_sub(arg_bad,start=-6)
#'
#' itersave(func_user=foo_func_spec,vec_arg_func=arg_retry,
#'          mainDir,subDir,subSubDir='/failed/',parallel=FALSE)
#'
#' dir_retry = '~/projects/datzen/tests/proto/temp///dump_1/'
#' out_failed = iterload(dir_rds=dir_retry)
#' str(out_failed)


iterload = function(dir_rds){

  stopifnot(is.character(dir_rds))


  # dir_rds = '~/projects/datzen/tests/proto/temp/dump_1/'
  message(paste0('looking in: ',dir_rds))

  names_arg = list.files(dir_rds,pattern = '.rds',full.names = FALSE) %>%
    gsub(.,pattern='.rds',replacement='')

  list_rds = list.files(dir_rds,pattern = '.rds',full.names = TRUE)
  list_read = lapply(list_rds,FUN=readRDS)

  names(list_read) = names_arg
  list_out = list_read

  return(list_read)
}
