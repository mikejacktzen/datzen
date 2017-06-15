#' The itersave() function to iteratively run-then-write (to .rds) the output of a user supplied function
#'
#' @description
#' The user supplied function, in the argument 'func_user', is expected to return an object that itersave() can further save physically.
#' So, itersave() will write a physical .rds file to the user specified directory.
#' The name of the physical file will use the values of 'vec_arg_func' as the filename. eg if vec_arg_func[[i]]='foo', then the physical file is 'foo.rds'
#' Note: itersave() uses purrr::safely() with if-else to handle errors.
#'
#' @param func_user a user supplied function taking in a simple argument of one-element
#' @param vec_arg_func a vector whose elements will be iteratively used as arguments in func_user
#' @param mainDir parent directory to write output to
#' @param subDir sub directory to write good results to
#' @param subSubDir sub sub directory to write bad results to
#' @param beg integer to begin iteration. Defaults to 1
#' @param end integer to end iteration. Defaults to length(vec_arg_func)
#' @param parallel logical to use library(doParallel) backend. Defaults to FALSE
#'
#' @return NULL
#' @export
#'
#' @examples
#'
#'  foo_func_spec = function(x){return(log(x))}
#'
#'  mainDir = '~/projects/datzen/tests/proto/temp/'
#'  subDir = '/dump_1/'
#'  subSubDir = '/failed/'
#'
#'  arg_vec_spec = 1:10
#'  itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
#'           mainDir,subDir,subSubDir='/failed/',parallel=FALSE)
#'
#'  list.files('~/projects/datzen/tests/proto/temp/dump_1/')
#'  out=readRDS('~/projects/datzen/tests/proto/temp/dump_1/10.rds')
#'  identical(out,log(10))
#'  out=readRDS('~/projects/datzen/tests/proto/temp/dump_1/1.rds')
#'  identical(out,log(1))
#'
#'  # error control
#'  arg_vec_spec = 'a'
#'  itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
#'           mainDir,subDir,subSubDir='/failed/',parallel=FALSE)
#'
#'  out=readRDS('~/projects/datzen/tests/proto/temp/dump_1/failed/a.rds')


itersave = function(func_user,vec_arg_func,
                    mainDir,subDir,subSubDir='/failed/',
                    beg=1,end=length(vec_arg_func),parallel=FALSE){

  # # args
  # mainDir = '~/projects/datzen/tests/proto/temp/'
  # subDir = '/dump_1/'
  # subSubDir = '/failed/'
  #
  # foo_func_i_spec = func_user
  # arg_vec = vec_arg_func  # a chrc vec


  ####################################
  # setup output directory
  ####################################

  ifelse(!dir.exists(file.path(mainDir, subDir)),
         dir.create(file.path(mainDir, subDir)),
         FALSE)

  ifelse(!dir.exists(file.path(mainDir,subDir,subSubDir)),
         dir.create(file.path(mainDir,subDir,subSubDir)),
         FALSE)

  ####################################
  # safely func
  # for continuition when error
  ####################################

  safe_foo_func = purrr::safely(func_user,quiet=FALSE)

  # safe_foo_func(arg_vec[[1]])
  # safe_foo_func(arg_vec[[100]])

  # dopar for general purpose parallel for loop
  # maybe switch to library(future) when stable

  ####################################
  # save func based on ifelse error
  ####################################
  arg_vec = vec_arg_func

  save_result_foo = function(i){

    # assume avail in env
    # safe_foo_func
    # arg_vec

    # tell to look in env one level up

    # i=1
    # print(paste0('iter: ',i))
    # print(date())
    # print(paste0('arg: ',arg_vec[i]))

    arg_i = arg_vec[i]


    result_safe = safe_foo_func(arg_vec[[i]])

    # check for error
    ok = is_null(result_safe$error)  # true if error is null (eg ok)

    # good/bad ifelse:

    if(ok==TRUE){
      # good
      good_result = result_safe$result

      saveRDS(good_result,
              file=paste0(paste0(mainDir,subDir),
                          "/",arg_i,".rds")
      )

    } else {

      # bad
      bad_result = result_safe$error

      failed = list(ind_fail=i,
                    bad_input=arg_vec[[i]],
                    bad_result=bad_result)

      saveRDS(failed,
              file=paste0(paste0(mainDir,subDir,subSubDir),
                          "/",arg_i,".rds")
      )
    }

  }



  library(doParallel)

  # if(parallel==TRUE){
  # detectCores()
  # foreach(j=beg:end) %dopar% save_result_foo(j)
  # } else {

  # func_safe = purrr::safely(rl_batch_j)
  # beg=1;end=length(vec_arg_func)

  foreach(j=beg:end) %do% save_result_foo(j)

}



# args for user facing func

# arg_vec_spec = 'a'
# arg_vec_spec = 1:10
#
#
# foo_func_spec = function(x){
#   return(log(x))
# }
#
#
# mainDir = '~/projects/datzen/tests/proto/temp/'
# subDir = '/dump_1/'
# subSubDir = '/failed/'
#
# itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
#          mainDir,subDir,subSubDir='/failed/',
#          parallel=FALSE)
#
#
# list.files('~/projects/datzen/tests/proto/temp/dump_1/')
#
# out=readRDS('~/projects/datzen/tests/proto/temp/dump_1/failed/a.rds')
#
# out=readRDS('~/projects/datzen/tests/proto/temp/dump_1/10.rds')
# identical(out,log(10))
#
# out=readRDS('~/projects/datzen/tests/proto/temp/dump_1/1.rds')
# identical(out,log(1))
