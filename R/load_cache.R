#' The load_cache() function to load .rdata files from a knitr cache
#' @seealso \code{\link[base]{lazyLoad}}
#'
#' @param dir_cache a single character string for the directory containing the .rdata files
#' @param envir The environment into which objects are loaded. same as \code{\link[base]{lazyLoad}}
#' @param ... optional args passed to \code{\link[base]{lazyLoad}}
#'
#' @return NULL, but the .rdata files are loaded into the global environment
#'
#' @export
#'
#' @examples
#' dir_cache = here::here("/writeup/article_tech_doc_cache/html/")
#' load_cache(dir_cache)
load_cache = function(dir_cache,envir=globalenv(),...){

  files_rdata = gsub(list.files(dir_cache,pattern='.RData'),pattern=".RData",replacement="")

  # files_rdata
  for(i in seq_along(files_rdata)){
    lazyLoad(paste0(dir_cache,files_rdata)[i],envir=envir,...)
    }
}

# dir_cache = here::here("/writeup/article_tech_doc_cache/html/")
# load_cache(dir_cache)
