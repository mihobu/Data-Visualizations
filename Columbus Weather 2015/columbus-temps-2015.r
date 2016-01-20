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
### PREPARE SOME USEFUL VARIABLES
##################################################################################
# auto calculate the Y-axis limits
#y_limits <- c(min(temps[,'rlo']),max(temps[,'rhi']))

# auto calculate the Y-axis limits, then round to the next largest (in magnitude) 10:
y_limits <- c(round(min(temps[,'rlo'])-5,-1),round(max(temps[,'rhi'])+5,-1))
y_breaks <- seq(y_limits[1],y_limits[2],10)
y_labels <- paste(as.character(seq(y_limits[1],y_limits[2],10)),"°",sep="")
y_labels <- gsub("-","–",y_labels) # replace hyphens with en-dashes

# Customize breaks for the horizontal axis, based upon the months:
# NON-LEAP YEARS:
month_len <- c(31,28,31,30,31,30,31,31,30,31,30,31)
x_breaks <- c(31.5,59.5,90.5,120.5,151.5,181.5,212.5,243.5,273.5,304.5,334.5)
x_labels <- c("JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER")
x_limits <- c(0.5,365.5)

# x_breaks2: Where to place the month labels on the x-axis:
last <- 0
x_breaks2 <- c()
for ( i in 1:12 ) {
  x <- month_len[i]/2 + last
  x_breaks2 <- c(x_breaks2,x)
  last <- last + month_len[i]
}

##################################################################################
### PREPARE THE TOP PLOT, CONTAINING THE MONTH LABELS
##################################################################################
p2 <- ggplot(temps) +
  geom_blank() +
  scale_x_continuous(
    limits=x_limits,
    breaks=x_breaks2,
    labels=x_labels,
    expand=c(0,0)
  ) +
  theme(
    plot.margin=unit(c(0,0,0.1,0),"in"),
    axis.text.x=element_text(family="Franklin Gothic Demi",size=16),
    axis.text.y=element_blank(),
    panel.background=element_blank(),
    plot.background=element_blank(),
    axis.ticks=element_blank(), # no tick marks
    axis.line=element_blank(), # no axis lines
    axis.title=element_blank() # no axis titles
  )

##################################################################################
### Title plot
##################################################################################
pTitle <- ggplot(temps) +
  geom_blank() +
  scale_x_continuous(
    limits=x_limits,
    breaks=x_breaks2,
    expand=c(0,0)
  ) +
  theme(
    plot.margin=unit(c(0,0,0,0),"in"),
    panel.grid.major=element_blank(),
    panel.grid.minor=element_blank(),
    axis.text=element_blank(),
    panel.background=element_rect(fill="NA",colour="NA"),
    plot.background=element_blank(),
    axis.ticks=element_blank(), # no tick marks
    axis.line=element_blank(), # no axis lines
    axis.title=element_blank() # no axis titles
  ) +
  annotate("text",x=1,y=1,label="Columbus Weather in 2015",hjust=0,family="Franklin Gothic Demi",size=12)


##################################################################################
### PREPARE THE LEFT PLOT, CONTAINING THE TEMPERATURE LABELS ALONG THE Y-AXIS
### There are two reasons for not including the labels in the main plot: (1) it
### throws off the labels on the top plot, and (2) I need Y-axis labels on both
### the right and left.
##################################################################################
p4 <- ggplot(temps) +
  geom_blank() +
  scale_x_continuous(
    limits=x_limits,
    breaks=x_breaks,
    labels=x_labels,
    expand=c(0,0)
  ) +
  scale_y_continuous(
    limits=y_limits,
    breaks=y_breaks,
    labels=y_labels,
    expand=c(0,0)
  ) +
  theme(
    panel.background=element_rect(fill="NA",colour="NA"),
    panel.grid.major=element_blank(),
    panel.grid.minor=element_blank(),
    plot.margin=unit(c(0,0,0.1,0),"in"),
    plot.background=element_rect(fill="NA",colour="NA"),
    axis.text.x=element_blank(),
    axis.text.y=element_text(family="Franklin Gothic Demi",size=16,vjust=0.5,hjust=1),
    panel.background=element_blank(),
    plot.background=element_blank(),
    axis.ticks=element_blank(), # no tick marks
    axis.line=element_blank(), # no axis lines
    axis.title=element_blank() # no axis titles
  )

##################################################################################
### PREPARE THE MAIN PLOT
##################################################################################
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
    color="NA",fill="#DFDCD4"
  ) +

  # PLOT THE NORMAL HIGHS AND LOWS:
  geom_rect(
    aes(x=n,xmin=n-0.5,xmax=n+0.5,ymin=nlo,ymax=nhi),
    color="NA",fill="#B0ADA4"
  ) +

  # PLOT THE DAILY HIGHS AND LOWS:
  geom_rect(
    aes(x=n,xmin=n-0.4,xmax=n+0.4,ymin=lo,ymax=hi),
    color="NA",fill="#563649"
  ) +

  # APPLY THEME:
  theme (

    # PLOT MARGIN: Keep in mind that margins are taken off of the exported size first, then the
    # plot is crammed into whatever is left over. So, if you've got 1-inch margins and your exported
    # size is only 2 inches, there'll be nothing left for the plot area. (TRBL)
    plot.margin=unit(c(0,0,0.1,0),"in"),

    # BACKGOUND COLORS (FILL AND BORDER) OF THE PLOT AREA
    plot.background=element_rect(fill="NA",colour="NA"),

    # NO AXIS LINES
    axis.line=element_blank(),

    # NO TICK MARKS
    axis.ticks=element_blank(),

    # NO AXIS TITLES:
    axis.title=element_blank(),

    # AXIS LABELS:
    axis.text = element_blank(),

    # Panel background
    # Note: Because panel.ontop=TRUE, this needs to be blank or it will cover up the plot!
    panel.background=element_blank(),

    # Put axis lines on top, rather than behind: 
    panel.ontop=TRUE,

    #panel.border=element_blank(),

    # Vertical grid lines:
    panel.grid.major.x=element_line(
      colour="#000000",
      size=0.1,
      linetype=3
    ),

    # Horizontal grid lines:
    panel.grid.major.y=element_line(
      colour="#ffffff",
      size=0.1,
      linetype=1
    ),

    # no minor grid lines
    panel.grid.minor=element_blank()

  )

##################################################################################
### PREPARE THE GRID AND COMBINE THE PLOTS
##################################################################################
# create an asymmetric grid layout:
gl <- grid.layout(nrow = 3, ncol = 3,
        widths = c(0.2,8,0.2),
        heights = c(0.5,2.5,0.1),
        default.units = "in")

# put the subplots on the grid:
png("test.png",width=8.4,height=3.1,pointsize=1/300,units="in",res=300)
grid.newpage()
pushViewport(viewport(layout=gl))
print(p2,vp=viewport(layout.pos.row=1,layout.pos.col=2))
print(p4,vp=viewport(layout.pos.row=2,layout.pos.col=1))
print(p5,vp=viewport(layout.pos.row=2,layout.pos.col=2))
print(p4,vp=viewport(layout.pos.row=2,layout.pos.col=3))
print(pTitle,vp=viewport(layout.pos.row=1,layout.pos.col=c(1,2,3)))
dev.off()

