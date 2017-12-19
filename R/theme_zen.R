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
          axis.title=element_text(size=14,face="bold"),
          plot.title=element_text(size=20,face="bold",hjust = 0.5)
    ) +
    theme(
      panel.background = element_rect(fill = "transparent") # bg of the panel
      , plot.background = element_rect(fill = "transparent") # bg of the plot
      , panel.grid.major = element_blank() # get rid of major grid
      , panel.grid.minor = element_blank() # get rid of minor grid
      , legend.background = element_rect(fill = "transparent") # get rid of legend bg
      , legend.box.background = element_rect(fill = "transparent") # get rid of legend panel bg
      , strip.background = element_rect(fill = "transparent")
      , strip.text = element_text(size = 14)
    )
}
