# columbus-temps-2015.r

setwd("C:/Users/burkham8/Desktop/Dataviz Projects/2016-01-14 Columbus Temperatures 2015")

temps <- read.csv("columbus-temps-2015.csv",header=TRUE)
temps$n <- 1:nrow(temps) # assign row number to new column, called n

library(ggplot2)

library(showtext) # enables the use of OTF fonts
showtext.auto(enable=TRUE)
font.add("Myriad Pro Regular","MyriadPro-Regular.otf")

ggplot(temps) +

  # X SCALE:
  scale_x_continuous(limits=c(0.5,365.5),breaks=(1:30)*30) +

  # Y SCALE, SET EXACTLY
  scale_y_continuous(limits=c(min(temps[,'rlo']),max(temps[,'rhi'])),breaks=(-3:12)*10) +

  geom_rect(
    aes(x=n,xmin=n-0.5,xmax=n+0.5,ymin=rlo,ymax=rhi),
    color="NA",fill="#ccccff"
  ) +
  geom_rect(
    aes(x=n,xmin=n-0.5,xmax=n+0.5,ymin=nlo,ymax=nhi),
    color="NA",fill="#aaaaff"
  ) +
  geom_rect(
    aes(x=n,xmin=n-0.25,xmax=n+0.25,ymin=lo,ymax=hi),
    color="NA",fill="#6666ff"
  ) +
  theme (
    aspect.ratio=0.5,
    #plot.background=element_rect(fill="#0000ff"), # very light blue background
    plot.margin=unit(c(0,0,0,0),"mm"),              # TRBL
    panel.background=element_rect(fill="#eeeeff"),
    panel.margin=unit(c(0,0,0,0),"mm"),
    panel.grid.major=element_blank(),              # no major grid lines
    panel.grid.minor=element_blank(),              # no minor grid lines
    axis.ticks=element_blank(),                    # no tick marks

    # AXIS TITLES:
    axis.title=element_blank(),

    # Y-AXIS LABELS:
    axis.text.y=element_text(
      family="Myriad Pro Regular",
      colour="#333333",
      size=12
    ),

    # X-AXIS LABELS:
    axis.text.x=element_blank(),

    axis.line=element_blank()
  )

ggsave(filename="columbus-temps-2015.png",plot=last_plot(),scale=1,width=4,height=2,units="in",dpi=600)


