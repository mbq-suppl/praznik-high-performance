library(praznik)
library(FSelectorRcpp)
library(microbenchmark)
library(infotheo)

TIMES<-3
CORES<-min(8,parallel::detectCores())

data(MadelonD)
lapply(CORES,function(th){
 with(MadelonD,
  microbenchmark(
   miScores(X,Y,th=th),
#   information_gain(x=X,y=Y,th=th), #FSelector seems to be unstable
   times=TIMES
 ))
})->multi_core

with(MadelonD,
 microbenchmark(
  miScores(X,Y,th=1),
  information_gain(x=X,y=Y,th=1),
  sapply(X,mutinformation,Y),
  times=TIMES
))->single_core

sapply(lapply(multi_core,summary,unit='s'),'[[','median')->mc
rbind(mc,NA,NA)->mc
cbind(summary(single_core,unit='s')$median,mc)->A
rownames(A)<-c("praznik","FSelectorRcpp","infotheo")
colnames(A)<-sprintf("c%d",c(1,CORES))

saveRDS(A,file="mi-scores-tab.RDS")
print(A)

with(MadelonD,
 microbenchmark(
  miMatrix(X,th=1),
  sapply(X,function(Y) information_gain(X,Y,th=1)),
  mutinformation(X),
  times=TIMES
))->matrix_single_core

lapply(CORES,function(th){
 with(MadelonD,
  microbenchmark(
   miMatrix(X,th=th),
   times=TIMES
 ))
})->matrix_multi_core

sapply(lapply(matrix_multi_core,summary,unit='s'),'[[','median')->mc
rbind(mc,NA,NA)->mc
cbind(summary(matrix_single_core,unit='s')$median,mc)->B
rownames(B)<-c("praznik","FSelectorRcpp","infotheo")
colnames(B)<-sprintf("c%d",c(1,CORES))

saveRDS(B,file="mi-matrix-tab.RDS")
print(B)
