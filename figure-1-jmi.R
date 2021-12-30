library(ggplot2)

#Please run bench.R to recreate bench_jmi.RDS

readRDS('bench_jmi.RDS')->a
data.frame(
 time=sapply(a,function(x) median(x$time)),
 threads=96:1
)->X
X$speedup<-with(X,time[threads==1]/time)

plt<-ggplot(X,aes(x=threads,y=speedup))+
 geom_vline(xintercept=48,col="gray")+
 geom_abline(slope=1,intercept=0)+
 xlab("Threads")+ylab("Speed-up relative to a single thread")+
 geom_point()+theme_classic()

ggsave("figure-1-jmi.pdf")
