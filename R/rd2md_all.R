#' The rd2md_all() function to batch convert rd files to html files
#'
#' @description uses the Rd2md::Rd2markdown function inside base::lapply
#'
#' @param dir_man_rd a character string for the directory containing .rd files
#' @param dir_man_md a character string for the directory to output .md files
#'
#' @return nothing is returned, but external .md files are written to dir_man_md
#' @export
#'
#' @seealso \code{\link[Rd2md]{Rd2markdown}}
#'
#' @examples
#'
rd2md_all = function(dir_man_rd,dir_man_md){

  dir_man_rd = "~/projects/datzen/man/"
  dir_man_md = "~/projects/datzen/man_md/"

  Rds = list.files(paste0(dir_man_rd),pattern=".Rd")

  invisible(lapply(Rds,FUN=function(Rd_one){
    # xx=1
    # paste0(dir_man,Rds[xx])
    # Rd_one = Rds[[1]]

    in_rd = paste0(dir_man_rd,Rd_one)

    dir_man_md = "~/projects/datzen/man_md/"
    out_md = gsub(paste0(dir_man_md,Rd_one),pattern=".Rd",replacement=".md")

    Rd2md::Rd2markdown(rdfile=in_rd, outfile=out_md, append = FALSE)


    # tools::Rd2HTML(Rd=in_rd, out=out_html)
  }))
  message(paste('writing .md files into',dir_man_md))
}
