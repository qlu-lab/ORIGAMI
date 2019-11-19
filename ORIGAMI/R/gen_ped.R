dir.create("/z/Comp/lu_group/Members/jiawen/ASD/ped")
gen_ped = function(familyID,output_path,num_sibling){
data1<-utils::read.table(familyID,header=F)
famID<-unlist(data1)
indiID<-rep(1:100,times=length(famID))
familyID<-rep(famID,each=as.numeric(num_sibling))
individualID<-paste(familyID,indiID,sep="_")
data_fin<-data.frame(familyID,individualID)
utils::write.table(data_fin,output_path,quote = F,row.names = F,col.names = F)
}
