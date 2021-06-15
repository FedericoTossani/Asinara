require(raster)
require(rgdal)
require(RStoolbox)
require(rasterdiv)
require(rasterVis)
require(ggplot2)
require(gridExtra)
require(viridis)
setwd("/Users/federicotossani/Asinara/L_image")

#importare file
asilist<-list.files(pattern="Asi_")
asimp<-lapply(asilist, brick)

asipca<-lapply(asimp, rasterPCA)

asipc1<-asipca$map$PC1

plot(asipc1)
