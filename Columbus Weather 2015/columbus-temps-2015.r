# columbus-temps-2015.r

setwd("C:/Users/burkham8/Desktop/Dataviz Projects/Data-Visualizations repo/Columbus Weather 2015")

temps <- read.csv("columbus-temps-2015.csv",header=TRUE)
temps$n <- 1:nrow(temps) # assign row number to new column, called n
library(ggplot2)

# auto calculate the Y-axis limits
#y_limits <- c(min(temps[,'rlo']),max(temps[,'rhi']))

# auto calculate the Y-axis limits, then round to the next largest (in magnitude) 10:
y_limits <- c(round(min(temps[,'rlo'])-5,-1),round(max(temps[,'rhi'])+5,-1))
y_breaks <- seq(y_limits[1],y_limits[2],10)
y_labels <- paste(as.character(seq(y_limits[1],y_limits[2],10)),"°",sep="")

library(showtext) # enables the use of OTF fonts
showtext.auto(enable=TRUE)
font.add("Franklin Gothic Cond Medium","FRAMDCN.TTF")
font.add("Franklin Gothic Cond Demi",  "FRADMCN.TTF")
font.add("Franklin Gothic Medium",     "FRAMD.TTF")
font.add("Franklin Gothic Demi",       "FRADM.TTF")

ggplot(temps) +

  # X SCALE:
  scale_x_continuous(limits=c(0.5,365.5),breaks=(1:30)*30) +

  # Y SCALE, SET EXACTLY
  scale_y_continuous(
    limits=y_limits,
    breaks=y_breaks,
    labels=y_labels
  ) +

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
      family="Franklin Gothic Cond Medium",
      colour="#333333",
      size=18
    ),

    # X-AXIS LABELS:
    axis.text.x=element_blank(),

    axis.line=element_blank()
  )

ggsave(filename="columbus-temps-2015.png",plot=last_plot(),scale=1,width=4,height=2,units="in",dpi=600)


