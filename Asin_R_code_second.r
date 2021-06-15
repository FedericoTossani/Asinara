require(raster)
require(rgdal)
require(RStoolbox)
require(rasterdiv)
require(rasterVis)
require(ggplot2)
require(gridExtra)
require(viridis)
setwd("/Users/federicotossani/Asinara/L_image")
source("/Users/federicotossani/Asinara/spectralrao.r")

#importare file
### Impacchettamento
asilist<-list.files(pattern="Asi_")
asimport<-lapply(asilist, raster)

#Rao's Q index
asirao<-spectralrao(asimport, distance_m="euclidean", window=3, shannon=FALSE) 


asilist<-list.files(pattern="p193r32")
asimp<-lapply(asilist, raster)
asinara<-crop(asimp, extent(431858.1, 445713, 4532960, 4552802))
asinara<-lapply(asimp, crop(asimp, extent(431858.1, 445713, 4532960, 4552802)))



asirao<-spectralrao(import84, distance_m="euclidean", window=3, shannon=FALSE)



asipca<-lapply(asimp, rasterPCA)

asipc1<-asipca$map$PC1

plot(asipc1)
