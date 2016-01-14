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

# add some space to the top:
y_limits <- c(y_limits[1]-10,y_limits[2]+20)
y_breaks <- c(y_limits[1]-100,y_breaks,y_limits[2]+100,y_limits[2]+100) # Intentionally add "off grid" values
y_labels <- c("",y_labels,"","")

# Customize breaks for the horizontal axis, based upon the months:
month_len <- c(31,28,31,30,31,30,31,31,30,31,30,31)
x_breaks <- c(31.5,59.5,90.5,120.5,151.5,181.5,212.5,243.5,273.5,304.5,334.5)
mon_y <- y_limits[2]

library(showtext) # enables the use of OTF fonts
showtext.auto(enable=TRUE)
font.add("Franklin Gothic Cond Medium","FRAMDCN.TTF")
font.add("Franklin Gothic Cond Demi",  "FRADMCN.TTF")
font.add("Franklin Gothic Medium",     "FRAMD.TTF")
font.add("Franklin Gothic Demi",       "FRADM.TTF")

ggplot(temps) +

  # X SCALE:
  scale_x_continuous(
    limits=c(0.5,365.5),
    breaks=x_breaks,
    expand=c(0,0)
  ) +

  # Y SCALE, SET EXACTLY
  scale_y_continuous(
    limits=y_limits,
    breaks=y_breaks,
    labels=y_labels,
    expand=c(0,0)
  ) +

  # PLOT THE RECORD HIGHS AND LOWS:
  geom_rect(
    aes(x=n,xmin=n-0.5,xmax=n+0.5,ymin=rlo,ymax=rhi),
    color="NA",fill="#cccccc"
  ) +

  # PLOT THE NORMAL HIGHS AND LOWS:
  geom_rect(
    aes(x=n,xmin=n-0.5,xmax=n+0.5,ymin=nlo,ymax=nhi),
    color="NA",fill="#aaaaaa"
  ) +

  # PLOT THE DAILY HIGHS AND LOWS:
  geom_rect(
    aes(x=n,xmin=n-0.25,xmax=n+0.25,ymin=lo,ymax=hi),
    color="NA",fill="#666666"
  ) +

  # APPLY THEME:
  theme (

    # ASPECT RATIO (Counterintuitively, determined by height ÷ width):
    #aspect.ratio=0.5,

    #plot.background=element_rect(fill="#0000ff"), # very light blue background
    axis.ticks=element_blank(),                    # no tick marks

    # NO AXIS TITLES:
    axis.title=element_blank(),

    # Y-AXIS LABELS:
    axis.text.y=element_text(
      family="Franklin Gothic Cond Medium",
      colour="#333333",
      size=18
    ),

    # X-AXIS LABELS:
    axis.text.x=element_blank(),

  ### PANEL FORMATTING (GRID LINES) ---------------

    # panel.background
    panel.background=element_blank(), # If this is not blank, it will cover up the plot!

    # Put axis lines on top, rather than behind: 
    panel.ontop=TRUE,

    # Vertical grid lines:
    panel.grid.major.x=element_line(
      colour="#000000",
      size=0.01,
      linetype=3
    ),

    # Horizontal grid lines:
    panel.grid.major.y=element_line(
      colour="#FFFFFF",
      size=0.01,
      linetype=1
    ),

    panel.grid.minor=element_blank(),              # no minor grid lines

    # PLOT MARGIN: Keep in mind that margins are taken off of the exported size first, then the
    # plot is crammed into whatever is left over. So, if you've got 1-inch margins and your exported
    # size is only 2 inches, there'll be nothing left for the plot area.
    plot.margin=unit(c(0,0,0,0),"in")              # TRBL

  )

  last <- 0
  for ( i in 1:12 ) {
    x <- month_len[i]/2 + last
    print(c(x,mon_y))
    last_plot() + annotate("text",label="JANUARY",x=x,y=mon_y,size=5,colour="#000000",hjust="center",family="Franklin Gothic Cond Medium")
    last <- x_breaks[i]
  }

#  annotate("text",label="JANUARY",x=15.5,y=mon_y,size=5,colour="#000000",hjust="center",family="Franklin Gothic Cond Medium") +
#  annotate("text",label="FEBRUARY",x=45,y=mon_y,size=5,colour="#000000",hjust="center",family="Franklin Gothic Cond Medium") +
#  annotate("text",label="MARCH",x=74.5,y=mon_y,size=5,colour="#000000",hjust="center",family="Franklin Gothic Cond Medium") +
#  annotate("text",label="APRIL",x=105,y=mon_y,size=5,colour="#000000",hjust="center",family="Franklin Gothic Cond Medium") +
#  annotate("text",label="MAY",x=135.5,y=mon_y,size=5,colour="#000000",hjust="center",family="Franklin Gothic Cond Medium") +
#  annotate("text",label="JUNE",x=166,y=mon_y,size=5,colour="#000000",hjust="center",family="Franklin Gothic Cond Medium") +
#  annotate("text",label="JULY",x=196.5,y=mon_y,size=5,colour="#000000",hjust="center",family="Franklin Gothic Cond Medium") +
#  annotate("text",label="AUGUST",x=227.5,y=mon_y,size=5,colour="#000000",hjust="center",family="Franklin Gothic Cond Medium") +
#  annotate("text",label="SEPTEMBER",x=258,y=mon_y,size=5,colour="#000000",hjust="center",family="Franklin Gothic Cond Medium") +
#  annotate("text",label="OCTOBER",x=288.5,y=mon_y,size=5,colour="#000000",hjust="center",family="Franklin Gothic Cond Medium") +
#  annotate("text",label="NOVEMBER",x=319,y=mon_y,size=5,colour="#000000",hjust="center",family="Franklin Gothic Cond Medium") +
#  annotate("text",label="DECEMBER",x=349.5,y=mon_y,size=5,colour="#000000",hjust="center",family="Franklin Gothic Cond Medium") +

#  geom_rect(xmin=0.5,xmax=365.5,ymin=110,ymax=130,color="NA",fill="#ccffcc")

#ggsave(filename="columbus-temps-2015.png",plot=last_plot(),scale=1,width=4,height=2,units="in",dpi=600)

