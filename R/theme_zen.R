#####################
# ggplot2 custom theme
# http://stackoverflow.com/questions/27400931/how-to-make-a-default-custom-theme-with-ggplot2-in-r
#####################

#' @title The theme_zen() function is a theme for ggplot2
#'
#' @return NULL
#' @export
#'
#' @examples
#' ggplot2::qplot(mpg, wt, data = mtcars)
#' ggplot2::qplot(mpg, wt, data = mtcars) + theme_zen()

theme_zen = function(){
  require('ggplot2')

  #   xlab('Foo X') +
  #     ylab("Foo Y") +
  #     ggtitle("Foo Title") +
  #     labs(colour="Foo Legend") +

  theme_bw() +
    theme(legend.direction = "horizontal",
          legend.position = "top",
          legend.box = "horizontal",
          # axis.text=element_text(size=12),
          axis.title=element_text(size=14,face="bold"),
          plot.title=element_text(size=20,face="bold")
    )
}
