###############################
#### Asinara's time series ####
###############################

library(raster)
library(rasterVis)
setwd("/Users/federicotossani/Asinara/L_image/LC08_L2SP_193032_20140407")

alist<-list.files(pattern="SR_B")

import<-lapply(alist, raster)

p193r32_2014<-stack(import)

plotRGB(p193r32_2014, 4, 3, 2, stretch="lin")
p193r32_2014c<-crop(p193r32_2014,drawExtent(show=TRUE, col="red"))

plot(p193r32_2014c)
plotRGB(p193r32_2014c, 5,3,2, stretch="lin")

#extent     : 425985, 449085, 4532895, 4557075  (xmin, xmax, ymin, ymax)
