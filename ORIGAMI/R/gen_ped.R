#' gen_ped
#'
#' This function is for generate ped files for pseudo babies in the format familyID familyID_i
#' @param familyID Your cohort name.
#' @param num_sibling The number of pseudo sibling you gamete
#' @param out_path The path of output file
#' @keywords gen
#' @export
#' 
gen_ped = function(familyID,output_path,num_sibling){
data1<-utils::read.table(familyID,header=F)
famID<-unlist(data1)
indiID<-rep(1:num_sibling,times=length(famID))
familyID<-rep(famID,each=as.numeric(num_sibling))
individualID<-paste(familyID,indiID,sep="_")
data_fin<-data.frame(familyID,individualID)
utils::write.table(data_fin,output_path,quote = F,row.names = F,col.names = F)
}
