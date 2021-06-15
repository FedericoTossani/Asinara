#################
#### Asinara ####
#################

# progetto per l'esame di Telerilevamento geo_ecologico

# Analisi da remoto della vegetaione del Parco Nazionale dell'Asinara
# Il dataset di immagini Landsat copre il periodo dal 1984 al 2021.
# Tot. img: 28
# Anni mancanti: 1986, 1994, 1998, 2004, 2005, 2008, 2009, 2011, 2012
# Obiettivo: valutare il cambiamento della vegetazione dopo la chiusura del carcere e la fine della manutenzione agricola dell'isola

#################
#### Summary #### 
#################

# 1. Library & Working directory
# 2. Preparazione dataset
#  2.1 Estensione del crop
#  2.2 Importazione delle bande e creazione rasterBrick
#  2.3 Importazione dei rasterBrick
# 3. Studio della vaiabilità


########################################
#### 1. Library & Working directory ####
########################################

require(raster)
require(rgdal)
require(RStoolbox)
require(rasterdiv)
require(rasterVis)
require(ggplot2)
require(gridExtra)
setwd("/Users/federicotossani/Asinara/L_image")

#################################
#### 2. Preparazione dataset ####
#################################

### 2.1 Estensione del crop ###

# per ottenre il giusto crop dell'immagine ho usato la funzione draw.extent per disegnare l'area da tagliare sul plot dell'immagine a colori naturali.
# essendo che per coprire gli anni studiati ho dovuto usare due diverse immagini, p193r32 e p194r31 l'operazione di crop è stata fatta due volte.
# NB. le due immagini qui plottate sono state precedentemente importate con i comandi4

### p193r32 ###
#p84 <- plotRGB(p84t, 3, 2, 1, stretch="lin")
#drawExtent(show=TRUE, col="red")
#class      : Extent 
#xmin       : 431858.1 
#xmax       : 445713 
#ymin       : 4532960 
#ymax       : 4552802 

### p194r31 ###
#p03 <- plotRGB(p03t, 3, 2, 1, stretch="lin")
#drawExtent(show=TRUE, col="red")
#class      : Extent 
#xmin       : 432846.3 
#xmax       : 445918.7 
#ymin       : 4534674 
#ymax       : 4553130 

### 2.2 Importazione delle immagini e creazione rasterBrick ###

# Ho usato queste funzioni per accorpare tutte le bande in un unico raster la prima volta che ho scaricato e importato le immagini.
# Nelle successive analisi ho caricato i file direttamente dal punto 2.3.

## 1984 ##
list84<-list.files(pattern="1984")
import84<-lapply(list84, raster)
p84t<-stack(import84)
p84<-crop(p84t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p84, filename="Asi_p193r32_1984.grd", format="raster")

## 1985 ##
list85<-list.files(pattern="1985")
import85<-lapply(list85, raster)
p85t<-stack(import85)
p85<-crop(p85t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p85, filename="Asi_p193r32_1985.grd", format="raster")

## 1987 ##
list87<-list.files(pattern="1987")
import87<-lapply(list87, raster)
p87t<-stack(import87)
p87<-crop(p87t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p87, filename="Asi_p193r32_1987.grd", format="raster")

## 1988 ##
list88<-list.files(pattern="1988")
import88<-lapply(list88, raster)
p88t<-stack(import88)
p88<-crop(p88t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p88, filename="Asi_p193r32_1988.grd", format="raster")

## 1989 ##
list89<-list.files(pattern="1989")
import89<-lapply(list89, raster)
p89t<-stack(import89)
p89<-crop(p89t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p89, filename="Asi_p193r32_1989.grd", format="raster")

## 1990 ##
list90<-list.files(pattern="1990")
import90<-lapply(list90, raster)
p90t<-stack(import90)
p90<-crop(p90t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p90, filename="Asi_p193r32_1990.grd", format="raster")

## 1991 ##
list91<-list.files(pattern="1991")
import91<-lapply(list91, raster)
p91t<-stack(import91)
p91<-crop(p91t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p91, filename="Asi_p193r32_1991.grd", format="raster")

## 1992 ##
list92<-list.files(pattern="1992")
import92<-lapply(list92, raster)
p92t<-stack(import92)
p92<-crop(p92t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p92, filename="Asi_p193r32_1992.grd", format="raster")

## 1993 ##
list93<-list.files(pattern="1993")
import93<-lapply(list93, raster)
p93t<-stack(import93)
p93<-crop(p93t, extent(432846.3, 445918.7, 4534674, 4553130))
writeRaster(p93, filename="asi_p194r31_1993.grd", format="raster")

## 1995 ##
list95<-list.files(pattern="1995")
import95<-lapply(list95, raster)
p95t<-stack(import95)
p95<-crop(p95t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p95, filename="Asi_p193r32_1995.grd", format="raster")

## 1996 ##
list96<-list.files(pattern="1996")
import96<-lapply(list96, raster)
p96t<-stack(import96)
p96<-crop(p96t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p96, filename="Asi_p193r32_1996.grd", format="raster")

## 1997 ##
list97<-list.files(pattern="1997")
import97<-lapply(list97, raster)
p97t<-stack(import97)
p97<-crop(p97t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p97, filename="Asi_p193r32_1997.grd", format="raster")

## 1999 ##
list99<-list.files(pattern="1999")
import99<-lapply(list99, raster)
p99t<-stack(import99)
p99<-crop(p99t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p99, filename="Asi_p193r32_1999.grd", format="raster")

## 2000 ##
list00<-list.files(pattern="2000")
import00<-lapply(list00, raster)
p00t<-stack(import00)
p00<-crop(p00t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p00, filename="Asi_p193r32_2000.grd", format="raster")

## 2001 ##
list01<-list.files(pattern="2001")
import01<-lapply(list01, raster)
p01t<-stack(import01)
p01<-crop(p01t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p01, filename="Asi_p193r32_2001.grd", format="raster")

## 2002 ##
list02<-list.files(pattern="2002b")
import02<-lapply(list02, raster)
p02t<-stack(import02)
p02<-crop(p02t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p02, filename="Asi_p193r32_2002.grd", format="raster")

## 2003 ##
list03<-list.files(pattern="2003")
import03<-lapply(list03, raster)
p03t<-stack(import03)
p03<-crop(p03t, extent(432846.3, 445918.7, 4534674, 4553130))
writeRaster(p03, filename="asi_p194r31_2003.grd", format="raster")

## 2006 ##
list06<-list.files(pattern="2006")
import06<-lapply(list06, raster)
p06t<-stack(import06)
p06<-crop(p06t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p06, filename="Asi_p193r32_2006.grd", format="raster")

## 2007 ##
list07<-list.files(pattern="2007")
import07<-lapply(list07, raster)
p07t<-stack(import07)
p07<-crop(p07t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p07, filename="Asi_p193r32_2007.grd", format="raster")

## 2010 ##
list10<-list.files(pattern="2010")
import10<-lapply(list10, raster)
p10t<-stack(import10)
p10<-crop(p10t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p10, filename="Asi_p193r32_2010.grd", format="raster")

## 2013 ##
list13<-list.files(pattern="2013")
import13<-lapply(list13, raster)
p13t<-stack(import13)
p13<-crop(p13t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p13, filename="Asi_p193r32_2013.grd", format="raster")

## 2014 ##
list14<-list.files(pattern="2014")
import14<-lapply(list14, raster)
p14t<-stack(import14)
p14<-crop(p14t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p14, filename="Asi_p193r32_2014.grd", format="raster")

## 2015 ##
list15<-list.files(pattern="2015")
import15<-lapply(list15, raster)
p15t<-stack(import15)
p15<-crop(p15t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p15, filename="Asi_p193r32_2015.grd", format="raster")

## 2016 ##
list16<-list.files(pattern="2016")
import16<-lapply(list16, raster)
p16t<-stack(import16)
p16<-crop(p16t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p16, filename="Asi_p193r32_2016.grd", format="raster")

## 2017 ##
list17<-list.files(pattern="2017")
import17<-lapply(list17, raster)
p17t<-stack(import17)
p17<-crop(p17t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p17, filename="Asi_p193r32_2017.grd", format="raster")

## 2018 ##
list18<-list.files(pattern="2018")
import18<-lapply(list18, raster)
p18t<-stack(import18)
p18<-crop(p18t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p18, filename="Asi_p193r32_2018.grd", format="raster")

## 2019 ##
list19<-list.files(pattern="2019")
import19<-lapply(list19, raster)
p19t<-stack(import19)
p19<-crop(p19t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p19, filename="Asi_p193r32_2019.grd", format="raster")

## 2020 ##
list20<-list.files(pattern="2020")
import20<-lapply(list20, raster)
p20t<-stack(import20)
p20<-crop(p20t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p20, filename="Asi_p193r32_2020.grd", format="raster")

## 2021 ##
list21<-list.files(pattern="2021")
import21<-lapply(list21, raster)
p21t<-stack(import21)
p21<-crop(p21t, extent(431858.1, 445713, 4532960, 4552802))
writeRaster(p21, filename="Asi_p193r32_2021.grd", format="raster")

### Impacchettamento
asilist<-list.files(pattern="Asi_")
asimport<-lapply(asilist, brick)
asinara<-stack(asimport)

# Importare tutte le immagine con la funzione lapply non funziona, o meglio, diventa un file troppo pesante che il computer non riesce ad aprire.


# Elenco immagini 
# p84, p85, p87, p88, p89, p90, p91, p92, p93, p95, p96, p97, p99, p00, p01, p02, p03, p06, p07, p10, p13, p14, p15, p16, p17, p18, p19, p20, p21
# Elenco plot
# p84p, p85p, p87p, p88p, p89p, p90p, p91p, p92p, p93p, p95p, p96p, p97p, p99p, p00p, p01p, p02p, p03p, p06p, p07p, p10p, p13p, p14p, p15p, p16p, p17p, p18p, p19p, p20p, p21p

### 2.3 importazione dei rasterBrick ###

p84<-brick("Asi_p193r32_1984.grd")
p85<-brick("Asi_p193r32_1985.grd")
p87<-brick("Asi_p193r32_1987.grd")
p88<-brick("Asi_p193r32_1988.grd")
p89<-brick("Asi_p193r32_1989.grd")
p90<-brick("Asi_p193r32_1990.grd")
p91<-brick("Asi_p193r32_1991.grd")
p92<-brick("Asi_p193r32_1992.grd")
p95<-brick("Asi_p193r32_1995.grd")
p96<-brick("Asi_p193r32_1996.grd")
p97<-brick("Asi_p193r32_1997.grd")
p99<-brick("Asi_p193r32_1999.grd")
p00<-brick("Asi_p193r32_2000.grd")
p01<-brick("Asi_p193r32_2001.grd")
p02<-brick("Asi_p193r32_2002.grd")
p06<-brick("Asi_p193r32_2006.grd")
p07<-brick("Asi_p193r32_2007.grd")
p10<-brick("Asi_p193r32_2010.grd")
p13<-brick("Asi_p193r32_2013.grd")
p14<-brick("Asi_p193r32_2014.grd")
p15<-brick("Asi_p193r32_2015.grd")
p16<-brick("Asi_p193r32_2016.grd")
p17<-brick("Asi_p193r32_2017.grd")
p18<-brick("Asi_p193r32_2018.grd")
p19<-brick("Asi_p193r32_2019.grd")
p20<-brick("Asi_p193r32_2020.grd")
p21<-brick("Asi_p193r32_2021.grd")


asilist<-list.files(pattern="Asi_")
asimport<-lapply(asilist, brick)
asinara<-stack(asimport)


nir84<-p84$p193r32_1984_SR_B4
nir85<-p85$p193r32_1985_SR_B4
#nir86<-p86$p193r32_1986_SR_B4
nir87<-p87$p193r32_1987_SR_B4
nir88<-p88$p193r32_1988_SR_B4
nir89<-p89$p193r32_1989_SR_B4
nir90<-p90$p193r32_1990_SR_B4
nir91<-p91$p193r32_1991_SR_B4
nir92<-p92$p193r32_1992_SR_B4
#nir93<-p93$p193r32_1993_SR_B4
#nir94<-p94$p193r32_1994_SR_B4
nir95<-p95$p193r32_1995_SR_B4
nir96<-p96$p193r32_1996_SR_B4
nir97<-p97$p193r32_1997_SR_B4
#nir98<-p98$p193r32_1998_SR_B4
nir99<-p99$p193r32_1999_SR_B4
nir00<-p00$p193r32_2000_SR_B4
nir01<-p01$p193r32_2001_SR_B4
nir02<-p02$p193r32_2002b_SR_B4
#nir03<-p03$p193r32_2003_SR_B4
#nir04<-p04$p193r32_2004_SR_B4
#nir05<-p05$p193r32_2005_SR_B4
nir06<-p06$p193r32_2006_SR_B4
nir07<-p07$p193r32_2007_SR_B4
#nir08<-p08$p193r32_2008_SR_B4
#nir09<-p09$p193r32_2009_SR_B4
nir10<-p10$p193r32_2010_SR_B4
#nir11<-p11$p193r32_2011_SR_B4
#nir12<-p12$p193r32_2012_SR_B4
nir13<-p13$p193r32_2013_SR_B4
nir14<-p14$p193r32_2014_SR_B4
nir15<-p15$p193r32_2015_SR_B4
nir16<-p16$p193r32_2016_SR_B4
nir17<-p17$p193r32_2017_SR_B4
nir18<-p18$p193r32_2018_SR_B4
nir19<-p19$p193r32_2019_SR_B4
nir20<-p20$p193r32_2020_SR_B4
nir21<-p21$p193r32_2021_SR_B4


red84	<-	p84$p193r32_1984_SR_B3
red85	<-	p85$p193r32_1985_SR_B3
#red86	<-	p86$p193r32_1986_SR_B3
red87	<-	p87$p193r32_1987_SR_B3
red88	<-	p88$p193r32_1988_SR_B3
red89	<-	p89$p193r32_1989_SR_B3
red90	<-	p90$p193r32_1990_SR_B3
red91	<-	p91$p193r32_1991_SR_B3
red92	<-	p92$p193r32_1992_SR_B3
#red93	<-	p93$p193r32_1993_SR_B3
#red94	<-	p94$p193r32_1994_SR_B3
red95	<-	p95$p193r32_1995_SR_B3
red96	<-	p96$p193r32_1996_SR_B3
red97	<-	p97$p193r32_1997_SR_B3
#red98	<-	p98$p193r32_1998_SR_B3
red99	<-	p99$p193r32_1999_SR_B3
red00	<-	p00$p193r32_2000_SR_B3
red01	<-	p01$p193r32_2001_SR_B3
red02	<-	p02$p193r32_2002b_SR_B3
#red03	<-	p03$p193r32_2003_SR_B3
#red04	<-	p04$p193r32_2004_SR_B3
#red05	<-	p05$p193r32_2005_SR_B3
red06	<-	p06$p193r32_2006_SR_B3
red07	<-	p07$p193r32_2007_SR_B3
#red08	<-	p08$p193r32_2008_SR_B3
#red09	<-	p09$p193r32_2009_SR_B3
red10	<-	p10$p193r32_2010_SR_B3
#red11	<-	p11$p193r32_2011_SR_B3
#red12	<-	p12$p193r32_2012_SR_B3
red13	<-	p13$p193r32_2013_SR_B3
red14	<-	p14$p193r32_2014_SR_B3
red15	<-	p15$p193r32_2015_SR_B3
red16	<-	p16$p193r32_2016_SR_B3
red17	<-	p17$p193r32_2017_SR_B3
red18	<-	p18$p193r32_2018_SR_B3
red19	<-	p19$p193r32_2019_SR_B3
red20	<-	p20$p193r32_2020_SR_B3
red21	<-	p21$p193r32_2021_SR_B3


ndvi84	<-	(nir84-red84)/(nir84+ red84)
ndvi85	<-	(nir85-red85)/(nir85+	red85)
#ndvi86	<-	(nir86-red86)/(nir86+	red86)
ndvi87	<-	(nir87-red87)/(nir87+ red87)
ndvi88	<-	(nir88-red88)/(nir88+	red88)
ndvi89	<-	(nir89-red89)/(nir89+	red89)
ndvi90	<-	(nir90-red90)/(nir90+	red90)
ndvi91	<-	(nir91-red91)/(nir91+	red91)
ndvi92	<-	(nir92-red92)/(nir92+ red92)
#ndvi93	<-	(nir93-red93)/(nir93+	red93)
#ndvi94	<-	(nir94-red94)/(nir94+	red94)
ndvi95	<-	(nir95-red95)/(nir95+	red95)
ndvi96	<-	(nir96-red96)/(nir96+	red96)
ndvi97	<-	(nir97-red97)/(nir97+	red97)
#ndvi98	<-	(nir98-red98)/(nir98+	red98)
ndvi99	<-	(nir99-red99)/(nir99+	red99)
ndvi00	<-	(nir00-red00)/(nir00+	red00)
ndvi01	<-	(nir01-red01)/(nir01+	red01)
ndvi02	<-	(nir02-red02)/(nir02+	red02)
#ndvi03	<-	(nir03-red03)/(nir03+	red03)
#ndvi04	<-	(nir04-red04)/(nir04+	red04)
#ndvi05	<-	(nir05-red05)/(nir05+	red05)
ndvi06	<-	(nir06-red06)/(nir06+	red06)
ndvi07	<-	(nir07-red07)/(nir07+	red07)
#ndvi08	<-	(nir08-red08)/(nir08+	red08)
#ndvi09	<-	(nir09-red09)/(nir09+	red09)
ndvi10	<-	(nir10-red10)/(nir10+	red10)
#ndvi11	<-	(nir11-red11)/(nir11+	red11)
#ndvi12	<-	(nir12-red12)/(nir12+	red12)
ndvi13	<-	(nir13-red13)/(nir13+	red13)
ndvi14	<-	(nir14-red14)/(nir14+	red14)
ndvi15	<-	(nir15-red15)/(nir15+	red15)
ndvi16	<-	(nir16-red16)/(nir16+	red16)
ndvi17	<-	(nir17-red17)/(nir17+ red17)
ndvi18	<-	(nir18-red18)/(nir18+	red18)
ndvi19	<-	(nir19-red19)/(nir19+	red19)
ndvi20	<-	(nir20-red20)/(nir20+	red20)
ndvi21	<-	(nir21-red21)/(nir21+	red21)

par(mfrow=c(3,3))
plot(ndvi84)
plot(ndvi88)
plot(ndvi91)
plot(ndvi96)
plot(ndvi00)
plot(ndvi07)
plot(ndvi14)
plot(ndvi16)
plot(ndvi19)

ndvi84_sd3 <- focal(ndvi84,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi88_sd3 <- focal(ndvi88,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi91_sd3 <- focal(ndvi91,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi96_sd3 <- focal(ndvi96,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi00_sd3 <- focal(ndvi00,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi07_sd3 <- focal(ndvi07,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi14_sd3 <- focal(ndvi14,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi16_sd3 <- focal(ndvi16,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
ndvi19_sd3 <- focal(ndvi19,w=matrix(1/9, nrow=3, ncol=3), fun=sd)


par(mfrow=c(3,3))
plot(ndvi84_sd3)
plot(ndvi88_sd3)
plot(ndvi91_sd3)
plot(ndvi96_sd3)
plot(ndvi00_sd3)
plot(ndvi07_sd3)
plot(ndvi14_sd3)
plot(ndvi16_sd3)
plot(ndvi19_sd3)


p84pca <- rasterPCA(p84)
p88pca <- rasterPCA(p88)
p91pca <- rasterPCA(p91)
p96pca <- rasterPCA(p96)
p00pca <- rasterPCA(p00)
p07pca <- rasterPCA(p07)
p14pca <- rasterPCA(p14)
p19pca <- rasterPCA(p19)

p84pc1<-p84pca$map$PC1
p88pc1<-p88pca$map$PC1
p91pc1<-p91pca$map$PC1
p96pc1<-p96pca$map$PC1
p00pc1<-p00pca$map$PC1
p07pc1<-p07pca$map$PC1
p14pc1<-p14pca$map$PC1
p19pc1<-p19pca$map$PC1


par(mfrow=c(2,2))
plot(p84pca$map$PC1)
plot(p91pca$map$PC1)
plot(p07pca$map$PC1)
plot(p14pca$map$PC1)


par(mfrow=c(3,3))
plot(p84pca$map$PC1)
plot(p88pca$map$PC1)
plot(p91pca$map$PC1)
plot(p96pca$map$PC1)
plot(p00pca$map$PC1)
plot(p07pca$map$PC1)
plot(p14pca$map$PC1)
plot(p19pca$map$PC1)


p84pc1<-p84pca$map$PC1
p15pc1<-p15pca$map$PC1

p84pca_sd3 <- focal(p84pc1,w=matrix(1/9, nrow=3, ncol=3), fun=sd)
p15pca_sd3 <- focal(p15pc1,w=matrix(1/9, nrow=3, ncol=3), fun=sd)

p1<-ggplot()+
geom_raster(p84pca_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 by viridis color scale")


clp<-colorRampPalette(c("purple","dark blue","blue","green","yellow"))
par(mfrow=c(1,2))
plot(p84pc1, col=clp)
plot(p15pc1, col=clp)




p2<-ggplot()+
geom_raster(p15pca_sd3, mapping=aes(x = x, y = y, fill = layer))+
scale_fill_viridis()+
ggtitle("Standard deviation of PC1 by viridis color scale")

grid.arrange(p1, p2, nrow=1)


nir<-sentinel$sentinel.1
red<-sentinel$sentinel.2
ndvi<-(nir-red)/(nir+red)

nir84<-p84$p193r32_1984_SR_B4
red84<-p84$p193r32_1984_SR_B3
ndvi84<-(nir84-red84)/(nir84+red84)

nir19<-p19$p193r32_2019_SR_B4
red19<-p19$p193r32_2019_SR_B3
ndvi19<-(nir20-red19)/(nir19+red19)
par(mfrow=c(1,2))
plot(ndvi84)
plot(ndvi19)


nir20<-p20$p193r32_2020_SR_B4
red20<-p20$p193r32_2020_SR_B3
ndvi20<-(nir20-red20)/(nir20+red20)


#Generazione dei plot RGB

p84p<-plotRGB(p84, r=4, g=3, b=2, stretch="lin")
p85p<-plotRGB(p85, r=4, g=3, b=2, stretch="lin")
p87p<-plotRGB(p87, r=4, g=3, b=2, stretch="lin")
p88p<-plotRGB(p88, r=4, g=3, b=2, stretch="lin")
p89p<-plotRGB(p89, r=4, g=3, b=2, stretch="lin")
p90p<-plotRGB(p90, r=4, g=3, b=2, stretch="lin")
p91p<-plotRGB(p91, r=4, g=3, b=2, stretch="lin")
p92p<-plotRGB(p92, r=4, g=3, b=2, stretch="lin")
p93p<-plotRGB(p93, r=4, g=3, b=2, stretch="lin")
p95p<-plotRGB(p95, r=4, g=3, b=2, stretch="lin")
p96p<-plotRGB(p96, r=4, g=3, b=2, stretch="lin")
p97p<-plotRGB(p97, r=4, g=3, b=2, stretch="lin")
p99p<-plotRGB(p99, r=4, g=3, b=2, stretch="lin")
p00p<-plotRGB(p00, r=4, g=3, b=2, stretch="lin")
p01p<-plotRGB(p01, r=4, g=3, b=2, stretch="lin")
p02p<-plotRGB(p02, r=4, g=3, b=2, stretch="lin")
p03p<-plotRGB(p03, r=4, g=3, b=2, stretch="lin")
p06p<-plotRGB(p06, r=4, g=3, b=2, stretch="lin")
p07p<-plotRGB(p07, r=4, g=3, b=2, stretch="lin")
p10p<-plotRGB(p10, r=4, g=3, b=2, stretch="lin")
p13p<-plotRGB(p13, r=4, g=3, b=2, stretch="lin")
p14p<-plotRGB(p14, r=4, g=3, b=2, stretch="lin")
p15p<-plotRGB(p15, r=4, g=3, b=2, stretch="lin")
p16p<-plotRGB(p16, r=4, g=3, b=2, stretch="lin")
p17p<-plotRGB(p17, r=4, g=3, b=2, stretch="lin")
p18p<-plotRGB(p18, r=4, g=3, b=2, stretch="lin")
p19p<-plotRGB(p19, r=4, g=3, b=2, stretch="lin")
p20p<-plotRGB(p20, r=4, g=3, b=2, stretch="lin")
p21p<-plotRGB(p21, r=4, g=3, b=2, stretch="lin")

grid.arrange(p84p, p85p, p87p, p88p, p89p, p90p, p91p, p92p, p93p, p95p, p96p, p97p, p99p, p00p, p01p, p02p, p03p, p06p, p07p, p10p, p13p, p14p, p15p, p16p, p17p, p18p, p19p, p20p, p21p, nrow=6, ncol=6)


#a questo punto abbiamo le immagini composte dalle 7 bande Landsat dal 2013-2021

#plot dell'immagine e crop per avere lo zoom sull'Asinara
plotRGB(p193r32_2014, 4, 3, 2, stretch="lin") #immagine completa

#ora uso la funzione crop per tagliare l'immagine e fare lo zoom sull'area di interesse
#extent     : 425985, 449085, 4532895, 4557075  (xmin, xmax, ymin, ymax)
#extent     : 429435, 448155, 4531395, 4557645  (xmin, xmax, ymin, ymax)
p193r32_2014c<-crop(p193r32_2014, extent(425985, 449085, 4532895, 4557075))

plotRGB(p193r32_2014c, 5,3,2, stretch="lin")

