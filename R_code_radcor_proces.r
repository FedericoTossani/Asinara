################################################
#### Radiometric Correction and Calibration ####
################################################

#this code is a copy from the example in the radCor function page (https://www.rdocumentation.org/packages/RStoolbox/versions/0.2.6/topics/radCor)

library(raster)
library(RStoolbox)
setwd("/Users/federicotossani/Asinara/L_image/LC08_L2SP_193032_20140407")

alist14<-list.files(pattern="SR_B")
import14<-lapply(alist14, raster)
p193r32_2014<-stack(import14)

p193r32_2014_cor <- radCor(p193r32_2014, /Users/federicotossani/Asinara/L_image/LC08_L2SP_193032_20140407/LC08_L2SP_193032_20140407_20200911_02_T1_MTL.txt, method = "apref")


########
# trovare il modo di importare mtl file in R
# la funzione mi da errore sia con il path che con il codice qua sotto
########

## Import meta-data and bands based on MTL file
mtlFile  <- system.file("/Users/federicotossani/Asinara/L_image/LC08_L2SP_193032_20140407/LC08_L2SP_193032_20140407_20200911_02_T1_MTL.txt", package="RStoolbox")
metaData <- readMeta(mtlFile)

lsat     <- stackMeta(mtlFile)

## Convert DN to top of atmosphere reflectance and brightness temperature
lsat_ref <- radCor(lsat, metaData = metaData, method = "apref")

## Correct DN to at-surface-reflecatance with DOS (Chavez decay model)

lsat_sref <- radCor(lsat, metaData = metaData, method = "dos")

## Correct DN to at-surface-reflecatance with simple DOS 
## Automatic haze estimation
hazeDN    <- estimateHaze(lsat, hazeBands = 1:4, darkProp = 0.01, plot = TRUE)
lsat_sref <- radCor(lsat, metaData = metaData, method = "sdos", hazeValues = hazeDN, hazeBands = 1:4)
