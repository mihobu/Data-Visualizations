# columbus-temps-2015.r

##################################################################################
### PART 1: READ THE DATA
##################################################################################
setwd("C:/Users/burkham8/Desktop/Dataviz Projects/Data-Visualizations repo/Columbus Weather 2015")
temps <- read.csv("columbus-temps-2015.csv",header=TRUE)
temps$n <- 1:nrow(temps) # assign row number to new column, called n

##################################################################################
### LOAD LIBRARIES AND FONTS
##################################################################################
library(grid)
library(ggplot2)
library(showtext) # enables the use of OTF fonts
showtext.auto(enable=TRUE)
font.add("Franklin Gothic Cond Medium","FRAMDCN.TTF")
font.add("Franklin Gothic Cond Demi",  "FRADMCN.TTF")
font.add("Franklin Gothic Medium",     "FRAMD.TTF")
font.add("Franklin Gothic Demi",       "FRADM.TTF")

##################################################################################
### PREPARE THE MAIN PLOT
##################################################################################
# auto calculate the Y-axis limits
#y_limits <- c(min(temps[,'rlo']),max(temps[,'rhi']))

# auto calculate the Y-axis limits, then round to the next largest (in magnitude) 10:
y_limits <- c(round(min(temps[,'rlo'])-5,-1),round(max(temps[,'rhi'])+5,-1))
y_breaks <- seq(y_limits[1],y_limits[2],10)
y_labels <- paste(as.character(seq(y_limits[1],y_limits[2],10)),"°",sep="")

# Customize breaks for the horizontal axis, based upon the months:
# NON-LEAP YEARS:
month_len <- c(31,28,31,30,31,30,31,31,30,31,30,31)
x_breaks <- c(31.5,59.5,90.5,120.5,151.5,181.5,212.5,243.5,273.5,304.5,334.5)
x_labels <- c("JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER")
x_limits <- c(0.5,365.5)

p5 <- ggplot(temps) +

  # X SCALE:
  scale_x_continuous(
    limits=x_limits,
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

    # PLOT MARGIN: Keep in mind that margins are taken off of the exported size first, then the
    # plot is crammed into whatever is left over. So, if you've got 1-inch margins and your exported
    # size is only 2 inches, there'll be nothing left for the plot area. (TRBL)
    plot.margin=unit(c(0,0,0,0),"npc"),

    # BACKGOUND COLORS (FILL AND BORDER) OF THE PLOT AREA
    plot.background=element_rect(fill="#ffcccc",colour="NA"),

    # NO AXIS LINES
    axis.line=element_blank(),

    # NO TICK MARKS
    axis.ticks=element_blank(),

    # NO AXIS TITLES:
    axis.title=element_blank(),

    # NO AXIS LABELS:
    axis.text = element_blank(),

    # X-AXIS LABELS:
    axis.text.x=element_blank(),

    # Panel background
    # Note: Because panel.ontop=TRUE, this needs to be blank or it will cover up the plot!
    #panel.background=element_rect(fill="NA",colour="NA"),
    panel.background=element_blank(),

    # Put axis lines on top, rather than behind: 
    panel.ontop=TRUE,

    #panel.border=element_blank(),

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

    # no minor grid lines
    panel.grid.minor=element_blank(),

    plot.margin=unit(c(0,0,0,0),"in")
  )
p5

last <- 0
x_breaks2 <- c()
for ( i in 1:12 ) {
  x <- month_len[i]/2 + last
  x_breaks2 <- c(x_breaks2,x)
  last <- last + month_len[i]
}

p2 <- ggplot(temps) +
  geom_blank() +
  scale_x_continuous(
    limits=x_limits,
    breaks=x_breaks2,
    labels=x_labels,
    expand=c(0,0)
  ) +
  theme(
    panel.background=element_blank(),
    plot.background=element_blank(),
    axis.ticks=element_blank(), # no tick marks
    axis.line=element_blank() # no axis lines
  )
p2

# create an asymmetric grid layout:
gl <- grid.layout(nrow = 2, ncol = 1,
        widths = c(8),
        heights = c(0.5,4),
        default.units = "in")

# put the subplots on the grid:
png("test.png",width=8,height=4.5,pointsize=1/300,units="in",res=300)
grid.newpage()
pushViewport(viewport(layout=gl))
print(p2,vp=viewport(layout.pos.col=1,layout.pos.row=1))
print(p5,vp=viewport(layout.pos.col=1,layout.pos.row=2))
dev.off()

#ggsave(filename="columbus-temps-2015.png",plot=last_plot(),scale=1,width=4,height=2,units="in",dpi=600)
