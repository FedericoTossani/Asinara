require(raster)
require(rgdal)
require(RStoolbox)
require(rasterdiv)
require(rasterVis)
require(ggplot2)
require(gridExtra)
require(viridis)
require(purrr)
setwd("/Users/federicotossani/Asinara/L_image")

raolist<-list.files(pattern="Rao")
asirao<-lapply(raolist, brick)
raoag<-lapply(asirao, aggregate(x, fact=10))

rao84<-brick("Rao_84.grd")
rao85<-brick("Rao_85.grd")
rao87<-brick("Rao_87.grd")
rao88<-brick("Rao_88.grd")
rao91<-brick("Rao_91.grd")
rao92<-brick("Rao_92.grd")
rao95<-brick("Rao_95.grd")
rao96<-brick("Rao_96.grd")
rao97<-brick("Rao_97.grd")
rao99<-brick("Rao_99.grd")
rao00<-brick("Rao_00.grd")
rao02<-brick("Rao_02.grd")
rao14<-brick("Rao_14.grd")
rao15<-brick("Rao_15.grd")
rao17<-brick("Rao_17.grd")
rao18<-brick("Rao_18.grd")
rao20<-brick("Rao_20.grd")

rao84a<-aggregate(rao84, fact=10)
rao85a<-aggregate(rao85, fact=10)
rao87a<-aggregate(rao87, fact=10)
rao88a<-aggregate(rao88, fact=10)
rao91a<-aggregate(rao91, fact=10)
rao92a<-aggregate(rao92, fact=10)
rao95a<-aggregate(rao95, fact=10)
rao96a<-aggregate(rao96, fact=10)
rao97a<-aggregate(rao97, fact=10)
rao99a<-aggregate(rao99, fact=10)
rao00a<-aggregate(rao00, fact=10)
rao02a<-aggregate(rao02, fact=10)
rao14a<-aggregate(rao14, fact=10)
rao15a<-aggregate(rao15, fact=10)
rao17a<-aggregate(rao17, fact=10)
rao18a<-aggregate(rao18, fact=10)
rao20a<-aggregate(rao20, fact=10)

p1<-ggplot()+
geom_raster(rao84a, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 1984")

p2<-ggplot()+
geom_raster(rao91a, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 1991")

p3<-ggplot()+
geom_raster(rao02a, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 2002")

p4<-ggplot()+
geom_raster(rao20a, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 2020")

grid.arrange(p1, p2, nrow=1, ncol=2)
