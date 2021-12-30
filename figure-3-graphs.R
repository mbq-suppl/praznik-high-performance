library(praznik)
library(igraph)
#NOTE: Requires graphviz installed

graph_from_adjacency_matrix(
 miMatrix(iris,iris$Species),
 mode="undirected",weighted=TRUE
)->subfig_a_mi

graph_from_adjacency_matrix(
 cmiMatrix(iris,iris$Species),
 mode="undirected",weighted=TRUE
)->subfig_b_cmi

graph_from_adjacency_matrix(
 dnmiMatrix(iris),
 mode="directed",weighted=TRUE
)->subfig_c_dnmi

graph_from_adjacency_matrix(
 jmiMatrix(iris,iris$Species),
 mode="directed",weighted=TRUE
)->subfig_d_jmi

# Rendering using Graphviz

makeDot<-function(w,file){
 if(length(edge_attr(w))>0){
  s<-edge_attr(w,"weight")
  edge_attr(w,"penwidth")<-(s-min(s))/diff(range(s))*5.8+0.2
 }
 if(length(vertex_attr(w))>0){
  vertex_attr(w,"label")<-gsub('\\.','\n',gsub('_','-',vertex_attr(w,"name")))
  vertex_attr(w,"style")<-"filled"
 }
 graph_attr(w,"overlap")<-"scale"
 graph_attr(w,"overlap_shrink")<-"true"
 graph_attr(w,"splines")<-"true"
 write_graph(w,file,"dot")
}

render<-function(x,file="test.pdf",type="pdf",algo="neato"){
 tempfile()->tf
 makeDot(x,tf)
 system(sprintf('%s %s -T%s > %s',algo,tf,type,file))
}

render(subfig_a_mi,"figure-3a-mi.pdf")
render(subfig_b_cmi,"figure-3b-cmi.pdf")
render(subfig_c_dnmi,"figure-3c-dnmi.pdf")
render(subfig_d_jmi,"figure-3d-jmi.pdf")

