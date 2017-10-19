# `iterload`: The iterload() helper function to easily read in .rds files

## Description


 The .rds files are expected to be output from from [`itersave`](itersave.html) 
 This is essentially using lapply(list.files(dir_rds),FUN=readRDS)


## Usage

```r
iterload(dir_rds)
```


## Arguments

Argument      |Description
------------- |----------------
```dir_rds```     |     character for path of directory containing .rds files

## Value


 a list storing read in results


## Seealso


 [`itersave`](itersave.html) to see how the .rds files were written


## Examples

```r 
 
 foo_func_spec = function(x){return(log(x))}
 mainDir = '~/projects/datzen/tests/proto/temp/'
 subDir = '/dump_1/'
 subSubDir = '/failed/'
 
 ########################
 # error control
 ########################
 
 arg_vec_spec = c(letters)
 names(arg_vec_spec) = stringr::str_sub(arg_vec_spec,start=-6)
 itersave(func_user=foo_func_spec,vec_arg_func=arg_vec_spec,
 mainDir,subDir,subSubDir='/failed/',parallel=FALSE)
 dir_rds_failed = '~/projects/datzen/tests/proto/temp/dump_1/failed/'
 list.files(dir_rds_failed)
 out_failed = iterload(dir_rds=dir_rds_failed)
 str(out_failed)
 
 purrr::transpose(out_failed)$ind_fail
 purrr::transpose(out_failed)$input_bad
 purrr::transpose(out_failed)$result_bad
 
 ########################
 # retrying itersave() on failed runs from 'input_bad'
 ########################
 
 # NOTE: re-assemble named vector for arg_retry
 arg_bad = unlist(transpose(out_failed)$input_bad)
 # convert letters to its order in alphabet
 arg_retry = seq_along(letters)
 names(arg_retry) = stringr::str_sub(arg_bad,start=-6)
 
 itersave(func_user=foo_func_spec,vec_arg_func=arg_retry,
 mainDir,subDir,subSubDir='/failed/',parallel=FALSE)
 
 dir_retry = '~/projects/datzen/tests/proto/temp///dump_1/'
 out_failed = iterload(dir_rds=dir_retry)
 str(out_failed)
 ``` 

