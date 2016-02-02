library(ggplot)
library(grid)

xdf <- data.frame(x=runif(10),y=runif(10))
p1 <- ggplot(xdf) + geom_blank() +
  theme(
    # The PANEL is the "container" and extends all the way to the edges. It may also include a border ("color" attrib)
    panel.background=element_rect(fill="#3333cc",color="NA"), # dark blue fill, no border
    # The PLOT is the plot area, contained inside the PANEL.
    # By default, the PLOT has a margin
    plot.background=element_rect(fill="#ff0000",color="NA"), # bright red fill, no border
    plot.margin=unit(c(5,10,15,20),"bigpts") # The spacing (TRBL) outside the PLOT, but inside the PANEL
  )

p2 <- ggplot(xdf) + geom_blank() + theme(plot.background=element_blank(),panel.background=element_rect(fill="#99cc99",color="#000000"))
p3 <- ggplot(xdf) + geom_blank() + theme(plot.background=element_rect(fill="#99cccc",color="NA"))
p4 <- ggplot(xdf) + geom_blank() + theme(plot.background=element_rect(fill="#cc9999",color="NA"))
p5 <- ggplot(xdf) + geom_point(aes(x=x,y=y)) + theme(plot.background=element_rect(fill="#cc99cc",color="NA"))
p6 <- ggplot(xdf) + geom_blank() + theme(plot.background=element_rect(fill="#cccc99",color="NA"))
p7 <- ggplot(xdf) + geom_blank() + theme(plot.background=element_rect(fill="#ccccff",color="NA"))
p8 <- ggplot(xdf) + geom_blank() + theme(plot.background=element_rect(fill="#ccffcc",color="NA"))
p9 <- ggplot(xdf) + geom_blank() + theme(plot.background=element_rect(fill="#ccffff",color="NA"))


vp1 <- viewport(x=unit(0,"npc"),y=unit(0,"npc"),width=unit(1,"in"),height=unit(1,"in"))
vp5 <- viewport(x=unit(0.5,"in"),y=unit(0.5,"in"), # from lower-left
  width=unit(3,"in"),height=unit(2,"in"),
  just=c("left","bottom")
)
pushViewport(myVP)
print(p1,vp=vp1)
print(p2,vp=viewport(layout.pos.row=1,layout.pos.col=2))
print(p3,vp=viewport(layout.pos.row=1,layout.pos.col=3))
print(p4,vp=viewport(layout.pos.row=2,layout.pos.col=1))
print(p5,vp=vp5)
print(p6,vp=viewport(layout.pos.row=2,layout.pos.col=3))
print(p7,vp=viewport(layout.pos.row=3,layout.pos.col=1))
print(p8,vp=viewport(layout.pos.row=3,layout.pos.col=2))
print(p9,vp=viewport(layout.pos.row=3,layout.pos.col=3))




print(p5)



