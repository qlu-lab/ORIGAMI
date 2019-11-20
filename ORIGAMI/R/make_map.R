### map BP and rsid together
make_map = function(cohort,chr,ref_file,rs_file,output_path){
  options(stringsAsFactors = F)
    data = data.table::fread(rs_file,header=T)
    ref = data.table::fread(ref_file,header= F)

    #select targeted col for MAP format
    data = data[,c("CHR","SNP","SNP","BP")]

    #select chr
    data = data[which(data[,"CHR"]==as.numeric(chr)),]

    #correct the order
    data = data[match(ref$V3,data$BP),]
    data.table::fwrite(data,file=output_path,sep = "\t",row.names=FALSE,col.names=FALSE,quote =F)
}
