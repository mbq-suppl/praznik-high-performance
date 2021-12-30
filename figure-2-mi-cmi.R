library(praznik)
library(ggplot2)
library(ggrepel)
data(MadelonD)

Q<-data.frame(
 MI=miScores(MadelonD$X,MadelonD$Y),
 CMI=cmiScores(MadelonD$X,MadelonD$Y,MadelonD$X$Rel7),
 Relevant=grepl("^Rel",names(MadelonD$X)),
 Feature=names(MadelonD$X)
)
Q$Feature[!Q$Relevant]<-NA
Q<-Q[order(Q$Relevant),]

pal<-function(n){
 stopifnot(n==2)
 c("gray","black")
}
scale_pal<-function(...) ggplot2::discrete_scale("colour","pal",pal,...)

a<-ggplot(Q,aes(x=MI,y=CMI,col=Relevant,label=Feature))+
 geom_abline(slope=1,intercept=0)+
 geom_point()+geom_label_repel()+
 xlab("I(Xi;Y)")+ylab("I(Xi;Y|Rel7)")+
 theme_classic()+theme(legend.position="none")+
 scale_pal()

ggsave("figure-2-mi-cmi.pdf")
