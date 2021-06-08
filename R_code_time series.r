###############################
#### Asinara's time series ####
###############################

library(raster)
library(rasterVis)
setwd("/Users/federicotossani/Asinara/L_image/LC08_L2SP_193032_20140407")

alist14<-list.files(pattern="SR_B")
import14<-lapply(alist14, raster)
p193r32_2014<-stack(import14)

#questa serie di funzioni la ripeto per le 9 immagini:

### 2013 ###
setwd("/Users/federicotossani/Asinara/L_image/LC08_L2SP_193032_20130420")
alist13<-list.files(pattern="SR_B")
import13<-lapply(alist13, raster)
p193r32_2013<-stack(import13)

### 2015 ###
setwd("/Users/federicotossani/Asinara/L_image/LC08_L2SP_193032_20150410")
alist15<-list.files(pattern="SR_B")
import15<-lapply(alist15, raster)
p193r32_2015<-stack(import15)

### 2016 ###
setwd("/Users/federicotossani/Asinara/L_image/LC08_L2SP_193032_20160412")
alist16<-list.files(pattern="SR_B")
import16<-lapply(alist16, raster)
p193r32_2016<-stack(import16)

### 2017 ###
setwd("/Users/federicotossani/Asinara/L_image/LC08_L2SP_193032_20170415")
alist17<-list.files(pattern="SR_B")
import17<-lapply(alist17, raster)
p193r32_2017<-stack(import17)

### 2018 ###
setwd("/Users/federicotossani/Asinara/L_image/LC08_L2SP_193032_20180402")
alist18<-list.files(pattern="SR_B")
import18<-lapply(alist18, raster)
p193r32_2018<-stack(import18)

### 2019 ###
setwd("/Users/federicotossani/Asinara/L_image/LC08_L2SP_193032_20190421")
alist19<-list.files(pattern="SR_B")
import19<-lapply(alist19, raster)
p193r32_2019<-stack(import19)

### 2020 ###
setwd("/Users/federicotossani/Asinara/L_image/LC08_L2SP_193032_20200407")
alist20<-list.files(pattern="SR_B")
import20<-lapply(alist20, raster)
p193r32_2020<-stack(import20)

### 2021 ###
setwd("/Users/federicotossani/Asinara/L_image/LC08_L2SP_193032_20210426")
alist21<-list.files(pattern="SR_B")
import21<-lapply(alist21, raster)
p193r32_2021<-stack(import21)

#a questo punto abbiamo le immagini composte dalle 7 bande Landsat dal 2013-2021

#plot dell'immagine e crop per avere lo zoom sull'Asinara
plotRGB(p193r32_2014, 4, 3, 2, stretch="lin") #immagine completa

#ora uso la funzione crop per tagliare l'immagine e fare lo zoom sull'area di interesse
#extent     : 425985, 449085, 4532895, 4557075  (xmin, xmax, ymin, ymax)
#extent     : 429435, 448155, 4531395, 4557645  (xmin, xmax, ymin, ymax)
p193r32_2014c<-crop(p193r32_2014, extent(425985, 449085, 4532895, 4557075))

plotRGB(p193r32_2014c, 5,3,2, stretch="lin")

