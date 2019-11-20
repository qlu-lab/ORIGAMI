### map BP and rsid together
make_map = function(cohort,chr,ref_file,rs_file,output_path){
  options(stringsAsFactors = F)
    data0 = data.table::fread(rs_file,header=T)
    ref = data.table::fread(ref_file,header= F)

    #select targeted col for MAP format
    data0 =as.data.frame(data0)
    data0 = data0[,c("CHR","SNP","SNP","BP")]

    #select chr
    data0 = data0[which(data0[,c("CHR")]==as.numeric(chr)),]

    #correct the order
    data0 = data0[match(ref$V3,data0$BP),]
    data.table::fwrite(data0,file=output_path,sep = "\t",row.names=FALSE,col.names=FALSE,quote =F)
}
