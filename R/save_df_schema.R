#' The save_df_schema() function
#'
#' @param x a data.frame whose metadata will be used as a validating schema
#' @param outdir a character designating the output filepath
#' @param ... optional arguments
#'
#' @return NULL but a physical .json file is written to disk
#' @export
#'
#' @examples
#' iris2=cbind(iris,Species_chr=as.character(iris$Species))
#' save_df_schema(x=iris2)
#' jsonlite::read_json('~/projects/datzen/tests/iris2_schema.json',simplifyVector = TRUE)

save_df_schema = function(x,
                          outdir=getwd(),...){

  require(jsonlite)

  class_col = lapply(X=x[0,],FUN=class)
  names_col = names(x[0,])

  schema = as.data.frame(cbind(indx_col=seq_along(names_col),names_col,class_col))

  # more assertions
  # chr length
  # number of factor levels

  row.names(schema) = NULL

  name_outfile = paste0(deparse(substitute(x)),"_schema.json")

  message("saved as: ",paste0(outdir,'/',name_outfile))

  write_json(x=schema,path=paste0(outdir,'/',name_outfile))
}


# save_df_schema(x=iris,outdir='~/projects/datzen/tests/')
#
# setwd('~/projects/datzen/tests/')
#
# save_df_schema(x=iris)
# read_json('~/projects/datzen/tests/iris_schema.json',simplifyVector = TRUE)
#
# save_df_schema(x=cars)
# read_json('~/projects/datzen/tests/cars_schema.json',simplifyVector = TRUE)
#
# iris2=cbind(iris,Species_chr=as.character(iris$Species))
# save_df_schema(x=iris2)
# read_json('~/projects/datzen/tests/iris2_schema.json',simplifyVector = TRUE)
