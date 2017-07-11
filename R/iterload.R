#' The iterload() helper function to easily read in .rds files output from itersave()
#'
#' @param dir_rds path of directory containing .rds files
#'
#' @return a list resulting from lapply(.,FUN=readRDS)
#' @export
#'
#' @examples
iterload = function(dir_rds){

  # dir_rds = '~/projects/datzen/tests/proto/temp/dump_1/'

  names_arg = list.files(dir_rds,pattern = '.rds',full.names = FALSE) %>%
    gsub(.,pattern='.rds',replacement='')

  list_rds = list.files(dir_rds,pattern = '.rds',full.names = TRUE)
  list_read = lapply(list_rds,FUN=readRDS)

  names(list_read) = names_arg
  list_out = list_read

  return(list_read)
  }

# dir_rds = '~/projects/datzen/tests/proto/temp/dump_1/'
# out = iterload(dir_rds=dir_rds)
# str(out)

#
# library(datzen)
#
# foo_func_spec = function(x){return(log(x))}
#
# mainDir = '~/projects/datzen/tests/proto/temp/'
# subDir = '/dump_1/'
# subSubDir = '/failed/'
#
# arg_vec_spec = 1:10
# # using arg vector index as suffix
# names(arg_vec_spec) = paste0('arg_foo',seq_along(arg_vec_spec))
# # using last 6 digits of arg value as suffix
# names(arg_vec_spec) = paste0('arg_foo',stringr::str_sub(arg_vec_spec,start=-6))
#
# itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
#          mainDir,subDir,subSubDir='/failed/',parallel=FALSE)
#
#
# dir_rds = '~/projects/datzen/tests/proto/temp/dump_1/'
# out = iterload(dir_rds=dir_rds)
# str(out)
#
# # error control
#
# arg_vec_spec = c(letters)
# names(arg_vec_spec) = stringr::str_sub(arg_vec_spec,start=-6)
#
# itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
#          mainDir,subDir,subSubDir='/failed/',parallel=FALSE)
#
#
# dir_rds_failed = '~/projects/datzen/tests/proto/temp/dump_1/failed/'
#
# out_failed = iterload(dir_rds=dir_rds_failed)
# str(out_failed)
#
# transpose(out_failed)$ind_fail
# transpose(out_failed)$bad_input
# transpose(out_failed)$bad_result

########################
# retrying itersave() on failed runs from 'bad_input'
########################


# NOTE: re-assemble named vector for arg_retry
# arg_retry = unlist(transpose(out_failed)$bad_input)
# names(arg_retry) = stringr::str_sub(arg_retry,start=-6)
#
# itersave(func_user=foo_func_spec,vec_arg_func=arg_retry,
#          mainDir,subDir,subSubDir='/failed/',parallel=FALSE)
