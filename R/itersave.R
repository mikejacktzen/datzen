#' The itersave() function to iteratively run-then-write (to .rds) the output of a user supplied function
#'
#' @description
#' The user supplied function, in the argument 'func_user', is expected to return an object that itersave() can further save physically.
#' So, itersave() will write a physical .rds file to the user specified directory.
#' The name of the physical file will use the elements' names in the named vector 'vec_arg_func' as the filename. eg if names(vec_arg_func[[i]])='foo', then the physical file is 'foo.rds'
#' Note: itersave() uses purrr::safely() with if-else to handle errors.
#'
#' @param func_user a user supplied function taking in a simple argument of one-element
#' @param vec_arg_func a named vector whose elements' value will be iteratively used as arguments in func_user.
#' Further, the vector elements' name will be used as the .rds filename.
#' @param mainDir parent directory to write output to
#' @param subDir sub directory to write good results to
#' @param subSubDir sub sub directory to write bad results to
#' @param beg integer to begin iteration. Defaults to 1
#' @param end integer to end iteration. Defaults to length(vec_arg_func)
#' @param parallel logical to use library(doParallel) backend. Defaults to FALSE
#' @param timeout a numeric (default Inf) specifying the maximum number of seconds the expression
#' is allowed to run before being interrupted by the timeout. Passed to \code{\link[R.utils]{withTimeout}}
#'
#' @return NULL
#' @seealso \code{\link[datzen]{iterload}} to easily load files written by itersave
#' @export
#'
#' @examples
#'
#' ## NOTE: Must name arg_vec_spec
#' ## using arg vector index as suffix
#' # names(arg_vec_spec) = paste0('arg_foo',seq_along(arg_vec_spec))
#' ## using last 6 digits of arg value as suffix
#' # names(arg_vec_spec) = paste0('arg_foo',stringr::str_sub(arg_vec_spec,start=-6))
#' ## left pad with 0 via nchar digits of arg length
#' # names(arg_vec_spec) = paste0('arg_',
#' #                              str_pad(seq_along(arg_vec_spec),
#' #                                      width=nchar(length(arg_vec_spec)),
#' #                                      side="left", pad="0"))
#'
#' ##################
#' # success
#' ##################
#' arg_vec_spec = 1:10
#' names(arg_vec_spec) = paste0('arg_foo',seq_along(arg_vec_spec))
#' foo_func_spec = function(x){return(log(x))}
#'
#' mainDir = '~/projects/datzen/tests/proto/temp/'
#' subDir = '/dump_1_perfect/'
#' subSubDir = '/failed_perfect/'
#'
#' itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
#'          mainDir,subDir,subSubDir=subSubDir,parallel=FALSE)
#'
#' # good files
#' list.files(paste0(mainDir,subDir),full.names = TRUE)
#' out=datzen::iterload(paste0(mainDir,subDir))
#' str(out)
#'
#' # bad files none
#' list.files(paste0(mainDir,subDir,subSubDir),full.names = TRUE)
#'
#' ##################
#' # failure from argument bad
#' ##################
#' arg_vec_spec = letters
#' names(arg_vec_spec) = paste0('arg_foo',seq_along(arg_vec_spec))
#' foo_func_spec = function(x){return(log(x))}
#'
#' subDir = '/dump_1_argbad/'
#' subSubDir = '/failed_argbad/'
#'
#' itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
#'          mainDir,subDir,subSubDir=subSubDir,parallel=FALSE)
#'
#' # good files none
#' list.files(paste0(mainDir,subDir),full.names = TRUE)
#'
#' # bad files
#' list.files(paste0(mainDir,subDir,subSubDir),full.names = TRUE)
#' out=iterload(paste0(mainDir,subDir,subSubDir))
#' str(out)
#'
#' ##################
#' # failure due to timeout
#' ##################
#'
#' # arg is good
#' arg_vec_spec = 1:10
#' names(arg_vec_spec) = paste0('arg_foo',seq_along(arg_vec_spec))
#'
#' foo_func_spec = function(x){
#'   wait=sample(c(0,2.0),1); # 0 or 2 second
#'   Sys.sleep(wait);
#'   return(log(x))}
#'
#' subDir = '/dump_1_timeout/'
#' subSubDir = '/failed_timeout/'
#'
#' # timeout at 1 second
#' itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
#'          mainDir=mainDir,subDir=subDir,subSubDir=subSubDir,parallel=FALSE,
#'          timeout=1.0)
#'
#' # good files some
#' list.files(paste0(mainDir,subDir),full.names = TRUE)
#' out=datzen::iterload(paste0(mainDir,subDir))
#' str(out)
#'
#' # bad files some
#' list.files(paste0(mainDir,subDir,subSubDir),full.names = TRUE)
#' out=datzen::iterload(paste0(mainDir,subDir,subSubDir))
#' str(out)
#'
#' ##################
#' # re run failed args
#' # see ?iterload()
#' ##################
#'
#' list.files(paste0(mainDir,subDir,subSubDir),full.names = TRUE)
#' out=datzen::iterload(paste0(mainDir,subDir,subSubDir))
#' str(out)
#'
#' transpose(out)$ind_fail
#' transpose(out)$input_bad
#'
#' # these examples timed out due to
#' # random sample of wait time exceeding 2.0
#'
#' foo_func_spec = function(x){
#'   # wait=sample(c(0,2.0),1); # 0 or 2 second
#'   # Sys.sleep(wait);
#'   return(log(x))}
#'
#' arg_redo = unlist(transpose(out)$input_bad)
#' names(arg_redo)
#' arg_vec_spec = arg_redo
#'
#' subDir = '/dump_1_redo/'
#' subSubDir = '/failed_redo/'
#'
#' itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
#'          mainDir=mainDir,subDir=subDir,subSubDir=subSubDir,parallel=FALSE,
#'          timeout=1.0)
#'
#' # good files all
#' list.files(paste0(mainDir,subDir),full.names = TRUE)
#' out=datzen::iterload(paste0(mainDir,subDir))
#' str(out)
#' names(arg_redo)
#'
#' # bad files none
#' list.files(paste0(mainDir,subDir,subSubDir),full.names = TRUE)

itersave = function(func_user,vec_arg_func,
                    mainDir,subDir,subSubDir='/failed/',
                    beg=1,end=length(vec_arg_func),
                    parallel=FALSE,
                    timeout=Inf){

  require(purrr)
  require(stringr)
  require(R.utils)


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

  print(paste0('saving successful .rds in: ',file.path(mainDir, subDir)))

  ifelse(!dir.exists(file.path(mainDir,subDir,subSubDir)),
         dir.create(file.path(mainDir,subDir,subSubDir)),
         FALSE)

  print(paste0('saving failed .rds in: ',file.path(mainDir, subDir,subSubDir)))

  ####################################
  # optional consider adding timeout error
  ####################################

  # func_user = function(x){Sys.sleep(2.0);return(log(x))}
  # timeout=Inf

  func_timeout = function(...){R.utils::withTimeout(func_user(...),timeout=timeout)}

  # func_timeout(10)


  ####################################
  # safely func
  # for continuition when error
  ####################################

  safe_foo_func = purrr::safely(func_timeout,quiet=FALSE)

  # safe_foo_func = purrr::safely(func_user,quiet=FALSE)

  # safe_foo_func(arg_vec[[1]])
  # safe_foo_func(arg_vec[[100]])

  # dopar for general purpose parallel for loop
  # maybe switch to library(future) when stable

  ####################################
  # save func based on ifelse error
  ####################################

  # # using vector index as suffix
  # names(vec_arg_func) = paste0('arg_foo',seq_along(vec_arg_func))
  # # using last 6 digits of arg value as suffix
  # names(vec_arg_func) = paste0('arg_foo',str_sub(vec_arg_func,start=-6))


  if(is.null(names(vec_arg_func))){
    stop("\n
         Please use a named vector for vec_arg_func. Some examples are: \n
         # using arg vector index as suffix \n
         names(vec_arg_func) = paste0('arg_foo',seq_along(vec_arg_func)) \n
         # using last 6 digits of arg value as suffix \n
         names(vec_arg_func) = paste0('arg_foo',stringr::str_sub(vec_arg_func,start=-6))"
         )
  }


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

    print(names(arg_i))


    result_safe = safe_foo_func(arg_vec[[i]])

    # check for error
    ok = is_null(result_safe$error)  # true if error is null (eg ok)

    # good/bad ifelse:

    if(ok==TRUE){
      # good
      result_good = result_safe$result

      # names(arg_i) instead of arg_i

      saveRDS(result_good,
              file=paste0(paste0(mainDir,subDir),
                          "/",names(arg_i),".rds")
      )

    } else {

      # bad
      result_bad = result_safe$error

      failed = list(ind_fail=i,
                    input_bad=arg_vec[[i]],
                    result_bad=result_bad)

      # names(arg_i) instead of arg_i

      saveRDS(failed,
              file=paste0(paste0(mainDir,subDir,subSubDir),
                          "/",names(arg_i),".rds")
      )
    }

  }


  require(doParallel)

  # if(parallel==TRUE){
  # detectCores()
  # foreach(j=beg:end) %dopar% save_result_foo(j)
  # } else {

  # func_safe = purrr::safely(rl_batch_j)
  # beg=1;end=length(vec_arg_func)

  # shows a list of NULL
  # (expected, since only sideffect desired)
  # foreach(j=beg:end) %do% save_result_foo(j)

  # invisible() to hide the returned list of NULL
  # a behavior of foreach()
  invisible(foreach(j=beg:end) %do% save_result_foo(j))

}



