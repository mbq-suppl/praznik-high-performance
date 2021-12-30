library(praznik)
library(Boruta)
library(randomForest)
library(gbm)

data(MadelonD)

pm<-c("CMI","MIM","MRMR","CMIM","JMI","DISR","JMIM","NJMIM")
lapply(
 pm,
 function(met){
  do.call(met,list(MadelonD$X,MadelonD$Y,k=20))->ans
  names(ans$selection)
 }
)->selections
names(selections)<-pm

set.seed(1)
with(MadelonD,Boruta(X,Y))->mod_bor
getSelectedAttributes(mod_bor)->sel_bor

selections$Bor<-sel_bor

set.seed(1)
with(MadelonD,randomForest(X,Y))->mod_rf
importance(mod_rf)->imp_rf
names(tail(sort(imp_rf[,1]),20))->sel_rf

selections$RF<-sel_rf

set.seed(1)
with(MadelonD,gbm((Y=="1")~.,data=X,'adaboost'))->mod_gbm
relative.influence(mod_gbm)->imp_gbm
names(which(imp_gbm>0))->sel_gbm

selections$GBM<-sel_gbm

true<-grep("^Rel",names(MadelonD$X),value=TRUE)
sapply(selections,function(x) true%in%x)->tab
sapply(selections,function(x) length(setdiff(x,true)))->FP
rownames(tab)<-true
TP<-colSums(tab)

data.frame(tab)->tab
rowSums(tab)->tab$SC
tab[order(-tab$SC),]->tab

data.frame(rbind(TP,FP))->positives

saveRDS(list(tab,positives),file='selections-tab.RDS')

print(tab)
print(positives)

