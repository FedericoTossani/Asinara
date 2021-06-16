## Time-lapsing biodiversity: an open source method for measuring diversity changes by remote sensing
## Authors: Matteo Marcantonio, Daniele Da Re, Duccio Rocchini

## Set working directory and load libraries 
setwd("/home/TemporalAlfaDiv/")
library(raster)
library(parallel)
library(fANCOVA) # To automatically select loess smoothing parameters select using aicc
library(ggplot2)
library(rasterVis)
library(plyr)
library(RColorBrewer)
library(gtable)    
library(grid)
library(gridExtra)
library(ggpubr)

#### 1. Load data ####
load("/home/TemporalAlfaDiv/all_raoQ_5km.RData")
rao_stack<-stack(rao2000_5km, rao2001_5km ,rao2002_5km ,rao2003_5km ,rao2004_5km ,rao2005_5km,
                 rao2006_5km, rao2007_5km, rao2008_5km, rao2009_5km, rao2010_5km, rao2011_5km,
                 rao2012_5km, rao2013_5km, rao2014_5km, rao2015_5km, rao2016_5km)

s<-as.list(rao_stack)

##Cut on Italy
s_red<-mclapply(s, function(x) {y=crop(x,extent(0,20,36,50)); return(y)},mc.cores=detectCores())

##Derive values from raster and put them in a 3D array
rao<-mclapply(s_red,trim,mc.cores=8)
raoV<-mclapply(rao,getValues, mc.cores=8)
raoA<-array(as.numeric(unlist(raoV)), dim=c(336, 275, 17))

#### 2. Apply loess on the time series ####
#Loess smoothing parameters are automatically selected using aicc 
#The derivative of a function is dy/dx, which can be approximated by Δy/Δx, that is, "change in y over change in x". This can be written in R using diff function
#in order to get an approximation to the derivative of the function at each x

stats<-c("mean","min","max")
xl<-seq(2000:2016)
outl <- rep( list(matrix(nrow=336, ncol=275)),3 )
prd <- array( as.numeric(NA), dim=c(336, 275, 17) )

for (r in 1:336) {
  options(warn=-1)
  for (c in 1:275) {
    if(any(is.na(raoA[r,c,]))) {
      next()
    } else {
      prd[r,c,]<-predict(loess.as(seq(1:17), raoA[r,c,],criterion = c("aicc"), degree=1, plot = F))	
      for (s in 1:3) {
        outl[[s]][r,c]<-sapply(list(diff(prd[r,c,])/diff(xl)),get(stats[s]),na.rm=T)
      }
    }
  }
  options(warn=0)
}

##Make an output raster map
raoTslopes <- stack(s_red[[1]],s_red[[1]],s_red[[1]])

##Add mean, min and max matrices
raoTslopes_out <- stack(lapply(1:3, function(x) {
  values(raoTslopes[[x]])<-as.numeric(outl[[x]]);
  names(raoTslopes[[x]])<-c("mean","min","max")[x];
  return(raoTslopes[[x]])
}))

plot(raoTslopes_out)

## Compute coefficient of variation 
rao_stack_it<-crop(rao_stack, extent(0,20,36,50))
rao_stack_it<-stack(rao_stack_it)
rao_mean<-calc(rao_stack_it, mean)
rao_sd<-calc(rao_stack_it, sd)
rao_CV<-((rao_sd)/(1+rao_mean))*100
names(rao_CV)<-"rao_CV"

raoTslopes_out<-stack(raoTslopes_out, rao_CV)
plot(raoTslopes_out)

##save rasters
stackSave(raoTslopes_out, "raoTslopes")

#### 3. plot ####
##violin plot
v1<-bwplot(rao_stack,  horizontal=FALSE, main="RAO's Q MODIS 2000-2016",
           scales=list(x=list(labels=c("2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016")))
)

tiff( "/home/TemporalAlfaDiv/img/rao_ndvi_modis_vioplot.tiff", height=8, width=12, units="in", res=300 )
v1
dev.off()

##plot parameters
pal<-brewer.pal(9,"YlGnBu")
myTheme <- rasterTheme(region = pal)

utm32n<-" +proj=utm +zone=32 +ellps=WGS84 +datum=WGS84 +units=m +no_defs +towgs84=0,0,0"
crs(raoTslopes_out)<-"+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"
raoTslopes_out<-projectRaster(raoTslopes_out, crs=utm32n)
p1<-levelplot(abs(raoTslopes_out[[1]]),  main= "Mean", scales=list(draw=FALSE), contour = FALSE, margin = FALSE,  par.settings = myTheme,  ylab= "", xlab= "")
p2<-levelplot(raoTslopes_out[[2]], main= "Min",  scales=list(draw=FALSE), contour = FALSE, margin = FALSE,  par.settings = myTheme, ylab= "", xlab= "")
p3<-levelplot(raoTslopes_out[[3]], main= "Max",   scales=list(draw=FALSE), contour = FALSE, margin = FALSE,  par.settings = myTheme, ylab= "", xlab= "")
p4<-levelplot(abs(raoTslopes_out[[4]]), main= "CV",   scales=list(draw=FALSE), contour = FALSE, margin = FALSE,  par.settings = myTheme, ylab= "", xlab= "")

grid.arrange(p1,p2,p3,p4, nrow=2)
ggsave("raoRslopes.tiff",  height=8, width=12, units="in", dpi=300, plot= pp, path = "/home/TemporalAlfaDiv/img/")

#### Appendix: MODIS NDVI ####
load("/home/TemporalAlfaDiv/all_NDVI_5km.RData")
ndvi_stack<-stack(raster(NDVI_07_2000_5km),raster(NDVI_07_2001_5km), raster(NDVI_07_2002_5km), raster(NDVI_07_2003_5km),
                  raster(NDVI_07_2004_5km), raster(NDVI_07_2005_5km), raster(NDVI_07_2006_5km), raster(NDVI_07_2007_5km),
                  raster(NDVI_07_2008_5km), raster(NDVI_07_2009_5km), raster(NDVI_07_2010_5km), raster(NDVI_07_2011_5km),raster(NDVI_07_2012_5km), raster(NDVI_07_2013_5km), raster(NDVI_07_2014_5km), raster(NDVI_07_2015_5km),raster(NDVI_07_2016_5km))

crs(ndvi_stack)<-"+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0" 
ndvi_stack<-crop(ndvi_stack, extent(0,20,36,50))
ndvi_stack<-projectRaster(ndvi_stack, crs=utm32n)
annual_ndvi<-as.character(2000:2016)
rastNam<-as.character(2000:2016)

## violinplot
p11<-bwplot(ndvi_MODIS_ts, horizontal=FALSE, main="NDVI MODIS 2000-2016",   
           scales=list(x=list(labels=c("2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016")))
)

tiff( "/home/TemporalAlfaDiv/img/ndvi_modis_vioplot.tiff", height=8, width=12, units="in", res=300 )
p11
dev.off()

##Time-series plot
mapTheme <- rasterTheme(region=brewer.pal(8,"Greens"))
p12<-levelplot(ndvi_stack,  xlab="", ylab="", scales=list(draw=FALSE),names.attr=rastNam,  
               layout=c(6, 3), contour = FALSE, margin = FALSE, par.settings = mapTheme, main= "NDVI 2000-2016")

tiff("img/ndvi2000-2016_GreenTheme.tiff", height = 10, width = 13, res=300,units="in")
p12
dev.off()
