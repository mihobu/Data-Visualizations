# highways.r

###############################################################################
### 1. LOAD THE DATA
###############################################################################

hwy <- read.csv("hwys.csv",header=TRUE)
rownames(hwy) <- hwy$st # index by state abbreviation

# create some scaled columns (for slightly easier plotting)
hwy$popm <- hwy$pop / 1000000
hwy$area000 <- hwy$area / 1000

# SET FILL COLORS MANUALLY
hwy$fill <- rep("#87898B", 51)
# set special colors:
hwy['CA','fill'] <- "#8E4EA6"
#hwy['DC','fill'] <- "#D32426"
hwy['TX','fill'] <- "#0072CF"
hwy['AK','fill'] <- "#58C140"

# Create custom color profile
jColors <- hwy$fill
names(jColors) <- hwy$st

# Sort on the custom fill field, so that our "special"
# circles will be on top of the others:
hwy <- hwy[order(hwy$fill),]

##################################################################################
# SOME QUICK STATISTICAL ANALYSIS
##################################################################################

# Lane miles and population are highly correlated: (rho = 0.91)
cor(hwy$lm_tot, hwy$popm)
cor(hwy$lm_tot, hwy$area000)


##################################################################################
### 2. LOAD LIBRARIES AND FONTS
##################################################################################
library(grid)
library(ggplot2)
library(showtext) # enables the use of OTF fonts
library(sysfonts) # enables use of system fonts

# Enable custom fonts
showtext.auto(enable=TRUE)
font.add("Franklin Gothic Cond Medium","FRAMDCN.TTF")
font.add("Franklin Gothic Cond Demi",  "FRADMCN.TTF")
font.add("Franklin Gothic Medium",     "FRAMD.TTF")
font.add("Franklin Gothic Demi",       "FRADM.TTF")

##################################################################################
### 3. PLOT ME SOME DATA
##################################################################################


#=============================================================================
# PLOT (1) X = AREA , Y = LANE MILES , SIZE = POPULATION
#=============================================================================

ggplot(data=hwy, aes(x=area000,y=lm_tot/1000,label=state)) +
  geom_jitter(aes(size=hwy$popm, fill=hwy$st), colour="white", shape=21,height=0, width=0) +
  scale_fill_manual(values=jColors, guide=FALSE) +
  labs(size="Population (millions)") +
  scale_size_area(max_size=20) +
  ylab("Lane Miles (thousands)") +
  xlab("Geographic Area, including perennial waters (thousands of square miles)") +
  scale_y_continuous(labels=function(n){format(n,scientific=FALSE)}) +
  scale_x_continuous(labels=function(n){format(n,scientific=FALSE)}) +
  theme(
    axis.text = element_text(family="Franklin Gothic Medium", size=10),
    axis.title = element_text(family="Franklin Gothic Demi", size=10),
    axis.ticks.x = element_blank(),
    axis.ticks.y = element_blank(),
    legend.key = element_rect(fill="#cccccc", colour="white"),
    legend.position = c(1,1),
    legend.text = element_text(family="Franklin Gothic Medium", size=8),
    legend.title = element_text(family="Franklin Gothic Demi", size=10),
    legend.background = element_rect(colour="black", fill="white")
  ) +
  annotate("text", x=hwy['TX','area000']+15, y=hwy['TX','lm_tot']/1000, hjust=0, vjust=0, color=jColors['TX'], label="Texas", family="Franklin Gothic Demi") +
  annotate("text", x=hwy['OH','area000']-10, y=hwy['OH','lm_tot']/1000, hjust=1, vjust=0, color=jColors['OH'], label="Ohio", family="Franklin Gothic Demi") +
  annotate("text", x=hwy['AK','area000']-5, y=hwy['AK','lm_tot']/1000, hjust=1, vjust=0, color=jColors['AK'], label="Alaska", family="Franklin Gothic Demi") +
  annotate("text", x=hwy['CA','area000']+15, y=hwy['CA','lm_tot']/1000, hjust=0, vjust=0, color=jColors['CA'], label="California", family="Franklin Gothic Demi") +
  ggsave("moo.pdf", width=10, height=7)

#=============================================================================
# PLOT (2) LANE MILES , Y = POPULATION , SIZE = GEOGRAPHIC AREA
#=============================================================================

ggplot(data=hwy, aes(x=lm_tot,y=popm,label=state)) +
  geom_jitter(aes(size=hwy$area000, fill=hwy$st), colour="white", shape=21,height=0, width=0) +
  scale_size_area(max_size=30) +
  scale_fill_manual(values=jColors, guide=FALSE) +
  labs(size="U.S. State Geographic Area\n(in thousands of square miles)") +
  ylab("Population (millions)") +
  xlab("Lane Miles (thousands)") +
  scale_y_continuous(labels=function(n){format(n,scientific=FALSE)},limits=c(-2,40),breaks=seq(0,40,10)) +
  scale_x_continuous(labels=function(n){format(n,scientific=FALSE)},limits=c(0,17000),breaks=seq(0,16000,1000), expand=c(0,0)) +
  ggtitle("Populations, Interstate Highway Lane Miles, and Areas of U.S. States") +
  theme(
    plot.title = element_text(family="Franklin Gothic Demi", size=16),
    axis.text = element_text(family="Franklin Gothic Medium", size=10),
    axis.title = element_text(family="Franklin Gothic Demi", size=10),
    axis.ticks.x = element_blank(),
    axis.ticks.y = element_blank(),
    legend.key = element_rect(fill="#cccccc", colour="white"),
    legend.position = c(0,1),
    legend.justification = c(0,1), # align legend
    legend.text = element_text(family="Franklin Gothic Medium", size=8),
    legend.title = element_text(family="Franklin Gothic Demi", size=10),
    legend.background = element_rect(colour="black", fill="white")
  ) +
  annotate("text", x=hwy['TX','lm_tot'], y=hwy['TX','popm']-3.5, hjust=0.5, vjust=0, color=jColors['TX'], label="Texas", family="Franklin Gothic Demi") +
  annotate("text", x=hwy['AK','lm_tot']+600, y=hwy['AK','popm']-2.5, hjust=0, vjust=0, color=jColors['AK'], label="Alaska", family="Franklin Gothic Demi") +
  annotate("text", x=hwy['CA','lm_tot'], y=hwy['CA','popm']-3, hjust=0.5, vjust=0, color=jColors['CA'], label="California", family="Franklin Gothic Demi")

  # DC
  #annotate("text", x=hwy['DC','lm_tot'], y=hwy['DC','popm']+1, hjust=1, vjust=0, color=jColors['DC'], label="DC", family="Franklin Gothic Demi") +
  #geom_point(aes(x=hwy['DC','lm_tot'],y=hwy['DC','popm']), size=hwy['DC','area000']+3, stroke=2, shape=1, color=jColors['DC']) +
  # SAVE AS PDF:
  ggsave("lm.pdf", width=12, height=6)


#  geom_text()
#  geom_label(data=hwy, aes(area000,popm,label=hwy$state))






