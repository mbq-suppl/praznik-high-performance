library(microbenchmark)
library(praznik)
readRDS("dorothea.RDS")->D

TIMES<-10
CORES<-c(1:96)

lapply(rev(CORES),function(th){
 message("Threads are ",th)
 microbenchmark(
  JMI(D$X,D$Y,50,th=th),
  times=TIMES
 )
})->ans_jmi50

saveRDS(ans_jmi50,file="bench_jmi.RDS")

