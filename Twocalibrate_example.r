#===============================================================
#  calibration and comparison of uncertainty scores
#  Does drop out generate good uncertainties?
#...............................................................
#

Sys.setenv(http_proxy="http://proxyout.lanl.gov:8080")
Sys.setenv(https_proxy="http://proxyout.lanl.gov:8080")

require(splines)
require(glmnet)
require(qut)
require(flare)
require(Rfast)
require(parallel)
require(foreach)
require(doParallel)

registerDoParallel(cores=8)

#...............................................................
# input the data
rm( list=ls() )
setwd("~/LANL/Current/NCI-P1/ICML2020/ICML_Analysis")

ffiles <- list.files(recursive = T, 
                     full.names = T, 
                     pattern = "txt")



#--------------------------------------------------------------------
# dataset names and model type
  datasets <- sapply(strsplit(ffiles,"/"),FUN=function(x) x[2])
  model.type <- rep("hom",length(ffiles))
  idx <- grep("het",ffiles)
  model.type[ idx ] <- "het"

pdf(file="calibration.pdf")
  
#  pick a dataset
  for ( dat.name in unique(datasets) ){
#  dat.name <- "energy"
  
  
  idx.data <- grepl(dat.name,datasets)
  idx.hom <- model.type == "hom"
  idx.het <- model.type == "het"

# read the datasets
#... homogeneuous model
  dat.hom <- read.table( ffiles[ idx.data & idx.hom ],
                          header = F,
                          sep = " ")
  names(dat.hom) <- c("true",paste("E",1:200,sep="."))
  rep.hom <- 2:201

#... heterogeneuous model
  dat.het <- read.table( ffiles[ idx.data & idx.het ],
                        header = F,
                        sep = " ")
  names(dat.het) <- c("true", as.vector( outer( c("E","S"),1:200, paste, sep=".") ) )
  rep.het <- rep(1:200, rep(2,200)) + 1  


#................
#  response
  Y <- dat.het$true

#................    
# Score S1 mean abs dev of hetero pred 
  idxE <- grep("E.",colnames(dat.het))
  fbar.het <- apply( dat.het[,idxE],1,median )
  nc <- length(idxE)
  nr <- length(fbar.het)
  Mbar <- matrix( fbar.het, nr,nc )
  S1 <- apply( abs( dat.het[,idxE]-Mbar ),1,median )

# Score S2 is median of sd
  idxS <- grep("S.",colnames(dat.het))
  S2 <- apply( exp(dat.het[,idxS]/2),1,median )
  
# Score S3 is mean abs of homo
  idxE <- grep("E.",colnames(dat.hom))
  fbar.hom <- apply( dat.hom[,idxE],1,median )
  nc <- length(idxE)
  nr <- length(fbar.hom)
  Mbar <- matrix( fbar.hom, nr,nc )
  S3 <- apply( abs( dat.hom[,idxE]-Mbar ),1,median )
  
#.....
# Loss
  Z2 <- abs( Y - fbar.hom )   # for homogeneaous model
  Z1 <- abs( Y - fbar.het )   # for heterogeneous model
  
#######################################################
# Calibration (using ranks)

    
  x1 <- rank(S1,ties.method = "random")
  s1 <- sort.list(x1)
  z1 <- Z1[s1]
  xs1 <- sort(x1)
  ss1 <- smooth.spline(xs1,z1,
                       cv=T)
                       #df=4) 
  f1 <- fitted(ss1)
  
  x2  <- rank(S2,ties.method = "random")
  s2  <- sort.list(x2)
  z2  <- Z1[s2]
  xs2 <- sort(x2)
  ss2 <- smooth.spline(xs2,z2,
                       cv=T)                       
                       #df=4)
  f2 <- fitted(ss2)
  
  x3 <- rank(S3,ties.method = "random")
  s3 <- sort.list(x3)
  z3 <- Z2[s3]
  xs3 <- sort(x3)
  ss3 <- smooth.spline(xs3,z3,
                       cv=T)                       
                       #df=4)
  f3 <- fitted(ss3)  

#........................
#  make plots
  mm <- max(c(f1,f2,f3))
  plot(x1,fitted(ss1),pch=20,cex=0.1,ylim=c(0,mm),
       xlab="stardardized score",
       ylab="calibrated score",
       type="n",
       sub=dat.name)
  legend(0.05,0.8*mm,c("S1","S2","S3"),lwd=3,col=c(3,2,1))
  
  lines(xs1,f1,col=1,lwd=2)
  lines(xs2,f2,col=2,lwd=2)
  lines(xs3,f3,col=3,lwd=2)
  
}  
  graphics.off()
  

  
  
  


