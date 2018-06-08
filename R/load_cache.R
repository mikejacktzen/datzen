#' The load_cache() function to load .rdata files from a knitr cache
#'
#' @param dir_cache a single character string for the directory containing the .rdata files
#'
#' @return NULL, but the .rdata files are loaded into the global environment
#'
#' @export
#'
#' @examples
#' dir_cache = here::here("/writeup/article_tech_doc_cache/html/")
#' load_cache(dir_cache)
load_cache = function(dir_cache){
  files_rdata = list.files(dir_cache,pattern='.RData') %>%
    gsub(.,pattern=".RData",replacement="")

  # files_rdata
  for(i in seq_along(files_rdata)){
    lazyLoad(paste0(dir_cache,files_rdata)[i])
    }
}

# dir_cache = here::here("/writeup/article_tech_doc_cache/html/")
# load_cache(dir_cache)
