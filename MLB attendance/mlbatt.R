library(ggplot2)

gl <- read.csv("GL2015.TXT",header=FALSE)

# impute the data!
gl <- gl[gl$V18!=0,] # omit records where attendance = 0
gl <- gl[!is.na(gl$V18),] # omit records where attendance = NA

# get unique list of venue IDs:
venues <- unique(gl[,'V17'])
print(sprintf("There are %d venues.",length(venues)))

# Show number of games played at each venue:
table(gl[,'V17'])

# ~~~~~~~~~~~~~~

# Get a list of venue IDs sorted by standard deviation:
venues_by_sd <- sort(sqrt(c(by(gl$V18,gl$V17,var))))
venues_by_tot_att <- sort(c(by(gl$V18,gl$V17,sum)))


# Create new venue column whose natural ordering is the standard deviation
gl$V17b <- factor(gl$V17,levels=names(venues_by_sd))

# boxplot: attendance by venue
ggplot(gl,aes(V17b,V18)) + geom_boxplot()

# Create new venue column whose natural ordering is the total attendance for
# the whole season
gl$V18b <- factor(gl$V17,levels=names(venues_by_tot_att))

# boxplot: attendance by total attendance
ggplot(gl,aes(V18b,V18)) +
  stat_boxplot(geom='errorbar') +
  geom_boxplot() +
  coord_flip() +
  # Dodger Stadium (Los Angeles)
  annotate(geom="point", x=30, y=56000, color="red", shape=8, size=2) +
  # Busch Stadium (St Louis)
  annotate(geom="point", x=29, y=46861, color="red", shape=8, size=2) +
  # AT&T Park (San Francisco)
  annotate(geom="point", x=28, y=41915, color="red", shape=8, size=2) +
  # Yankee Stadium (New York)
  annotate(geom="point", x=27, y=49638, color="red", shape=8, size=2) +
  # Angel Stadium of Anaheim
  annotate(geom="point", x=26, y=45957, color="red", shape=8, size=2)









