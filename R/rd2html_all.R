#' The rd2html_all() function to batch convert rd files to html files
#'
#' @description uses the tools::Rd2HTML function inside base::lapply
#'
#' @param dir_man_rd a character string for the directory containing .rd files
#' @param dir_man_html a character string for the directory to output .html files
#'
#' @return nothing is returned, but external .html files are written to dir_man_html
#' @export
#'
#' @seealso \code{\link[tools]{Rd2HTML}}
#'
#' @examples
#'
rd2html_all = function(dir_man_rd,dir_man_html){

  # dir_man_rd = "~/projects/datzen/man/"
  # dir_man_html = "~/projects/datzen/man_html/"

  Rds = list.files(paste0(dir_man_rd),pattern=".Rd")

  invisible(lapply(Rds,FUN=function(Rd_one){
    # xx=1
    # paste0(dir_man,Rds[xx])
    # Rd = Rds[[1]]

    in_rd = paste0(dir_man_rd,Rd_one)
    dir_man_html = "~/projects/datzen/man_html/"
    out_html = gsub(paste0(dir_man_html,Rd_one),pattern=".Rd",replacement=".html")
    tools::Rd2HTML(Rd=in_rd, out=out_html)
  }))
  message(paste('writing htmls into',dir_man_html))
}
