#####################
# ggplot2 custom theme
# http://stackoverflow.com/questions/27400931/how-to-make-a-default-custom-theme-with-ggplot2-in-r
#####################

theme_tzen = function(){
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