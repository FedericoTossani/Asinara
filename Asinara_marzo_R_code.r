require(raster)
require(rgdal)
require(RStoolbox)
require(rasterdiv)
require(rasterVis)
require(ggplot2)
require(gridExtra)
require(viridis)
require(purrr)
setwd("/Users/federicotossani/Asinara/L_image_mar")
source("/Users/federicotossani/Asinara/spectralrao.r")

### Import

p87<-raster("Asi_p193r32_1987.grd")
p88<-raster("Asi_p193r32_1988.grd")
p90<-raster("Asi_p193r32_1990.grd")
p94<-raster("Asi_p193r32_1994.grd")
p99<-raster("Asi_p193r32_1999.grd")
p02<-raster("Asi_p193r32_2002.grd")
p09<-raster("Asi_p193r32_2009.grd")
p14<-raster("Asi_p193r32_2014.grd")
p17<-raster("Asi_p193r32_2017B.grd")
p19<-raster("Asi_p193r32_2019.grd")
p21<-raster("Asi_p193r32_2021.grd")

p87<-brick("Asi_p193r32_1987.grd")
p88<-brick("Asi_p193r32_1988.grd")
p90<-brick("Asi_p193r32_1990.grd")
p94<-brick("Asi_p193r32_1994.grd")
p99<-brick("Asi_p193r32_1999.grd")
p02<-brick("Asi_p193r32_2002.grd")
p09<-brick("Asi_p193r32_2009.grd")
p14<-brick("Asi_p193r32_2014.grd")
p17<-brick("Asi_p193r32_2017B.grd")
p19<-brick("Asi_p193r32_2019.grd")
p21<-brick("Asi_p193r32_2021.grd")

### NDVI

nir87<-p87$P193R32_1987_SR_B4
nir88<-p88$P193R32_1988_SR_B4
nir90<-p90$P193R32_1990_SR_B4
nir94<-p94$P193R32_1994_SR_B4
nir99<-p99$P193R32_1999_SR_B4
nir02<-p02$P193R32_2002_SR_B4
nir09<-p09$P193R32_2009_SR_B4
nir14<-p14$P193R32_2014_SR_B4
nir17<-p17$P193R32_2017B_SR_B4
nir19<-p19$P193R32_2019_SR_B4
nir21<-p21$P193R32_2021_SR_B4

red87<-p87$P193R32_1987_SR_B3
red88<-p88$P193R32_1988_SR_B3
red90<-p90$P193R32_1990_SR_B3
red94<-p94$P193R32_1994_SR_B3
red99<-p99$P193R32_1999_SR_B3
red02<-p02$P193R32_2002_SR_B3
red09<-p09$P193R32_2009_SR_B3
red14<-p14$P193R32_2014_SR_B3
red17<-p17$P193R32_2017B_SR_B3
red19<-p19$P193R32_2019_SR_B3
red21<-p21$P193R32_2021_SR_B3

ndvi87	<-	(nir87-red87)/(nir87+ red87)
ndvi88	<-	(nir88-red88)/(nir88+	red88)
ndvi90	<-	(nir90-red90)/(nir90+	red90)
ndvi94	<-	(nir94-red94)/(nir94+	red94)
ndvi99	<-	(nir99-red99)/(nir99+	red99)
ndvi02	<-	(nir02-red02)/(nir02+	red02)
ndvi09	<-	(nir09-red09)/(nir09+	red09)
ndvi14	<-	(nir14-red14)/(nir14+	red14)
ndvi17	<-	(nir17-red17)/(nir17+ red17)
ndvi19	<-	(nir19-red19)/(nir19+	red19)
ndvi21	<-	(nir21-red21)/(nir21+	red21)


### PCA

p87pca <- rasterPCA(p87)
p88pca <- rasterPCA(p88)
p90pca <- rasterPCA(p90)
p94pca <- rasterPCA(p94)
p99pca <- rasterPCA(p99)
p02pca <- rasterPCA(p02)
p09pca <- rasterPCA(p09)
p14pca <- rasterPCA(p14)
p17pca <- rasterPCA(p17)
p19pca <- rasterPCA(p19)
p21pca <- rasterPCA(p21)

p87pc1<-p87pca$map$PC1
p88pc1<-p88pca$map$PC1
p90pc1<-p90pca$map$PC1
p94pc1<-p94pca$map$PC1
p99pc1<-p99pca$map$PC1
p02pc1<-p02pca$map$PC1
p09pc1<-p09pca$map$PC1
p14pc1<-p14pca$map$PC1
p17pc1<-p17pca$map$PC1
p19pc1<-p19pca$map$PC1
p21pc1<-p21pca$map$PC1

### PDF creator

pdf("NDVI.pdf")
ggplot()+
geom_raster(ndvi87, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 1987")

ggplot()+
geom_raster(ndvi88, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 1988")

ggplot()+
geom_raster(ndvi90, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 1990")

ggplot()+
geom_raster(ndvi94, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 1994")

ggplot()+
geom_raster(ndvi99, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 1999")

ggplot()+
geom_raster(ndvi02, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 2002")

ggplot()+
geom_raster(ndvi09, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 2009")

ggplot()+
geom_raster(ndvi14, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 2014")

ggplot()+
geom_raster(ndvi17, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 2017")

ggplot()+
geom_raster(ndvi19, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 2019")

ggplot()+
geom_raster(ndvi21, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("NDVI Asinara 2021")
dev.off()


pdf("PCA.pdf")
ggplot()+
geom_raster(p87pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PCA Asinara 1987")

ggplot()+
geom_raster(p88pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PCA Asinara 1988")

ggplot()+
geom_raster(p90pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PCA Asinara 1990")

ggplot()+
geom_raster(p94pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PCA Asinara 1994")

ggplot()+
geom_raster(p99pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PCA Asinara 1999")

ggplot()+
geom_raster(p02pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PCA Asinara 2002")

ggplot()+
geom_raster(p09pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PCA Asinara 2009")

ggplot()+
geom_raster(p14pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PCA Asinara 2014")

ggplot()+
geom_raster(p17pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PCA Asinara 2017")

ggplot()+
geom_raster(p19pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PCA Asinara 2019")

ggplot()+
geom_raster(p21pc1, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("PCA Asinara 2021")
dev.off()

























