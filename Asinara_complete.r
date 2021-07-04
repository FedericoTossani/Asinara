#################
#### Asinara ####
#################

# Progetto per l'esame di Telerilevamento Geo-Ecologico

#######################################################
### Intro ###

# Lo scopo di questo progetto è quello di valutare l'eterogeneità vegetale
# del Parco Nazionale dell'Asinara. Il dataset è composto da 17 immagini Landsat
# che coprono un arco di tempo che va dal 1984 al 2020.
# L'idea di questo progetto è nata dalla curiosità di vedere come è cambiata
# la vegetazione dopo la chiusura del carcere (1998), perchè durante il 
# periodo di attività del carcere l'isola aveva una forte componente agricola.
# Le immagini satellitari derivano da Landsat 4, 5, 7, 8.

#######################################################
### Summary ###

# 1. Library & Working directory
# 2. Immagini
#    2.1 Estensione del crop
#    2.2 Importazione delle immagini e creazione rasterBrick
# 3. Where the magic begins
#    3.1 Rao's Q index
#    3.2 NDVI
#    3.3 PCA
#    3.4 Rappresentazione grafica
# 4. Analisi statistiche
# 5. Conclusioni

#######################################################
## 1. Library & Working directory

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
#setwd("/Users/federicotossani/Asinara/L_image_mar")
source("/Users/federicotossani/Asinara/spectralrao.r")

#######################################################
## 2. Images

### 2.1 Estensione del crop ###

# Per ottenre il giusto crop dell'immagine ho usato la funzione draw.extent per disegnare l'area da tagliare sul plot dell'immagine a colori naturali.
# Gli aggiustamenti finali li ho fatti modificando direttamente i singoli valori

#p84 <- plotRGB(p84t, 3, 2, 1, stretch="lin")
#drawExtent(show=TRUE, col="red")
#class      : Extent 
#xmin       : 431858.1 
#xmax       : 445713 
#ymin       : 4532960 
#ymax       : 4552802 

### estensione ###
extnew<-extent(431858.1, 445713, 4532960, 4552802)


### 2.2 Importazione delle immagini e creazione rasterBrick ###

# Ho usato queste funzioni per accorpare tutte le bande in un unico raster la prima volta che ho scaricato e importato le immagini.
# Nelle successive analisi ho caricato i file direttamente dal punto 2.3.

## 1984 ##
list84<-list.files(pattern="1984")
p84t<-lapply(list84, raster)
p84<- map(p84t, crop, extnew)
#writeRaster(p84, filename="Asi_p193r32_1984.grd", format="raster")

## 1985 ## Immagine rovinata per presenza di nuvole
#list85<-list.files(pattern="1985")
#p85t<-lapply(list85, raster)
#p85<- map(p85t, crop, extnew)
#writeRaster(p85, filename="Asi_p193r32_1985.grd", format="raster")

## 1987 ##
list87<-list.files(pattern="1987")
p87t<-lapply(list87, raster)
p87<- map(p87t, crop, extnew)
writeRaster(p87, filename="Asi_p193r32_1987.grd", format="raster")

## 1988 ##
list88<-list.files(pattern="1988")
p88t<-lapply(list88, raster)
p88<- map(p88t, crop, extnew)
#writeRaster(p88, filename="Asi_p193r32_1988.grd", format="raster")

## 1991 ##
list91<-list.files(pattern="1991")
p91t<-lapply(list91, raster)
p91<- map(p91t, crop, extnew)
#writeRaster(p91, filename="Asi_p193r32_1991.grd", format="raster")

## 1992 ##
list92<-list.files(pattern="1992")
p92t<-lapply(list92, raster)
p92<- map(p92t, crop, extnew)
#writeRaster(p92, filename="Asi_p193r32_1992.grd", format="raster")

## 1995 ##
list95<-list.files(pattern="1995")
p95t<-lapply(list95, raster)
p95<- map(p95t, crop, extnew)
#writeRaster(p95, filename="Asi_p193r32_1995.grd", format="raster")

## 1996 ##
list96<-list.files(pattern="1996")
p96t<-lapply(list96, raster)
p96<- map(p96t, crop, extnew)
#writeRaster(p96, filename="Asi_p193r32_1996.grd", format="raster")

## 1997 ##
list97<-list.files(pattern="1997")
p97t<-lapply(list97, raster)
p97<- map(p97t, crop, extnew)
#writeRaster(p97, filename="Asi_p193r32_1997.grd", format="raster")

## 1999 ##
list99<-list.files(pattern="1999")
p99t<-lapply(list99, raster)
p99<- map(p99t, crop, extnew)
#writeRaster(p99, filename="Asi_p193r32_1999.grd", format="raster")

## 2000 ##
list00<-list.files(pattern="2000")
p00t<-lapply(list00, raster)
p00<- map(p00t, crop, extnew)
#writeRaster(p00, filename="Asi_p193r32_2000.grd", format="raster")

## 2002 ##
list02<-list.files(pattern="2002b")
p02t<-lapply(list02, raster)
p02<- map(p02t, crop, extnew)
#writeRaster(p02, filename="Asi_p193r32_2002.grd", format="raster")

## 2014 ##
list14<-list.files(pattern="2014")
p14t<-lapply(list14, raster)
p14<- map(p14t, crop, extnew)
#writeRaster(p14, filename="Asi_p193r32_2014.grd", format="raster")

## 2015 ##
list15<-list.files(pattern="2015")
p15t<-lapply(list15, raster)
p15<- map(p15t, crop, extnew)
#writeRaster(p15, filename="Asi_p193r32_2015.grd", format="raster")

## 2017 ##
list17<-list.files(pattern="2017")
p17t<-lapply(list17, raster)
p17<- map(p17t, crop, extnew)
#writeRaster(p17, filename="Asi_p193r32_2017.grd", format="raster")

## 2018 ##
list18<-list.files(pattern="2018")
p18t<-lapply(list18, raster)
p18<- map(p18t, crop, extnew)
#writeRaster(p18, filename="Asi_p193r32_2018.grd", format="raster")

## 2020 ##
list20<-list.files(pattern="2020")
p20t<-lapply(list20, raster)
p20<- map(p20t, crop, extnew)
#writeRaster(p20, filename="Asi_p193r32_2020.grd", format="raster")

## Importazione con la funzione brick
p84<-brick("Asi_p193r32_1984.grd")
p87<-brick("Asi_p193r32_1987.grd")
p88<-brick("Asi_p193r32_1988.grd")
p91<-brick("Asi_p193r32_1991.grd")
p92<-brick("Asi_p193r32_1992.grd")
p95<-brick("Asi_p193r32_1995.grd")
p96<-brick("Asi_p193r32_1996.grd")
p97<-brick("Asi_p193r32_1997.grd")
p99<-brick("Asi_p193r32_1999.grd")
p00<-brick("Asi_p193r32_2000.grd")
p02<-brick("Asi_p193r32_2002.grd")
p14<-brick("Asi_p193r32_2014.grd")
p15<-brick("Asi_p193r32_2015.grd")
p17<-brick("Asi_p193r32_2017.grd")
p18<-brick("Asi_p193r32_2018.grd")
p20<-brick("Asi_p193r32_2020.grd")

# Sono partito da un numero iniziale di 29 immagini, successivamente ho dovuto ridimensionare il dataset a 17 per le seguenti motivazioni:
# - utilizzo esclusivo di immagini con path 193 row 032
# - presenza eccessiva di nuvole
# - presenza di immagini che necessitavano elaborazioni più complesse o possibili correzioni atmosferiche

#######################################################
# 3. Where the magic begins

### 3.1 Rao's Q index ###
rao84<-spectralrao(p84, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao84, filename="Rao_84.grd", format="raster")
rao87<-spectralrao(p87, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao87, filename="Rao_87.grd", format="raster")
rao88<-spectralrao(p88, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao88, filename="Rao_88.grd", format="raster")
rao91<-spectralrao(p91, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao91, filename="Rao_91.grd", format="raster")
rao92<-spectralrao(p92, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao92, filename="Rao_92.grd", format="raster")
rao95<-spectralrao(p95, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao95, filename="Rao_95.grd", format="raster")
rao96<-spectralrao(p96, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao96, filename="Rao_96.grd", format="raster")
rao97<-spectralrao(p97, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao97, filename="Rao_97.grd", format="raster")
rao99<-spectralrao(p99, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao99, filename="Rao_99.grd", format="raster")
rao00<-spectralrao(p00, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao00, filename="Rao_00.grd", format="raster")
rao02<-spectralrao(p02, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao02, filename="Rao_02.grd", format="raster")
rao14<-spectralrao(p14, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao14, filename="Rao_14.grd", format="raster")
rao15<-spectralrao(p15, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao15, filename="Rao_15.grd", format="raster")
rao17<-spectralrao(p17, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao17, filename="Rao_17.grd", format="raster")
rao18<-spectralrao(p18, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao18, filename="Rao_18.grd", format="raster")
rao20<-spectralrao(p20, mode="multidimension", distance_m="euclidean", window=3, shannon=F)
writeRaster(rao20, filename="Rao_20.grd", format="raster")

# Importazione dei raster "Rao" con brick
rao84<-brick("Rao_84.grd")
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

# Ho usato la funzione aggregate() per accorpare i pixel dell'immagine al fine di migliorarne la rappresentazione grafica.
# Con le immagini originali infatti non si apprezzava il cambiamento dell'indice nel tempo.
rao84a<-aggregate(rao84, fact=10)
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


cl <- colorRampPalette(c("dark blue", "light blue", "red", "yellow"))(100)
diffrao<-rao87-rao20
plot(diffrao, col=cl, main="Rao's Q index's difference between 2020 and 1987")


### 3.2 NDVI
cl <- colorRampPalette(c("dark blue", "light blue", "red", "yellow"))(100)

nir84<-p84$p193r32_1984_SR_B4
nir87<-p87$p193r32_1987_SR_B4
nir88<-p88$p193r32_1988_SR_B4
nir91<-p91$p193r32_1991_SR_B4
nir92<-p92$p193r32_1992_SR_B4
nir95<-p95$p193r32_1995_SR_B4
nir96<-p96$p193r32_1996_SR_B4
nir97<-p97$p193r32_1997_SR_B4
nir99<-p99$p193r32_1999_SR_B4
nir00<-p00$p193r32_2000_SR_B4
nir02<-p02$p193r32_2002b_SR_B4
nir14<-p14$p193r32_2014_SR_B4
nir15<-p15$p193r32_2015_SR_B4
nir17<-p17$p193r32_2017_SR_B4
nir18<-p18$p193r32_2018_SR_B4
nir20<-p20$p193r32_2020_SR_B4

red84<-p84$p193r32_1984_SR_B3
red87<-p87$p193r32_1987_SR_B3
red88<-p88$p193r32_1988_SR_B3
red91<-p91$p193r32_1991_SR_B3
red92<-p92$p193r32_1992_SR_B3
red95<-p95$p193r32_1995_SR_B3
red96<-p96$p193r32_1996_SR_B3
red97<-p97$p193r32_1997_SR_B3
red99<-p99$p193r32_1999_SR_B3
red00<-p00$p193r32_2000_SR_B3
red02<-p02$p193r32_2002b_SR_B3
red14<-p14$p193r32_2014_SR_B3
red15<-p15$p193r32_2015_SR_B3
red17<-p17$p193r32_2017_SR_B3
red18<-p18$p193r32_2018_SR_B3
red20<-p20$p193r32_2020_SR_B3

ndvi84<-(nir84-red84)/(nir84+ red84)
ndvi87<-(nir87-red87)/(nir87+ red87)
ndvi88<-(nir88-red88)/(nir88+	red88)
ndvi91<-(nir91-red91)/(nir91+	red91)
ndvi92<-(nir92-red92)/(nir92+ red92)
ndvi95<-(nir95-red95)/(nir95+	red95)
ndvi96<-(nir96-red96)/(nir96+	red96)
ndvi97<-(nir97-red97)/(nir97+	red97)
ndvi99<-(nir99-red99)/(nir99+	red99)
ndvi00<-(nir00-red00)/(nir00+	red00)
ndvi02<-(nir02-red02)/(nir02+	red02)
ndvi14<-(nir14-red14)/(nir14+	red14)
ndvi15<-(nir15-red15)/(nir15+	red15)
ndvi17<-(nir17-red17)/(nir17+ red17)
ndvi18<-(nir18-red18)/(nir18+	red18)
ndvi20<-(nir20-red20)/(nir20+	red20)

diffndvi<-ndvi87-ndvi20
#cl <- colorRampPalette(c("dark blue", "light blue", "orange", "yellow"))(100)
plot(diffndvi, col=cl, main="NDVI's difference between 2020 and 1987")


### 3.3 PCA
p84pca <- rasterPCA(p84)
p87pca <- rasterPCA(p87)
p88pca <- rasterPCA(p88)
p91pca <- rasterPCA(p91)
p92pca <- rasterPCA(p92)
p95pca <- rasterPCA(p95)
p96pca <- rasterPCA(p96)
p97pca <- rasterPCA(p97)
p99pca <- rasterPCA(p99)
p00pca <- rasterPCA(p00)
p02pca <- rasterPCA(p02)
p14pca <- rasterPCA(p14)
p15pca <- rasterPCA(p15)
p17pca <- rasterPCA(p17)
p18pca <- rasterPCA(p18)
p20pca <- rasterPCA(p20)

p84pc1<-p84pca$map$PC1
p87pc1<-p87pca$map$PC1
p88pc1<-p88pca$map$PC1
p91pc1<-p91pca$map$PC1
p92pc1<-p92pca$map$PC1
p95pc1<-p95pca$map$PC1
p96pc1<-p96pca$map$PC1
p97pc1<-p97pca$map$PC1
p99pc1<-p99pca$map$PC1
p00pc1<-p00pca$map$PC1
p02pc1<-p02pca$map$PC1
p14pc1<-p14pca$map$PC1
p15pc1<-p15pca$map$PC1
p17pc1<-p17pca$map$PC1
p18pc1<-p18pca$map$PC1
p20pc1<-p20pca$map$PC1

#cl <- colorRampPalette(c("dark blue", "light blue", "red", "yellow"))(100)
diffpc1<-p87pc1-p20pc1
plot(diffpc1, col=cl, main"PC1's difference between 2020 and 1987")

par(mfrow=c(1,2))
plot(p92pc1, col=cl)
plot(p18pc1, col=cl)

### Land Cover

#######################################################
# 4. Analisi statistiche

### RAO'S Q


### NDVI
## Deviazione standard

ndvi84_sd3 <- focal(ndvi84,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi85_sd3 <- focal(ndvi85,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi87_sd3 <- focal(ndvi87,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi88_sd3 <- focal(ndvi88,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi91_sd3 <- focal(ndvi91,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi92_sd3 <- focal(ndvi92,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi95_sd3 <- focal(ndvi95,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi96_sd3 <- focal(ndvi96,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi97_sd3 <- focal(ndvi97,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi99_sd3 <- focal(ndvi99,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi00_sd3 <- focal(ndvi00,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi02_sd3 <- focal(ndvi02,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi14_sd3 <- focal(ndvi14,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi15_sd3 <- focal(ndvi15,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi17_sd3 <- focal(ndvi17,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi18_sd3 <- focal(ndvi18,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi20_sd3 <- focal(ndvi20,w=matrix(1/9, nrow=3, ncol=3), fun=sd)


## Media

ndvi84_m3 <- focal(ndvi84,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi87_m3 <- focal(ndvi87,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi88_m3 <- focal(ndvi88,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi91_m3 <- focal(ndvi91,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi92_m3 <- focal(ndvi92,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi95_m3 <- focal(ndvi95,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi96_m3 <- focal(ndvi96,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi97_m3 <- focal(ndvi97,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi99_m3 <- focal(ndvi99,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi00_m3 <- focal(ndvi00,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi02_m3 <- focal(ndvi02,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi14_m3 <- focal(ndvi14,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi15_m3 <- focal(ndvi15,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi17_m3 <- focal(ndvi17,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi18_m3 <- focal(ndvi18,w=matrix(1/9, nrow=3, ncol=3), fun=mean)
ndvi20_m3 <- focal(ndvi20,w=matrix(1/9, nrow=3, ncol=3), fun=mean)

### PCA
## Standard deviation of PC1

p84pc1_sd3<-focal(p84pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p87pc1_sd3<-focal(p87pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p88pc1_sd3<-focal(p88pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p91pc1_sd3<-focal(p91pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p92pc1_sd3<-focal(p92pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p95pc1_sd3<-focal(p95pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p96pc1_sd3<-focal(p96pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p97pc1_sd3<-focal(p97pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p99pc1_sd3<-focal(p99pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p00pc1_sd3<-focal(p00pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p02pc1_sd3<-focal(p02pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p14pc1_sd3<-focal(p14pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p15pc1_sd3<-focal(p15pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p17pc1_sd3<-focal(p17pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p18pc1_sd3<-focal(p18pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p20pc1_sd3<-focal(p20pc1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)






#######################################################
# 5 Export dei grafici in PDF

### Rao's Q index

pdf("Rao's_Q_full.pdf")
ggplot()+
geom_raster(rao84, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 1984")

ggplot()+
geom_raster(rao87, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 1987")

ggplot()+
geom_raster(rao88, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 1988")

ggplot()+
geom_raster(rao91, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 1991")

ggplot()+
geom_raster(rao92, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 1992")

ggplot()+
geom_raster(rao95, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 1995")

ggplot()+
geom_raster(rao96, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 1996")

ggplot()+
geom_raster(rao97, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 1997")

ggplot()+
geom_raster(rao99, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 1999")

ggplot()+
geom_raster(rao00, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 2000")

ggplot()+
geom_raster(rao02, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 2002")


ggplot()+
geom_raster(rao14, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 2014")


ggplot()+
geom_raster(rao15, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 2015")


ggplot()+
geom_raster(rao17, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 2017")

ggplot()+
geom_raster(rao18, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 2018")

ggplot()+
geom_raster(rao20, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Rao's Q index, Asinara 2020")
dev.off()


### NDVI

pdf("NDVI.pdf")
ggplot()+
geom_raster(ndvi84, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 1984")

ggplot()+
geom_raster(ndvi87, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 1987")

ggplot()+
geom_raster(ndvi88, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 1988")

ggplot()+
geom_raster(ndvi91, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 1991")

ggplot()+
geom_raster(ndvi92, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 1992")

ggplot()+
geom_raster(ndvi95, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 1995")

ggplot()+
geom_raster(ndvi96, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 1996")

ggplot()+
geom_raster(ndvi97, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 1997")

ggplot()+
geom_raster(ndvi99, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 1999")

ggplot()+
geom_raster(ndvi00, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 2000")

ggplot()+
geom_raster(ndvi02, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 2002")

ggplot()+
geom_raster(ndvi14, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 2014")

ggplot()+
geom_raster(ndvi15, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 2015")

ggplot()+
geom_raster(ndvi17, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 2017")

ggplot()+
geom_raster(ndvi18, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 2018")

ggplot()+
geom_raster(ndvi20, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 2020")
dev.off()

### Standard deviation of NDVI

pdf("Standard_deviaion_NDVI.pdf")
ggplot()+
geom_raster(ndvi84_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 1984")

ggplot()+
geom_raster(ndvi87_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 1987")

ggplot()+
geom_raster(ndvi88_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 1988")

ggplot()+
geom_raster(ndvi91_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 1991")

ggplot()+
geom_raster(ndvi92_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 1992")

ggplot()+
geom_raster(ndvi95_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 1995")

ggplot()+
geom_raster(ndvi96_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 1996")

ggplot()+
geom_raster(ndvi97_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 1997")

ggplot()+
geom_raster(ndvi99_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 1999")

ggplot()+
geom_raster(ndvi00_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 2000")

ggplot()+
geom_raster(ndvi02_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 2002")

ggplot()+
geom_raster(ndvi14_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 2014")

ggplot()+
geom_raster(ndvi15_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 2015")

ggplot()+
geom_raster(ndvi17_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 2017")

ggplot()+
geom_raster(ndvi18_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 2018")

ggplot()+
geom_raster(ndvi20_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of NDVI Asinara 2020")
dev.off()

### PCA

pdf("PC1.pdf")
ggplot()+
geom_raster(p84pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 1984")

ggplot()+
geom_raster(p87pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 1987")

ggplot()+
geom_raster(p88pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 1988")

ggplot()+
geom_raster(p91pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 1991")

ggplot()+
geom_raster(p92pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 1992")

ggplot()+
geom_raster(p95pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 1995")

ggplot()+
geom_raster(p96pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 1996")

ggplot()+
geom_raster(p97pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 1997")

ggplot()+
geom_raster(p99pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 1999")

ggplot()+
geom_raster(p00pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 2000")

ggplot()+
geom_raster(p02pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 2002")

ggplot()+
geom_raster(p14pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 2014")

ggplot()+
geom_raster(p15pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 2015")

ggplot()+
geom_raster(p17pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 2017")

ggplot()+
geom_raster(p18pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 2018")

ggplot()+
geom_raster(p20pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PC1 Asinara 2020")
dev.off()

## Standard deviation of PC1

pdf("Standard_deviation_PC1.pdf")
ggplot()+
geom_raster(p84pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 1984")

ggplot()+
geom_raster(p87pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 1987")

ggplot()+
geom_raster(p88pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 1988")

ggplot()+
geom_raster(p91pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 1991")

ggplot()+
geom_raster(p92pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 1992")

ggplot()+
geom_raster(p95pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 1995")

ggplot()+
geom_raster(p96pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 1996")

ggplot()+
geom_raster(p97pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 1997")

ggplot()+
geom_raster(p99pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 1999")

ggplot()+
geom_raster(p00pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 2000")

ggplot()+
geom_raster(p02pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 2002")

ggplot()+
geom_raster(p14pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 2014")

ggplot()+
geom_raster(p15pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 2015")

ggplot()+
geom_raster(p17pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 2017")

ggplot()+
geom_raster(p18pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 2018")

ggplot()+
geom_raster(p20pc1_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 Asinara 2020")
dev.off()


