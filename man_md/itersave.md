# `itersave`: The itersave() function to iteratively run-then-write (to .rds) the output of a user supplied function

## Description


 The user supplied function, in the argument 'func_user', is expected to return an object that itersave() can further save physically.
 So, itersave() will write a physical .rds file to the user specified directory.
 The name of the physical file will use the elements' names in the named vector 'vec_arg_func' as the filename.
 eg if names(vec_arg_func[[i]])='foo', then the physical file is 'foo.rds'
 Note: itersave() uses purrr::safely() with if-else to handle errors.


## Usage

```r
itersave(func_user, vec_arg_func, mainDir, subDir, subSubDir = "/failed/",
  first = 1, last = length(vec_arg_func), parallel = FALSE,
  timeout = Inf, prog_iter = TRUE, ts = TRUE, walk = FALSE, ...)
```


## Arguments

Argument      |Description
------------- |----------------
```func_user```     |     a user supplied function taking in a simple argument of one-element
```vec_arg_func```     |     a named vector whose elements' value will be iteratively used as arguments in func_user. Further, the vector elements' name will be used as the .rds filename.
```mainDir```     |     parent directory to write output to
```subDir```     |     sub directory to write good results to
```subSubDir```     |     sub sub directory to write bad results to
```first```     |     integer to start iteration. Defaults to 1
```last```     |     integer to end iteration. Defaults to length(vec_arg_func)
```parallel```     |     logical to use library(doParallel) back end. Defaults to FALSE
```timeout```     |     a numeric (default Inf) specifying the maximum number of seconds the expression is allowed to run before being interrupted by the timeout. Passed to [`withTimeout`](withTimeout.html)
```prog_iter```     |     a logical (default TRUE) if the 'i of last' progress should be printed for each iteration.
```ts```     |     a logical (default TRUE) if the timestamp should be printed for each iteration.
```walk```     |     logical (default FALSE). If TRUE, then saveRDS() is not ran for successful iterations.
```...```     |     extra NAMED arguments passed to func_user via do.call(func_user),args=...)

## Seealso


 [`iterload`](iterload.html) to easily load files written by itersave


## Examples

```r 
 
 ## NOTE: Must name arg_vec_spec
 ## using arg vector index as suffix
 # names(arg_vec_spec) = paste0('arg_foo',seq_along(arg_vec_spec))
 ## using last 6 digits of arg value as suffix
 # names(arg_vec_spec) = paste0('arg_foo',stringr::str_sub(arg_vec_spec,start=-6))
 ## left pad with 0 via nchar digits of arg length
 # names(arg_vec_spec) = paste0('arg_',
 #                              str_pad(seq_along(arg_vec_spec),
 #                                      width=nchar(length(arg_vec_spec)),
 #                                      side="left", pad="0"))
 
 ##################
 # success
 ##################
 arg_vec_spec = 1:10
 names(arg_vec_spec) = paste0('arg_foo',seq_along(arg_vec_spec))
 foo_func_spec = function(x){return(log(x))}
 
 mainDir = '~/projects/datzen/tests/proto/temp/'
 subDir = '/dump_1_perfect/'
 subSubDir = '/failed_perfect/'
 
 itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
 mainDir,subDir,subSubDir=subSubDir,parallel=FALSE)
 
 # good files
 list.files(paste0(mainDir,subDir),full.names = TRUE)
 out=datzen::iterload(paste0(mainDir,subDir))
 str(out)
 
 # bad files none
 list.files(paste0(mainDir,subDir,subSubDir),full.names = TRUE)
 
 ##################
 # failure from argument bad
 ##################
 arg_vec_spec = letters
 names(arg_vec_spec) = paste0('arg_foo',seq_along(arg_vec_spec))
 foo_func_spec = function(x){return(log(x))}
 
 subDir = '/dump_1_argbad/'
 subSubDir = '/failed_argbad/'
 
 itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
 mainDir,subDir,subSubDir=subSubDir,parallel=FALSE)
 
 # good files none
 list.files(paste0(mainDir,subDir),full.names = TRUE)
 
 # bad files
 list.files(paste0(mainDir,subDir,subSubDir),full.names = TRUE)
 out=iterload(paste0(mainDir,subDir,subSubDir))
 str(out)
 
 ##################
 # failure due to timeout
 ##################
 
 # arg is good
 arg_vec_spec = 1:10
 names(arg_vec_spec) = paste0('arg_foo',seq_along(arg_vec_spec))
 
 foo_func_spec = function(x){
 wait=sample(c(0,2.0),1); # 0 or 2 second
 Sys.sleep(wait);
 return(log(x))}
 
 subDir = '/dump_1_timeout/'
 subSubDir = '/failed_timeout/'
 
 # timeout at 1 second
 itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
 mainDir=mainDir,subDir=subDir,subSubDir=subSubDir,parallel=FALSE,
 timeout=1.0)
 
 # good files some
 list.files(paste0(mainDir,subDir),full.names = TRUE)
 out=datzen::iterload(paste0(mainDir,subDir))
 str(out)
 
 # bad files some
 list.files(paste0(mainDir,subDir,subSubDir),full.names = TRUE)
 out=datzen::iterload(paste0(mainDir,subDir,subSubDir))
 str(out)
 
 ##################
 # re run failed args
 # see ?iterload()
 ##################
 
 list.files(paste0(mainDir,subDir,subSubDir),full.names = TRUE)
 out=datzen::iterload(paste0(mainDir,subDir,subSubDir))
 str(out)
 
 transpose(out)$ind_fail
 transpose(out)$input_bad
 
 # these examples timed out due to
 # random sample of wait time exceeding 2.0
 
 foo_func_spec = function(x){
 # wait=sample(c(0,2.0),1); # 0 or 2 second
 # Sys.sleep(wait);
 return(log(x))}
 
 arg_redo = unlist(transpose(out)$input_bad)
 names(arg_redo)
 arg_vec_spec = arg_redo
 
 subDir = '/dump_1_redo/'
 subSubDir = '/failed_redo/'
 
 itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
 mainDir=mainDir,subDir=subDir,subSubDir=subSubDir,parallel=FALSE,
 timeout=1.0)
 
 # good files all
 list.files(paste0(mainDir,subDir),full.names = TRUE)
 out=datzen::iterload(paste0(mainDir,subDir))
 str(out)
 names(arg_redo)
 
 # bad files none
 list.files(paste0(mainDir,subDir,subSubDir),full.names = TRUE)
 ``` 

